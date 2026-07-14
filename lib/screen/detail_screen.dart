import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantcare_app/controller/garden_controller.dart';
import 'package:plantcare_app/controller/plant_controller.dart';
import 'package:plantcare_app/model/my_plant.dart';
import 'package:plantcare_app/model/plant.dart';
import 'package:plantcare_app/utils/constants.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  PlantController plantController = Get.find<PlantController>();
  GardenController gardenController = Get.isRegistered<GardenController>()
      ? Get.find<GardenController>()
      : Get.put(GardenController());

  @override
  void initState() {
    super.initState();
    loadPlantDetail();
  }

  void loadPlantDetail() {
    if (Get.arguments is Plant) {
      Plant plant = Get.arguments as Plant;
      plantController.selectedPlant.value = plant;
      plantController.fetchPlantDetail(plant.apiId);
    }
  }

  void saveToMyGarden() {
    Plant? plant = plantController.selectedPlant.value;

    if (plant == null) {
      Get.snackbar("Error", "Plant data is unavailable");
      return;
    }

    String createdAt = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

    MyPlant myPlant = MyPlant(
      apiId: plant.apiId,
      name: plant.name,
      scientificName: plant.scientificName,
      imageUrl: plant.imageUrl,
      localImagePath: "",
      watering: plant.watering,
      sunlight: plant.sunlight,
      note: plant.description,
      createdAt: createdAt,
    );

    gardenController.addPlant(myPlant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          Plant? plant = plantController.selectedPlant.value;

          if (plant == null) {
            return const Center(
              child: Text("Data tanaman tidak tersedia"),
            );
          }

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headerImage(plant.imageUrl),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
                      decoration: const BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (plantController.isLoading.value)
                            const LinearProgressIndicator(
                              color: primaryColor,
                              backgroundColor: Color(0xFFE8F5E9),
                            ),
                          const SizedBox(height: 10),
                          Text(
                            plant.name,
                            style: const TextStyle(
                              color: textColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            plant.scientificName,
                            style: const TextStyle(
                              color: subTextColor,
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: _detailInfoCard(
                                  Icons.water_drop,
                                  "Watering",
                                  plant.watering,
                                  const Color(0xFFE8F5E9),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _detailInfoCard(
                                  Icons.wb_sunny,
                                  "Sunlight",
                                  plant.sunlight,
                                  const Color(0xFFFFF8E1),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          const Text(
                            "About This Plant",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            plant.description,
                            style: const TextStyle(
                              color: textColor,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton.icon(
                            onPressed: saveToMyGarden,
                            icon: const Icon(Icons.local_florist),
                            label: const Text(
                              "Save to My Garden",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back, color: textColor),
                      tooltip: "Back",
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _headerImage(String imageUrl) {
    if (imageUrl.isEmpty) {
      return _largePlaceholder();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: 340,
      fit: BoxFit.cover,
      placeholder: (context, url) => const SizedBox(
        height: 340,
        child: Center(
          child: CircularProgressIndicator(color: primaryColor),
        ),
      ),
      errorWidget: (context, url, error) => _largePlaceholder(),
    );
  }

  Widget _largePlaceholder() {
    return Container(
      width: double.infinity,
      height: 340,
      color: const Color(0xFFE8F5E9),
      child: const Icon(Icons.eco, color: primaryColor, size: 92),
    );
  }

  Widget _detailInfoCard(
    IconData icon,
    String title,
    String value,
    Color background,
  ) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 130),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: primaryColor, size: 34),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: textColor,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
