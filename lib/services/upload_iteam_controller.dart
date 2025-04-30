
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portoflio/Models/grocery_model.dart';
import 'package:portoflio/screens/bottom_Nav_bar.dart';
import 'package:portoflio/services/upload_function.dart';
import 'package:uuid/uuid.dart';

class UploadItemController extends GetxController {
  final nameController = TextEditingController();
  final diController = TextEditingController();
  final priceController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  Rx<XFile?> imageFile = Rx<XFile?>(null);
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? selectedImage = await picker.pickImage(source: source);
      if (selectedImage != null) {
        imageFile.value = selectedImage;
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

  Future<void> uploadData() async {
    if (imageFile.value == null ||
        nameController.text.isEmpty ||
        diController.text.isEmpty ||
        priceController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields and select an image");
      return;
    }

    isLoading.value = true;
    try {
      String imageUrl = await uploadImageToFirebaseStorage(imageFile.value!);
      String productId = const Uuid().v1();

      Items item = Items(
        name: nameController.text,
        imageUrl: imageUrl,
        descritpion: diController.text,
        price: priceController.text,
        productId: productId,
      );
          await firestore.collection("products").doc(productId).set(item.toJson());

    /// ✅ Clear fields after upload
    nameController.clear();
    diController.clear();
    priceController.clear();
    imageFile.value = null;
    Get.offAll(() => BottomNavBar());
    } catch (e) {
      debugPrint("Upload error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    diController.dispose();
    priceController.dispose();
    super.onClose();
  }
}
