import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantcare_app/controller/auth_controller.dart';
import 'package:plantcare_app/controller/garden_controller.dart';
import 'package:plantcare_app/screen/home_screen.dart';
import 'package:plantcare_app/screen/my_garden_screen.dart';
import 'package:plantcare_app/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.find<AuthController>();
  GardenController gardenController = Get.isRegistered<GardenController>()
      ? Get.find<GardenController>()
      : Get.put(GardenController());

  @override
  void initState() {
    super.initState();
    gardenController.loadPlants();
  }

  void openHome() {
    Get.off(() => const HomeScreen());
  }

  void openMyGarden() {
    Get.off(() => const MyGardenScreen());
  }

  void onBottomNavigationTap(int index) {
    if (index == 0) openHome();
    if (index == 1) openMyGarden();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
          tooltip: "Back",
        ),
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: openHome,
            icon: const Icon(Icons.home_outlined),
            tooltip: "Home",
          ),
          IconButton(
            onPressed: openMyGarden,
            icon: const Icon(Icons.local_florist_outlined),
            tooltip: "My Garden",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 28),
            const CircleAvatar(
              radius: 58,
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(
                Icons.person_outline,
                color: primaryColor,
                size: 72,
              ),
            ),
            const SizedBox(height: 18),
            Obx(
              () => Text(
                authController.currentUsername.value,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "PlantCare User",
              style: TextStyle(
                color: subTextColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            Obx(
              () => _profileCard(
                icon: Icons.local_florist_outlined,
                title: "Saved Plants",
                value: gardenController.isLoading.value
                    ? "Loading..."
                    : gardenController.myPlants.length.toString(),
              ),
            ),
            const SizedBox(height: 14),
            _profileCard(
              icon: Icons.verified_user_outlined,
              title: "App Version",
              value: appVersion,
            ),
            const SizedBox(height: 42),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                onPressed: authController.showLogoutDialog,
                icon: const Icon(Icons.logout),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: primaryColor,
        unselectedItemColor: subTextColor,
        onTap: onBottomNavigationTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: "My Garden",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _profileCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primaryColor, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
