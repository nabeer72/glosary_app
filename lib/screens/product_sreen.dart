import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portoflio/services/product_controller.dart';
import 'package:portoflio/widgets/custom_loader.dart';
import 'package:portoflio/widgets/primary_button.dart';
import 'package:portoflio/constants/colors.dart';
import '../Models/grocery_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Items items;
  ProductDetailScreen({super.key, required this.items});

  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    controller.setItem(items);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          "Product Detail",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CustomLoader())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with heart icon on top-right
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.fontColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              "https://media.istockphoto.com/id/589415708/photo/fresh-fruits-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=HuL0PWV7DOxpHzlHLMZfWGvMpmpA05gYoc6XS6HkX3Y=",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                controller.inWishList.value
                                    ? controller.removeFromWishList()
                                    : controller.addToWishList();
                              },
                              child: Obx(() => Icon(
                                    Icons.favorite,
                                    size: 28,
                                    color: controller.inWishList.value
                                        ? Colors.red
                                        : Colors.white,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Name & Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          controller.item.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        controller.item.price,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    controller.item.descritpion,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),

                  const SizedBox(height: 24),

                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Quantity:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: controller.decreaseQuantity,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.remove, size: 22),
                              ),
                            ),
                            Obx(() => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    controller.quantity.value.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                )),
                            InkWell(
                              onTap: controller.increaseQuantity,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.add, size: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Bottom Row: Add to Cart & Buy Now
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.addToCartWithQuantity();
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.fontColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(Icons.shopping_cart_checkout),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: PrimaryButton(
                          title: "Buy Now",
                          ontap: () {
                            // You can also pass the quantity here
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
    );
  }
}
