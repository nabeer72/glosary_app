import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portoflio/Models/user_model.dart';
import 'package:portoflio/screens/login_screen.dart';

class SignUpController extends GetxController {
  final isPasswordVisible = false.obs;
   void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isLoading = false.obs;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  
  var nameError = "".obs;
  var emailError = "".obs;
  var phoneError = "".obs;
  var passwordError = "".obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  var fireStore = FirebaseFirestore.instance;

  bool validateForm() {
    bool isValid = true;

    // Validate name
    if (nameController.text.isEmpty) {
      nameError.value = "Name is required";
      isValid = false;
    } else {
      nameError.value = "";
    }

    // Validate email
    if (emailController.text.isEmpty) {
      emailError.value = "Email is required";
      isValid = false;
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
      emailError.value = "Enter a valid email";
      isValid = false;
    } else {
      emailError.value = "";
    }

    // Validate phone
    if (phoneController.text.isEmpty) {
      phoneError.value = "Phone number is required";
      isValid = false;
    } else {
      phoneError.value = "";
    }

    // Validate password
    if (passwordController.text.isEmpty) {
      passwordError.value = "Password is required";
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError.value = "Password must be at least 6 characters";
      isValid = false;
    } else {
      passwordError.value = "";
    }

    return isValid;
  }

  Future<void> registerUser() async {
    if (!validateForm()) return; // Stop if validation fails

    isLoading.value = true;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      
      if (userCredential.user != null) {
        userCredential.user!.sendEmailVerification();
        Get.snackbar("Success", "Verification email sent to ${emailController.text}");
        
        UserModel userData = UserModel(
          uid: auth.currentUser!.uid,
          username: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
        );
        
        await fireStore
            .collection("Users")
            .doc(auth.currentUser!.uid)
            .set(userData.toMap());
        
        Get.offAll(LoginScreen()); // Navigate to login screen after signup
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "An error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
