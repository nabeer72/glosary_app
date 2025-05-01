import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portoflio/Models/grocery_model.dart';
import 'package:portoflio/constants/colors.dart';


class FavoriteCardWidget extends StatelessWidget {

  final Items items;
  final Function() onDelete;
  final Function() addToCart;

  const FavoriteCardWidget({super.key, required this.items, required this.onDelete, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "images/splash_image.png",
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    Text(
                      "Product Name",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Product Name",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                InkWell
             (
              onTap: onDelete,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap:addToCart ,
                  child: Icon(
                    Icons.shopping_cart,
                    color: AppColors.primaryColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
