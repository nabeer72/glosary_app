import 'package:flutter/material.dart';
import 'package:portoflio/widgets/cart_widget.dart';
import 'package:portoflio/widgets/primary_button.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: PrimaryButton(
            title: "Buy Now", icon: Icons.shopping_bag, ontap: () {}),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CartWidget();
                })),
      ),
    );
  }
}
