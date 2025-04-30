import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portoflio/constants/colors.dart';
import 'package:portoflio/services/upload_iteam_controller.dart';
import 'package:portoflio/widgets/custom_loader.dart';
import 'package:portoflio/widgets/custom_text_field.dart';
import 'package:portoflio/widgets/primary_button.dart';

class UploadItems extends StatelessWidget {
  UploadItems({super.key});

  final UploadItemController controller = Get.put(UploadItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: controller.isLoading.value
                  ? const Center(child: CustomLoader(size: 60))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => controller.showImageSourceActionSheet(context),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.fontColor,
                                  width: 1,
                                ),
                              ),
                              child: controller.imageFile.value != null
                                  ? Image.file(
                                      File(controller.imageFile.value!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Icon(Icons.add_a_photo, size: 40),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: "Enter Product Name",
                            controller: controller.nameController,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: "Enter Product description",
                            controller: controller.diController,
                            maxLines: 4,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: "Enter Product price",
                            controller: controller.priceController,
                          ),
                          const SizedBox(height: 50),
                          PrimaryButton(
                            title: "Upload",
                            ontap: controller.uploadData,
                          ),
                        ],
                      ),
                    ),
            )),
      ),
    );
  }
}
