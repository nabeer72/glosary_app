import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portoflio/screens/login_screen.dart';

class ProfileController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Observable variables for profile details
  var userName = ''.obs;
  var userEmail = ''.obs;
  var profilePicUrl = ''.obs;
  var phoneNumber = ''.obs; // Adding phone number as part of the profile
  var isLoading = true.obs;  // Loading state

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  // Get user information from Firestore
  void getUserInfo() async {
    try {
      isLoading.value = true;
      User? user = auth.currentUser;
      if (user != null) {
        // Fetch the user's data from Firestore using their UID
        DocumentSnapshot userDoc = await firestore.collection('Users').doc(user.uid).get();
        if (userDoc.exists) {
          var userData = userDoc.data() as Map<String, dynamic>;

          // Set values from Firestore to the observable variables
          userName.value = userData['username'] ?? 'User Name';  // Fallback if username is null
          userEmail.value = userData['email'] ?? 'user@example.com'; // Fallback if email is null
          phoneNumber.value = userData['phone'] ?? 'Not Provided';  // Fallback if phone number is null
          profilePicUrl.value = userData['profilePicUrl'] ?? 'assets/images/default_profile_pic.png'; // Fallback if no profile picture
        } else {
          print("No user data found in Firestore.");
        }
      }
    } catch (e) {
      print("Error fetching user info: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Logout function using GetX navigation
  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.offAll(() => LoginScreen()); // Navigate to LoginScreen
    } on FirebaseAuthException catch (e) {
      print("Error during logout: ${e.code}");
    }
  }
}
