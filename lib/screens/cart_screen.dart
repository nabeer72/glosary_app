import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portoflio/services/card_controller.dart';
import 'package:portoflio/widgets/cart_widget.dart';
import 'package:portoflio/widgets/custom_loader.dart';
import 'package:portoflio/widgets/primary_button.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Cart"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: PrimaryButton(
            title: "Buy Now", icon: Icons.shopping_bag, ontap: () {}),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CustomLoader());
            }
            if (controller.error.isNotEmpty) {
              return Center(
                child: Text("Error: ${controller.error.value}"),
              );
            }
            if (controller.cartItems.isEmpty) {
              return const Center(
                child: Text("No items in cart"),
              );
            }
            return ListView.builder(
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                var item = controller.cartItems[index];
                return CartWidget(
                  items: item,
                  onDelete: () {
                    controller.deleteCartItem(item.productId);
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
