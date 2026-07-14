import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantcare_app/controller/auth_controller.dart';
import 'package:plantcare_app/screen/home_screen.dart';
import 'package:plantcare_app/screen/login_screen.dart';
import 'package:plantcare_app/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.put(AuthController(), permanent: true);

  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  Future<void> goToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await authController.checkLoginStatus();

    if (authController.isLoggedIn.value) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: backgroundColor,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.eco,
              color: primaryColor,
              size: 92,
            ),
            SizedBox(height: 16),
            Text(
              appName,
              style: TextStyle(
                color: primaryColor,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              appTagline,
              style: TextStyle(
                color: subTextColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 36),
            CircularProgressIndicator(color: primaryColor),
          ],
        ),
      ),
    );
  }
}
