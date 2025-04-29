import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:portoflio/services/profile_controller.dart';
import 'package:portoflio/widgets/custom_loader.dart';
import 'package:portoflio/widgets/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body:Obx((){
        return  controller.isLoading.value
                ? Center(child: CustomLoader(size: 60,))
                : SafeArea(
        child: Stack(
          children: [
            // Animated Gradient Background
            AnimatedContainer(
              duration: const Duration(seconds: 5),
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff5EC401), Color(0xff3A8F00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CustomLoader(size: 60));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        // Reusable Profile Header
                        ProfileHeaderWidget(
                          profilePicUrl: controller.profilePicUrl.value,
                          userName: controller.userName.value,
                          userEmail: controller.userEmail.value,
                        ),
                        const SizedBox(height: 40),
                        // Reusable Glassmorphic Card
                        GlassmorphicCardWidget(
                          children: [
                            AnimatedListTileWidget(
                              icon: Icons.person,
                              title: "Edit Profile",
                              onTap: () {
                                // Navigate to Edit Profile Screen
                              },
                            ),
                            const CustomDividerWidget(),
                            AnimatedListTileWidget(
                              icon: Icons.settings,
                              title: "Settings",
                              onTap: () {
                                // Navigate to Settings Screen
                              },
                            ),
                            const CustomDividerWidget(),
                            AnimatedListTileWidget(
                              icon: Icons.help_outline,
                              title: "Help & Support",
                              onTap: () {
                                // Navigate to Help & Support
                              },
                            ),
                            const CustomDividerWidget(),
                            AnimatedListTileWidget(
                              icon: Icons.logout,
                              title: "Logout",
                              titleColor: Colors.redAccent,
                              iconColor: Colors.redAccent,
                              onTap: () {
                                controller.logout();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      );
      })
    );
  }
}