import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portoflio/constants/colors.dart';
import 'package:portoflio/screens/login_screen.dart';
import 'package:portoflio/services/signup_controller.dart';
import 'package:portoflio/widgets/custom_loader.dart';
import 'package:portoflio/widgets/custom_text_field.dart';
import 'package:portoflio/widgets/primary_button.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => controller.isLoading.value
                ? Center(child:  CustomLoader(size: 60,)) // Show loading indicator
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/splash_image.png",
                          height: 100,
                          width: 200,
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Please Create an Account!",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Name Field
                        CustomTextField(
                          hintText: "UserName",
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          ),
                          controller: controller.nameController,
                        ),
                        Obx(() => controller.nameError.value.isNotEmpty
                            ? Text(
                                controller.nameError.value,
                                style: TextStyle(color: Colors.red),
                              )
                            : SizedBox.shrink()),
                        
                        const SizedBox(height: 16),

                        // Email Field
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
                        Obx(() => controller.emailError.value.isNotEmpty
                            ? Text(
                                controller.emailError.value,
                                style: TextStyle(color: Colors.red),
                              )
                            : SizedBox.shrink()),

                        const SizedBox(height: 16),

                        // Phone Field
                        CustomTextField(
                          hintText: "Phone Number",
                          prefixIcon: Icon(
                            Icons.phone,
                            color: AppColors.primaryColor,
                          ),
                          controller: controller.phoneController,
                        ),
                        Obx(() => controller.phoneError.value.isNotEmpty
                            ? Text(
                                controller.phoneError.value,
                                style: TextStyle(color: Colors.red),
                              )
                            : SizedBox.shrink()),

                        const SizedBox(height: 16),

                        // Password Field
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
                        Obx(() => controller.passwordError.value.isNotEmpty
                            ? Text(
                                controller.passwordError.value,
                                style: TextStyle(color: Colors.red),
                              )
                            : SizedBox.shrink()),

                        const SizedBox(height: 80),

                        PrimaryButton(
                          title: "SignUp",
                          icon: Icons.create,
                          ontap: () {
                            controller.registerUser();
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () {
                                Get.to(() => LoginScreen());
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
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
        ),
      ),
    );
  }
}
