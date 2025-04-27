import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portoflio/screens/bottom_Nav_bar.dart';
import 'package:portoflio/screens/login_screen.dart';
import 'package:portoflio/widgets/custom_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    manageSession();
  }

  manageSession() async {
    await Future.delayed(const Duration(seconds: 4), () {
      if (auth.currentUser != null && auth.currentUser?.emailVerified == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const BottomNavBar()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) =>  LoginScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Optional: for clean look
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/splash_image.png",
              height: 100,
              width: 200,
            ),
            const SizedBox(height: 20),
            Text(
              "Grocery Plus",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
        const CustomLoader(
  size: 60,

),
          ],
        ),
      ),
    );
  }
}
