import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final int maxLines;
  final Widget? suffixIcon;
  final Function()? ontap;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    this.obscureText = false,
    required this.hintText,
    this.maxLines = 1,
    this.prefixIcon,
    required this.controller,
    this.suffixIcon,
    this.ontap,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: obscureText ? 1 : maxLines,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: const Color(0xffF0F1F2),
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
