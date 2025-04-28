import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portoflio/constants/colors.dart';
import 'package:portoflio/services/forgot_password_controller.dart';
import 'package:portoflio/widgets/custom_loader.dart';
import 'package:portoflio/widgets/custom_text_field.dart';
import 'package:portoflio/widgets/primary_button.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordController controller = Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CustomLoader(size: 60,))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      "images/splash_image.png",
                      height: 100,
                      width: 200,
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Please Enter Your Email Address",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: "Enter your email",
                      prefixIcon: Icon(
                        Icons.mail,
                        color: AppColors.primaryColor,
                      ),
                      controller: controller.emailController,
                    ),
                    const SizedBox(height: 250),
                    PrimaryButton(
                      title: "Send Mail",
                      icon: Icons.mail,
                      ontap: () {
                        controller.sendLinkForResetPassword();
                      },
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}
