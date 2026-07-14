import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantcare_app/controller/plant_controller.dart';
import 'package:plantcare_app/model/plant.dart';
import 'package:plantcare_app/screen/detail_screen.dart';
import 'package:plantcare_app/screen/my_garden_screen.dart';
import 'package:plantcare_app/screen/profile_screen.dart';
import 'package:plantcare_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlantController plantController = Get.isRegistered<PlantController>()
      ? Get.find<PlantController>()
      : Get.put(PlantController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    plantController.fetchPlants();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchPlant() {
    String keyword = searchController.text.trim();
    plantController.searchPlants(keyword);
  }

  void openMyGarden() {
    Get.to(() => const MyGardenScreen());
  }

  void openProfile() {
    Get.to(() => const ProfileScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: openMyGarden,
            icon: const Icon(Icons.local_florist_outlined),
            tooltip: "My Garden",
          ),
          IconButton(
            onPressed: openProfile,
            icon: const Icon(Icons.person_outline),
            tooltip: "Profile",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(18),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: subTextColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Search plants...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) => searchPlant(),
                    ),
                  ),
                  IconButton(
                    onPressed: searchPlant,
                    icon: const Icon(Icons.search, color: primaryColor),
                    tooltip: "Search",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              "Popular Plants",
              style: TextStyle(
                color: textColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () {
                  if (plantController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    );
                  }

                  if (plantController.plants.isEmpty) {
                    if (plantController.keyword.value.isNotEmpty) {
                      return _emptyState(
                        icon: Icons.search_off,
                        title: "No plants found",
                        message: "Try searching with another keyword.",
                        buttonText: "Clear Search",
                        onPressed: () {
                          searchController.clear();
                          plantController.clearSearch();
                        },
                      );
                    }

                    return _emptyState(
                      icon: Icons.warning_amber_rounded,
                      title: "Something went wrong",
                      message:
                          "Failed to load plant data. Please check your connection and try again.",
                      buttonText: "Try Again",
                      onPressed: plantController.fetchPlants,
                    );
                  }

                  return ListView.builder(
                    itemCount: plantController.plants.length,
                    itemBuilder: (context, index) {
                      Plant plant = plantController.plants[index];
                      return _plantCard(plant);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _plantCard(Plant plant) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Get.to(() => const DetailScreen(), arguments: plant);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _plantImage(plant.imageUrl),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plant.scientificName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: subTextColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _infoRow(Icons.water_drop, "Watering", plant.watering),
                    const SizedBox(height: 6),
                    _infoRow(Icons.wb_sunny, "Sunlight", plant.sunlight),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: subTextColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _plantImage(String imageUrl) {
    if (imageUrl.isEmpty) {
      return _imagePlaceholder();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 104,
        height: 124,
        fit: BoxFit.cover,
        placeholder: (context, url) => const SizedBox(
          width: 104,
          height: 124,
          child: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
              strokeWidth: 2,
            ),
          ),
        ),
        errorWidget: (context, url, error) => _imagePlaceholder(),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 104,
      height: 124,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.eco, color: primaryColor, size: 42),
    );
  }

  Widget _emptyState({
    required IconData icon,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: secondaryColor, size: 64),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: subTextColor),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: primaryColor, size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            "$title: $value",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: textColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
