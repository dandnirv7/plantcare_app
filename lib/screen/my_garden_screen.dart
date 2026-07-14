import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:plantcare_app/controller/garden_controller.dart';
import 'package:plantcare_app/model/my_plant.dart';
import 'package:plantcare_app/screen/home_screen.dart';
import 'package:plantcare_app/screen/plant_form_screen.dart';
import 'package:plantcare_app/screen/profile_screen.dart';
import 'package:plantcare_app/screen/video_preview_screen.dart';
import 'package:plantcare_app/utils/constants.dart';

class MyGardenScreen extends StatefulWidget {
  const MyGardenScreen({super.key});

  @override
  State<MyGardenScreen> createState() => _MyGardenScreenState();
}

class _MyGardenScreenState extends State<MyGardenScreen> {
  GardenController gardenController = Get.isRegistered<GardenController>()
      ? Get.find<GardenController>()
      : Get.put(GardenController());

  @override
  void initState() {
    super.initState();
    gardenController.setGardenSearchQuery("");
    gardenController.loadPlants();
  }

  void openAddPlant() {
    gardenController.clearImage();
    gardenController.clearVideo();
    Get.to(() => const PlantFormScreen(), arguments: {"mode": "add"});
  }

  void openEditPlant(MyPlant plant) {
    gardenController.setImagePath(plant.localImagePath);
    Get.to(
      () => const PlantFormScreen(),
      arguments: {
        "mode": "edit",
        "plant": plant,
      },
    );
  }

  void openHome() {
    Get.off(() => const HomeScreen());
  }

  void openProfile() {
    Get.off(() => const ProfileScreen());
  }

  void onBottomNavigationTap(int index) {
    if (index == 0) openHome();
    if (index == 2) openProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: openHome,
          icon: const Icon(Icons.home_outlined),
          tooltip: "Home",
        ),
        title: const Text(
          "My Garden",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: openAddPlant,
            icon: const Icon(Icons.add_circle),
            tooltip: "Add Plant",
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
        child: Obx(
          () {
            if (gardenController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            if (gardenController.myPlants.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.local_florist_outlined,
                      color: secondaryColor,
                      size: 72,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "No plants yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Your garden is still empty. Add your first plant to get started.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: subTextColor),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 220,
                      child: ElevatedButton(
                        onPressed: openAddPlant,
                        child: const Text("Add Plant"),
                      ),
                    ),
                  ],
                ),
              );
            }

            String query = gardenController.gardenSearchQuery.value
                .trim()
                .toLowerCase();
            List<MyPlant> filteredPlants = gardenController.myPlants.where((plant) {
              String searchableText = [
                plant.name,
                plant.scientificName,
                plant.watering,
                plant.sunlight,
                plant.note,
              ].join(" ").toLowerCase();
              return searchableText.contains(query);
            }).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your saved plants",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                _gardenSearchField(),
                const SizedBox(height: 16),
                Expanded(
                  child: filteredPlants.isEmpty
                      ? _emptySearchState()
                      : ListView.builder(
                          itemCount: filteredPlants.length,
                          itemBuilder: (context, index) {
                            return _gardenCard(filteredPlants[index]);
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddPlant,
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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

  Widget _gardenSearchField() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        onChanged: gardenController.setGardenSearchQuery,
        decoration: const InputDecoration(
          icon: Icon(Icons.search, color: primaryColor),
          hintText: "Search saved plants...",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _emptySearchState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, color: secondaryColor, size: 58),
          SizedBox(height: 12),
          Text(
            "No saved plants found",
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Try searching with another keyword.",
            textAlign: TextAlign.center,
            style: TextStyle(color: subTextColor),
          ),
        ],
      ),
    );
  }

  Widget _gardenCard(MyPlant plant) {
    LatLng? location = _plantLocation(plant);

    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _plantImage(plant),
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
                      const SizedBox(height: 12),
                      _infoRow(Icons.water_drop, plant.watering),
                      const SizedBox(height: 8),
                      _infoRow(Icons.wb_sunny, plant.sunlight),
                      const SizedBox(height: 10),
                      _locationInfo(plant, location),
                      const SizedBox(height: 8),
                      _videoInfo(plant),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () => openEditPlant(plant),
                      icon: const Icon(Icons.edit_outlined, color: primaryColor),
                      tooltip: "Edit",
                    ),
                    IconButton(
                      onPressed: () => gardenController.showDeleteDialog(plant),
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      tooltip: "Delete",
                    ),
                  ],
                ),
              ],
            ),
            if (location != null) ...[
              const SizedBox(height: 14),
              _locationMap(location),
            ],
            if (plant.localVideoPath.isNotEmpty) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => Get.to(
                    () => VideoPreviewScreen(videoPath: plant.localVideoPath),
                  ),
                  icon: const Icon(Icons.play_circle_outline),
                  label: const Text("Preview Video"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _plantImage(MyPlant plant) {
    if (plant.localImagePath.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(plant.localImagePath),
          width: 112,
          height: 132,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _imagePlaceholder(),
        ),
      );
    }

    if (plant.imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: plant.imageUrl,
          width: 112,
          height: 132,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(
            width: 112,
            height: 132,
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

    return _imagePlaceholder();
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 112,
      height: 132,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.eco, color: primaryColor, size: 42),
    );
  }

  Widget _infoRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: textColor,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  LatLng? _plantLocation(MyPlant plant) {
    double? latitude = double.tryParse(plant.latitude);
    double? longitude = double.tryParse(plant.longitude);

    if (latitude == null || longitude == null) return null;
    if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
      return null;
    }

    return LatLng(latitude, longitude);
  }

  Widget _locationInfo(MyPlant plant, LatLng? location) {
    if (location == null) {
      return const Text(
        "Location not saved",
        style: TextStyle(color: subTextColor, fontSize: 12),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Location:",
          style: TextStyle(
            color: primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Lat: ${plant.latitude}",
          style: const TextStyle(color: textColor, fontSize: 12),
        ),
        Text(
          "Lng: ${plant.longitude}",
          style: const TextStyle(color: textColor, fontSize: 12),
        ),
      ],
    );
  }

  Widget _locationMap(LatLng location) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: location,
            initialZoom: 15,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.drag |
                  InteractiveFlag.pinchZoom |
                  InteractiveFlag.doubleTapZoom,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: "com.example.plantcare_app",
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: location,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _videoInfo(MyPlant plant) {
    return Row(
      children: [
        Icon(
          Icons.videocam_outlined,
          color: plant.localVideoPath.isEmpty ? subTextColor : primaryColor,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          plant.localVideoPath.isEmpty ? "Video: Not saved" : "Video: Available",
          style: const TextStyle(color: textColor, fontSize: 12),
        ),
      ],
    );
  }
}
