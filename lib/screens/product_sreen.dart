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
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Product Detail"),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CustomLoader())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Image with heart icon on top-right without using Stack
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.fontColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://media.istockphoto.com/id/589415708/photo/fresh-fruits-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=HuL0PWV7DOxpHzlHLMZfWGvMpmpA05gYoc6XS6HkX3Y=",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Name and price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.item.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        controller.item.price,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  // Description
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      controller.item.descritpion,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),

                  Spacer(),

                  // Bottom row (Add to Cart & Buy Now)
                  Row(
                    children: [
                      InkWell(
                        onTap: controller.addToCart,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.fontColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(Icons.shopping_cart_checkout),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: PrimaryButton(
                          title: "Buy Now",
                          ontap: () {},
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
