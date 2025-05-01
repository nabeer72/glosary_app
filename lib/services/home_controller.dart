// controllers/home_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portoflio/Models/grocery_model.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  var itemsList = <Items>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading.value = true;
    try {
      var snapshot = await firestore.collection("products").get();
      itemsList.value = snapshot.docs.map((doc) => Items.fromMap(doc.data())).toList();
    } catch (e) {
      debugPrint("Error while fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
