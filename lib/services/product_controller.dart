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

  // Quantity counter
  RxInt quantity = 1.obs;

  void setItem(Items i) {
    item = i;
    checkWishList();
  }

  // Add item to cart with selected quantity
  Future<void> addToCartWithQuantity() async {
    isLoading.value = true;
    try {
      final cartData = item.toJson();
      cartData['quantity'] = quantity.value;

      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection('cartItems')
          .doc(item.productId)
          .set(cartData);

      Get.snackbar("Success", "${item.name} x${quantity.value} added to cart");

      quantity.value = 1;  // ✅ Reset the counter after adding
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Add to cart with default quantity (1)
  Future<void> addToCart() async {
    isLoading.value = true;
    try {
      final cartData = item.toJson();
      cartData['quantity'] = 1; // default quantity

      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection('cartItems')
          .doc(item.productId)
          .set(cartData);

      Get.snackbar("Success", "Item added to cart");

      quantity.value = 1;  // ✅ Reset the counter after adding
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Add to wishlist
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

  // Remove from wishlist
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

  // Check if item is in wishlist
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

  // Increase quantity
  void increaseQuantity() {
    quantity++;
  }

  // Decrease quantity (min 1)
  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
