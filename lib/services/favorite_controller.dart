import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Models/grocery_model.dart';

class FavoriteController extends GetxController {
  var firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  // Get wishlist items as a stream
  Stream<List<Items>> getWishListItems() {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection("wishList")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Items.fromMap(doc.data())).toList());
  }

  // Delete wishlist item
  Future<void> deleteWishListItem(String productId) async {
    try {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(productId)
          .delete();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Add to cart & remove from wishlist
  Future<void> addToCart(Items item) async {
    isLoading.value = true;
    try {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection('cartItems')
          .doc(item.productId)
          .set(item.toJson());

      await deleteWishListItem(item.productId);

      Get.snackbar("Success", "Item moved to cart");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
