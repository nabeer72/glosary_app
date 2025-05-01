import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/grocery_model.dart';

class ProductDetailController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  var inWishList = false.obs;

  late Items item;

  void setItem(Items i) {
    item = i;
    checkWishList();
  }

  Future<void> addToCart() async {
    isLoading.value = true;
    try {
      await firestore
          .collection("Users")
          
          .doc(auth.currentUser!.uid)
          .collection('cartItems')
          .doc(item.productId)
          .set(item.toJson());
      Get.snackbar("Success", "Item added to cart");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToWishList() async {
    isLoading.value = true;
    try {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(item.productId)
          .set(item.toJson());
      inWishList.value = true;
      Get.snackbar("Success", "Item added to wishlist");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromWishList() async {
    isLoading.value = true;
    try {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(item.productId)
          .delete();
      inWishList.value = false;
      Get.snackbar("Success", "Item removed from wishlist");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkWishList() async {
    try {
      var docSnapshot = await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(item.productId)
          .get();
      inWishList.value = docSnapshot.exists;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
