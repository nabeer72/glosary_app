import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:portoflio/Models/grocery_model.dart';
import 'package:portoflio/widgets/favorite_card_widget.dart';
import 'package:portoflio/widgets/custom_loader.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var inWishList = false.obs;

  late Items item;

  Stream<List<Items>> getWishListItems() {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection("wishList")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Items.fromMap(doc.data())).toList());
  }

  Future<void> deleteWishListItem(String productId) async {
    try {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(productId)
          .delete();
    } catch (e) {
      debugPrint(e.toString());
    }
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

         await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection('wishList')
        .doc(item.productId)
        .delete();

    Get.snackbar("Success", "Item moved to cart");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: StreamBuilder<List<Items>>(
          stream: getWishListItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoader());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No items in favorites"),
              );
            }
            final wishListItems = snapshot.data!;
            return ListView.builder(
              itemCount: wishListItems.length,
              itemBuilder: (context, index) {
                var item = wishListItems[index];
                return FavoriteCardWidget(
                  items: item,
                  onDelete: () {
                    deleteWishListItem(item.productId);
                  },
                  addToCart: () {
                    this.item = item; // Set the item to be added to cart
                    addToCart(); // Call the addToCart method
                  },

                );
              },
            );
          },
        ),
      ),
    );
  }
}
