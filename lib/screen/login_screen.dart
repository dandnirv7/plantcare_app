import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantcare_app/controller/auth_controller.dart';
import 'package:plantcare_app/screen/register_screen.dart';
import 'package:plantcare_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 90),
                const Icon(
                  Icons.eco,
                  color: primaryColor,
                  size: 86,
                ),
                const SizedBox(height: 16),
                const Text(
                  appName,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  appTagline,
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: authController.usernameController,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username wajib diisi";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: authController.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password wajib diisi";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),
                Obx(
                  () => ElevatedButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              authController.login(
                                authController.usernameController.text,
                                authController.passwordController.text,
                              );
                            }
                          },
                    child: authController.isLoading.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () => Get.to(() => const RegisterScreen()),
                  child: const Text(
                    "Don't have an account? Register",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
