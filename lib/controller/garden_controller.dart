import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantcare_app/dataaccess/my_plant_dataaccess.dart';
import 'package:plantcare_app/model/my_plant.dart';

class GardenController extends GetxController {
  var myPlants = <MyPlant>[].obs;
  var isLoading = false.obs;
  var imagePath = "".obs;
  var latitude = "".obs;
  var longitude = "".obs;
  var isGettingLocation = false.obs;

  MyPlantDataAccess myPlantDataAccess = MyPlantDataAccess();

  Future<void> loadPlants() async {
    isLoading.value = true;

    try {
      myPlants.value = await myPlantDataAccess.getAllPlants();
    } catch (e) {
      Get.snackbar("Gagal", "Terjadi kesalahan database");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addPlant(MyPlant plant) async {
    try {
      await myPlantDataAccess.insertPlant(plant);
      await loadPlants();
      Get.snackbar("Berhasil", "Tanaman berhasil disimpan");
      return true;
    } catch (e) {
      Get.snackbar("Gagal", "Tanaman gagal disimpan");
      return false;
    }
  }

  Future<bool> updatePlant(MyPlant plant) async {
    try {
      await myPlantDataAccess.updatePlant(plant);
      await loadPlants();
      Get.snackbar("Berhasil", "Tanaman berhasil diperbarui");
      return true;
    } catch (e) {
      Get.snackbar("Gagal", "Tanaman gagal diperbarui");
      return false;
    }
  }

  Future<void> deletePlant(int id) async {
    try {
      await myPlantDataAccess.deletePlant(id);
      await loadPlants();
      Get.snackbar("Berhasil", "Tanaman berhasil dihapus");
    } catch (e) {
      Get.snackbar("Gagal", "Tanaman gagal dihapus");
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
    try {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        imagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar("Gagal", "Gagal mengambil foto tanaman");
    }
  }

  void clearImage() {
    imagePath.value = "";
  }

  void setImagePath(String path) {
    imagePath.value = path;
  }

  Future<void> getCurrentLocation() async {
    isGettingLocation.value = true;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Lokasi Tidak Aktif", "Aktifkan GPS terlebih dahulu");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Izin Ditolak Permanen",
          "Aktifkan izin lokasi dari pengaturan aplikasi",
        );
        return;
      }

      if (permission == LocationPermission.denied) {
        Get.snackbar("Izin Ditolak", "Aplikasi membutuhkan izin lokasi");
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
      Get.snackbar("Berhasil", "Lokasi berhasil diambil");
    } catch (e) {
      Get.snackbar("Gagal", "Gagal mengambil lokasi");
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
