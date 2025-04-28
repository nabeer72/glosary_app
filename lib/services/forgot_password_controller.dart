import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  var isLoading = false.obs;
  final auth = FirebaseAuth.instance;

  Future<void> sendLinkForResetPassword() async {
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Your Email",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      await auth.sendPasswordResetEmail(email: emailController.text);
      Get.snackbar("Success", "Password Reset Link Sent Successfully",
          snackPosition: SnackPosition.BOTTOM);
      Get.back(); // Navigate back
    } on FirebaseAuthException catch (e) {
      debugPrint("This is the error: ${e.code}");
      Get.snackbar("Error", e.message ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
