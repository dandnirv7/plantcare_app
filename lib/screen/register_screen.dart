import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantcare_app/controller/auth_controller.dart';
import 'package:plantcare_app/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 32),
                const Icon(Icons.eco, color: primaryColor, size: 78),
                const SizedBox(height: 16),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Register to start caring for your plants",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: subTextColor, fontSize: 16),
                ),
                const SizedBox(height: 42),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password confirmation is required";
                    }
                    if (value != passwordController.text) {
                      return "Password confirmation does not match";
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
                              authController.register(
                                usernameController.text,
                                passwordController.text,
                                confirmPasswordController.text,
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
                            "Register",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
