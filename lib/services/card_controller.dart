import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/grocery_model.dart';

class CartController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var cartItems = <Items>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  void fetchCartItems() {
    try {
      isLoading.value = true;
      _firestore
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .collection("cartItems")
          .snapshots()
          .listen((snapshot) {
        cartItems.value =
            snapshot.docs.map((doc) => Items.fromMap(doc.data())).toList();
        isLoading.value = false;
      });
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }
  

  Future<void> deleteCartItem(String productId) async {
    try {
      await _firestore
          .collection("Users")
          .doc(_auth.currentUser!.uid)
          .collection('cartItems')
          .doc(productId)
          .delete();
    } catch (e) {
      error.value = e.toString();
    }
  }
}
