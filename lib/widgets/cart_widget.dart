import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portoflio/Models/grocery_model.dart';

class CartWidget extends StatelessWidget {
  final Items items;
  final Function() onDelete;

  const CartWidget({super.key, required this.items, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                 "https://media.istockphoto.com/id/589415708/photo/fresh-fruits-and-vegetables.jpg?s=2048x2048&w=is&k=20&c=HuL0PWV7DOxpHzlHLMZfWGvMpmpA05gYoc6XS6HkX3Y=",
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items.name,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      items.descritpion,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
