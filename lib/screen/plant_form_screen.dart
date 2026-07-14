import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantcare_app/controller/garden_controller.dart';
import 'package:plantcare_app/model/my_plant.dart';
import 'package:plantcare_app/utils/constants.dart';

class PlantFormScreen extends StatefulWidget {
  const PlantFormScreen({super.key});

  @override
  State<PlantFormScreen> createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {
  GardenController gardenController = Get.isRegistered<GardenController>()
      ? Get.find<GardenController>()
      : Get.put(GardenController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController scientificNameController = TextEditingController();
  TextEditingController wateringController = TextEditingController();
  TextEditingController sunlightController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String mode = "add";
  MyPlant? editPlant;

  bool get isEdit => mode == "edit";

  @override
  void initState() {
    super.initState();
    setupForm();
  }

  void setupForm() {
    dynamic arguments = Get.arguments;

    if (arguments is Map) {
      mode = arguments["mode"] ?? "add";

      if (mode == "edit" && arguments["plant"] is MyPlant) {
        editPlant = arguments["plant"] as MyPlant;
        nameController.text = editPlant!.name;
        scientificNameController.text = editPlant!.scientificName;
        wateringController.text = editPlant!.watering;
        sunlightController.text = editPlant!.sunlight;
        noteController.text = editPlant!.note;
        gardenController.setImagePath(editPlant!.localImagePath);
        gardenController.setLocation(editPlant!.latitude, editPlant!.longitude);
        return;
      }
    }

    gardenController.clearImage();
    gardenController.clearLocation();
  }

  @override
  void dispose() {
    nameController.dispose();
    scientificNameController.dispose();
    wateringController.dispose();
    sunlightController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> savePlant() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    bool success = false;

    if (isEdit && editPlant != null) {
      MyPlant updatedPlant = MyPlant(
        id: editPlant!.id,
        apiId: editPlant!.apiId,
        name: nameController.text.trim(),
        scientificName: scientificNameController.text.trim(),
        imageUrl: editPlant!.imageUrl,
        localImagePath: gardenController.imagePath.value,
        watering: wateringController.text.trim(),
        sunlight: sunlightController.text.trim(),
        note: noteController.text.trim(),
        createdAt: editPlant!.createdAt,
        latitude: gardenController.latitude.value,
        longitude: gardenController.longitude.value,
      );

      success = await gardenController.updatePlant(updatedPlant);
    } else {
      String createdAt = DateFormat("yyyy-MM-dd HH:mm:ss").format(
        DateTime.now(),
      );

      MyPlant newPlant = MyPlant(
        apiId: null,
        name: nameController.text.trim(),
        scientificName: scientificNameController.text.trim(),
        imageUrl: "",
        localImagePath: gardenController.imagePath.value,
        watering: wateringController.text.trim(),
        sunlight: sunlightController.text.trim(),
        note: noteController.text.trim(),
        createdAt: createdAt,
        latitude: gardenController.latitude.value,
        longitude: gardenController.longitude.value,
      );

      success = await gardenController.addPlant(newPlant);
    }

    if (success) {
      gardenController.clearImage();
      gardenController.clearLocation();
      Get.back();
    }
  }

  void deletePlant() {
    if (editPlant == null) {
      return;
    }

    gardenController.showDeleteDialog(editPlant!, closeAfterDelete: true);
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
        title: Text(
          isEdit ? "Edit Plant" : "Add Plant",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _photoArea(),
              const SizedBox(height: 22),
              _locationArea(),
              const SizedBox(height: 22),
              _formField(
                label: "Plant Name",
                hint: "Enter plant name",
                controller: nameController,
                isRequired: true,
              ),
              _formField(
                label: "Scientific Name",
                hint: "Enter scientific name",
                controller: scientificNameController,
                isRequired: false,
              ),
              _formField(
                label: "Watering",
                hint: "Enter watering info",
                controller: wateringController,
                isRequired: true,
              ),
              _formField(
                label: "Sunlight",
                hint: "Enter sunlight info",
                controller: sunlightController,
                isRequired: true,
              ),
              _formField(
                label: "Note",
                hint: "Enter note about your plant",
                controller: noteController,
                isRequired: false,
                maxLines: 4,
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: savePlant,
                  icon: const Icon(Icons.local_florist),
                  label: Text(
                    isEdit ? "Update Plant" : "Save Plant",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (isEdit) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: deletePlant,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text(
                      "Delete Plant",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _photoArea() {
    return Obx(
      () => InkWell(
        onTap: gardenController.pickImageFromCamera,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 174,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isEdit ? Colors.transparent : const Color(0xFFB0BEC5),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _photoContent(),
                    if (gardenController.imagePath.value.isNotEmpty ||
                        (isEdit &&
                            editPlant != null &&
                            editPlant!.imageUrl.isNotEmpty))
                      Positioned(
                        right: 14,
                        bottom: 14,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: gardenController.pickImageFromCamera,
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: primaryColor,
                            ),
                            tooltip: "Camera",
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (isEdit) ...[
              const SizedBox(height: 8),
              const Text(
                "Change photo",
                style: TextStyle(color: textColor),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _photoContent() {
    String path = gardenController.imagePath.value;

    if (path.isNotEmpty) {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _photoPlaceholder(),
      );
    }

    if (isEdit && editPlant != null && editPlant!.imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: editPlant!.imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: primaryColor),
        ),
        errorWidget: (context, url, error) => _photoPlaceholder(),
      );
    }

    return _photoPlaceholder();
  }

  Widget _photoPlaceholder() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: const Color(0xFFE8F5E9),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: primaryColor,
              size: 34,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            isEdit ? "Change photo" : "Add plant photo",
            style: const TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationArea() {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFCFD8DC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Location",
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text("Latitude: ${gardenController.latitude.value.isEmpty ? "-" : gardenController.latitude.value}"),
            const SizedBox(height: 4),
            Text("Longitude: ${gardenController.longitude.value.isEmpty ? "-" : gardenController.longitude.value}"),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: gardenController.isGettingLocation.value
                    ? null
                    : gardenController.getCurrentLocation,
                icon: gardenController.isGettingLocation.value
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location_outlined),
                label: Text(
                  gardenController.isGettingLocation.value
                      ? "Mengambil Lokasi..."
                      : "Gunakan Lokasi Saat Ini",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isRequired,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            validator: (value) {
              if (isRequired && (value == null || value.trim().isEmpty)) {
                return "$label wajib diisi";
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFCFD8DC)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
