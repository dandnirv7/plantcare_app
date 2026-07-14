import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:plantcare_app/model/plant.dart';
import 'package:plantcare_app/utils/constants.dart';

const Duration _apiTimeout = Duration(seconds: 15);

class PlantController extends GetxController {
  var plants = <Plant>[].obs;
  var selectedPlant = Rxn<Plant>();
  var isLoading = false.obs;
  var keyword = "".obs;

  bool _hasApiKey() {
    if (apiKey.isEmpty) {
      Get.snackbar("Error", "API key belum diatur");
      return false;
    }
    return true;
  }

  Future<http.Response?> _get(String path, Map<String, String> params) async {
    if (!_hasApiKey()) return null;

    try {
      Uri url = Uri.parse(
        "$baseUrl/$path",
      ).replace(queryParameters: {"key": apiKey, ...params});
      return await http.get(url).timeout(_apiTimeout);
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> fetchPlants() async {
    isLoading.value = true;

    try {
      http.Response? response = await _get("species-list", {});
      if (response == null || response.statusCode != 200) {
        Get.snackbar("Gagal", "Gagal mengambil data tanaman");
        return;
      }
      Map<String, dynamic> result = jsonDecode(response.body);
      List data = result["data"] ?? [];
      plants.value = data
          .map((item) => Plant.fromMap(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      Get.snackbar("Gagal", "Gagal mengambil data tanaman");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchPlants(String keyword) async {
    this.keyword.value = keyword;

    if (keyword.isEmpty) {
      await fetchPlants();
      return;
    }

    isLoading.value = true;

    try {
      http.Response? response = await _get("species-list", {"q": keyword});
      if (response == null || response.statusCode != 200) {
        Get.snackbar("Gagal", "Gagal mencari data tanaman");
        return;
      }
      Map<String, dynamic> result = jsonDecode(response.body);
      List data = result["data"] ?? [];
      plants.value = data
          .map((item) => Plant.fromMap(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      Get.snackbar("Gagal", "Gagal mencari data tanaman");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPlantDetail(int id) async {
    isLoading.value = true;

    try {
      http.Response? response = await _get("species/details/$id", {});
      if (response == null || response.statusCode != 200) {
        Get.snackbar("Gagal", "Gagal mengambil detail tanaman");
        return;
      }
      Map<String, dynamic> result = jsonDecode(response.body);
      selectedPlant.value = Plant.fromMap(result);
    } catch (e) {
      Get.snackbar("Gagal", "Gagal mengambil detail tanaman");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearSearch() async {
    keyword.value = "";
    await fetchPlants();
  }
}
