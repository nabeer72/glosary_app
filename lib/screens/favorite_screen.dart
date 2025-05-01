import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portoflio/Models/grocery_model.dart';
import 'package:portoflio/services/favorite_controller.dart';
import 'package:portoflio/widgets/favorite_card_widget.dart';
import 'package:portoflio/widgets/custom_loader.dart';
class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final FavoriteController controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: StreamBuilder<List<Items>>(
          stream: controller.getWishListItems(),
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
            return Obx(() {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: wishListItems.length,
                    itemBuilder: (context, index) {
                      var item = wishListItems[index];
                      return FavoriteCardWidget(
                        items: item,
                        onDelete: () {
                          controller.deleteWishListItem(item.productId);
                        },
                        addToCart: () {
                          controller.addToCart(item);
                        },
                      );
                    },
                  ),
                  if (controller.isLoading.value)
                    const Center(child: CustomLoader()), // Show loader when busy
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
