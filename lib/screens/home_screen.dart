import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portoflio/screens/product_sreen.dart';
import 'package:portoflio/screens/upload_items.dart';
import 'package:portoflio/services/home_controller.dart';
import 'package:portoflio/widgets/custom_loader.dart';
import 'package:portoflio/widgets/custom_text_field.dart';
import 'package:portoflio/widgets/home_card_widget.dart';
import 'package:portoflio/widgets/location_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Center(child: CustomLoader(size: 60))
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => UploadItems()));
              },
              child: Icon(Icons.add),
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grocery Plus",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Icon(Icons.notifications_outlined)
                    ],
                  ),
                  const SizedBox(height: 10),
                  LocationWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextField(
                      hintText: "Search here",
                      prefixIcon: Icon(Icons.search),
                      controller: controller.searchController),
                  const SizedBox(height: 12),
                  controller.itemsList.isEmpty
                      ? Text("There are no products to show")
                      : Expanded(
                          child: GridView.builder(
                              itemCount: controller.itemsList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 8,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                return HomeCardWidget(
                                  imageUrl:
                                      "https://media.istockphoto.com/id/589415708/photo/fresh-fruits-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=HuL0PWV7DOxpHzlHLMZfWGvMpmpA05gYoc6XS6HkX3Y=",
                                  title: controller.itemsList[index].name,
                                  rating: "0",
                                  ontap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) =>
                                                ProductDetailScreen(
                                                  items: controller
                                                      .itemsList[index],
                                                )));
                                  },
                                );
                              }),
                        ),
                ]),
              ),
            ),
          ));
  }
}
