import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantcare_app/dataaccess/my_plant_dataaccess.dart';
import 'package:plantcare_app/model/my_plant.dart';

class GardenController extends GetxController {
  var myPlants = <MyPlant>[].obs;
  var isLoading = false.obs;
  var imagePath = "".obs;
  var videoPath = "".obs;
  var gardenSearchQuery = "".obs;
  var latitude = "".obs;
  var longitude = "".obs;
  var isGettingLocation = false.obs;

  MyPlantDataAccess myPlantDataAccess = MyPlantDataAccess();

  Future<void> loadPlants() async {
    isLoading.value = true;

    try {
      myPlants.value = await myPlantDataAccess.getAllPlants();
    } catch (e) {
      Get.snackbar("Error", "A database error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addPlant(MyPlant plant) async {
    try {
      await myPlantDataAccess.insertPlant(plant);
      await loadPlants();
      Get.snackbar("Success", "Plant saved successfully");
      return true;
    } catch (e) {
      Get.snackbar("Error", "Failed to save plant");
      return false;
    }
  }

  Future<bool> updatePlant(MyPlant plant) async {
    try {
      await myPlantDataAccess.updatePlant(plant);
      await loadPlants();
      Get.snackbar("Success", "Plant updated successfully");
      return true;
    } catch (e) {
      Get.snackbar("Error", "Failed to update plant");
      return false;
    }
  }

  Future<void> deletePlant(int id) async {
    try {
      await myPlantDataAccess.deletePlant(id);
      await loadPlants();
      Get.snackbar("Success", "Plant deleted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete plant");
    }
  }

  void showDeleteDialog(MyPlant plant, {bool closeAfterDelete = false}) {
    Get.dialog(
      AlertDialog(
        title: const Text("Hapus Tanaman"),
        content: const Text("Apakah kamu yakin ingin menghapus tanaman ini?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              if (plant.id != null) {
                await deletePlant(plant.id!);

                if (closeAfterDelete) {
                  Get.back();
                }
              }
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  Future<void> pickImageFromCamera() async {
    if (!await requestCameraPermission()) return;

    try {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        imagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to capture plant photo");
    }
  }

  void clearImage() {
    imagePath.value = "";
  }

  void setImagePath(String path) {
    imagePath.value = path;
  }

  Future<void> pickVideoFromCamera() async {
    if (!await requestCameraPermission()) return;

    try {
      ImagePicker picker = ImagePicker();
      XFile? video = await picker.pickVideo(source: ImageSource.camera);

      if (video != null) {
        videoPath.value = video.path;
        Get.snackbar("Success", "Plant video recorded successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to record plant video");
    }
  }

  void clearVideo() {
    videoPath.value = "";
  }

  void setVideoPath(String path) {
    videoPath.value = path;
  }

  void setGardenSearchQuery(String value) {
    gardenSearchQuery.value = value;
  }

  Future<bool> requestCameraPermission() async {
    try {
      PermissionStatus status = await Permission.camera.status;

      if (status.isGranted) return true;

      status = await Permission.camera.request();
      if (status.isGranted) return true;

      if (status.isPermanentlyDenied) {
        Get.snackbar(
          "Camera Permission Permanently Denied",
          "Enable camera permission in the app settings.",
        );
        return false;
      }

      Get.snackbar(
        "Camera Permission Denied",
        "Camera permission is required to take photos or record videos.",
      );
      return false;
    } catch (e) {
      Get.snackbar("Error", "Failed to check camera permission.");
      return false;
    }
  }

  Future<void> getCurrentLocation() async {
    isGettingLocation.value = true;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Location Disabled", "Please turn on GPS first");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Permission Permanently Denied",
          "Enable location permission in the app settings",
        );
        return;
      }

      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission Denied", "The app needs location permission");
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
      Get.snackbar("Success", "Location retrieved successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve location");
    } finally {
      isGettingLocation.value = false;
    }
  }

  void clearLocation() {
    latitude.value = "";
    longitude.value = "";
  }

  void setLocation(String lat, String lng) {
    latitude.value = lat;
    longitude.value = lng;
  }
}
