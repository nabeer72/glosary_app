import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portoflio/services/profile_controller.dart';
import 'package:portoflio/widgets/custom_loader.dart'; // Import the custom loader widget

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CustomLoader(size: 60)); // Show loader while fetching data
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Header with Background Gradient
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xff5EC401),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Profile Picture or Default Icon
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100), // Circular Profile Picture
                            child: controller.profilePicUrl.value.isNotEmpty
                                ? Image.network(
                                    controller.profilePicUrl.value,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.account_circle,
                                    size: 120,
                                    color: Colors.white70, // Default icon color
                                  ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            controller.userName.value,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.userEmail.value,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Profile Details Card
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Additional Info or Settings
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Color(0xff5EC401),
                            ),
                            title: Text("Edit Profile"),
                            onTap: () {
                              // Navigate to Edit Profile Screen (not implemented here)
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: Color(0xff5EC401),
                            ),
                            title: Text("Settings"),
                            onTap: () {
                              // Navigate to Settings Screen (not implemented here)
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.help_outline,
                              color: Color(0xff5EC401),
                            ),
                            title: Text("Help & Support"),
                            onTap: () {
                              // Navigate to Help & Support Screen (not implemented here)
                            },
                          ),
                          Divider(),
                          // Logout Button
                          ListTile(
                            leading: Icon(Icons.logout, color: Colors.redAccent),
                            title: Text(
                              "Logout",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            onTap: () {
                              controller.logout();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
