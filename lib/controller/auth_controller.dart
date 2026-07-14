import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantcare_app/dataaccess/user_dataaccess.dart';
import 'package:plantcare_app/model/user.dart';
import 'package:plantcare_app/screen/home_screen.dart';
import 'package:plantcare_app/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var currentUsername = "".obs;

  UserDataAccess userDataAccess = UserDataAccess();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> checkLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoggedIn.value = preferences.getBool("is_logged_in") ?? false;
    currentUsername.value = preferences.getString("username") ?? "";
  }

  Future<void> register(
    String username,
    String password,
    String confirmPassword,
  ) async {
    username = username.trim();

    if (username.isEmpty) {
      Get.snackbar("Gagal", "Username wajib diisi");
      return;
    }

    if (password.isEmpty) {
      Get.snackbar("Gagal", "Password wajib diisi");
      return;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar("Gagal", "Konfirmasi password wajib diisi");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Gagal", "Password dan konfirmasi password tidak sama");
      return;
    }

    isLoading.value = true;

    try {
      User? existingUser = await userDataAccess.getUserByUsername(username);

      if (existingUser != null) {
        Get.snackbar("Gagal", "Username sudah digunakan");
        return;
      }

      User user = User(
        username: username,
        password: password,
        createdAt: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
      );
      await userDataAccess.insertUser(user);

      Get.snackbar("Berhasil", "Pendaftaran berhasil, silakan login");
      Get.back();
    } catch (error) {
      Get.snackbar("Gagal", "Pendaftaran gagal");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String username, String password) async {
    username = username.trim();

    if (username.isEmpty) {
      Get.snackbar("Gagal", "Username wajib diisi");
      return;
    }

    if (password.isEmpty) {
      Get.snackbar("Gagal", "Password wajib diisi");
      return;
    }

    isLoading.value = true;

    try {
      User? user = await userDataAccess.loginUser(username, password);

      if (user != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setBool("is_logged_in", true);
        await preferences.setString("username", user.username);

        isLoggedIn.value = true;
        currentUsername.value = user.username;
        usernameController.clear();
        passwordController.clear();

        Get.snackbar("Berhasil", "Login berhasil");
        Get.offAll(() => const HomeScreen());
      } else {
        Get.snackbar("Gagal", "Username atau password salah");
      }
    } catch (error) {
      Get.snackbar("Gagal", "Username atau password salah");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("is_logged_in", false);
    await preferences.remove("username");

    isLoggedIn.value = false;
    currentUsername.value = "";
    Get.offAll(() => const LoginScreen());
    Get.snackbar("Berhasil", "Logout berhasil");
  }

  void showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Logout"),
        content: const Text("Apakah kamu yakin ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await logout();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
