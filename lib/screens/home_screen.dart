import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portoflio/screens/upload_items.dart';
import 'package:portoflio/services/home_controller.dart';
import 'package:portoflio/widgets/custom_text_field.dart';
import 'package:portoflio/widgets/home_card_widget.dart';
import 'package:portoflio/widgets/location_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => UploadItems()));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Grocery Plus",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.notifications_outlined)
                ],
              ),
              const SizedBox(height: 10),
              const LocationWidget(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              CustomTextField(
                  hintText: "Search here",
                  prefixIcon: const Icon(Icons.search),
                  controller: controller.searchController),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  itemCount: controller.item.vegtable.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return HomeCardWidget(
                      imageUrl: controller.item.vegtable[index]['image'],
                      title: controller.item.vegtable[index]['title'],
                      rating: controller.item.vegtable[index]['rating'],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
