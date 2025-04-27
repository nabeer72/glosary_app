import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portoflio/screens/bottom_Nav_bar.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final email = emailController.text.trim();
      final password = passwordController.text;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null && userCredential.user!.emailVerified) {
        Get.offAll(() => BottomNavBar());
      } else {
        Get.snackbar("Error", "User is not verified or doesn't exist");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", e.message ?? "Unknown error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
