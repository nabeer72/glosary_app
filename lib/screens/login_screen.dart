import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portoflio/constants/colors.dart';
import 'package:portoflio/screens/forget_password_screen.dart';
import 'package:portoflio/screens/signup_screen.dart';
import 'package:portoflio/services/login_controller.dart';
import 'package:portoflio/widgets/custom_loader.dart';
import 'package:portoflio/widgets/custom_text_field.dart';
import 'package:portoflio/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CustomLoader(size: 60,))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: Image.asset(
                          "images/splash_image.png", 
                          height: 100, 
                          width: 200
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center, // Center the content
                            children: [
                              Text(
                                "Welcome to ",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.fontColor,
                                ),
                              ),
                              Text(
                                "Grocery Plus",
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Please Login to your Account!",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.fontGrayColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.mail, color: AppColors.primaryColor),
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return "Email is required";
                                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return "Enter a valid email";
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => CustomTextField(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
                                  controller: controller.passwordController,
                                  obscureText: !controller.isPasswordVisible.value,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: controller.togglePasswordVisibility,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return "Password is required";
                                    if (value.length < 6) return "Password must be at least 6 characters";
                                    return null;
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () => Get.to(() => ForgetPasswordScreen()),
                                  child: const Text("Forget Password?"),
                                ),
                              ),
                              const SizedBox(height: 50),
                              PrimaryButton(
                                title: "Login",
                                icon: Icons.arrow_forward,
                                ontap: controller.loginUser,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an Account?"),
                                  const SizedBox(width: 6),
                                  InkWell(
                                    onTap: () {Get.to(() => SignUpScreen());} ,
                                    child: Text(
                                      "SignUp",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
