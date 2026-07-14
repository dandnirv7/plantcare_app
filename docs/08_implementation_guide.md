# Implementation Guide - PlantCare App

## 1. Ringkasan

Dokumen ini adalah panduan implementasi coding untuk project **PlantCare App**.

Panduan ini dibuat agar proses pengembangan aplikasi tetap sederhana, rapi, dan sesuai dengan aturan di `AGENTS.md`.

Project ini menggunakan:

- Flutter
- Dart
- GetX
- REST API
- SQLite
- Image Picker
- SharedPreferences

Project tidak menggunakan arsitektur kompleks seperti Clean Architecture, Repository Pattern, BLoC, Riverpod, Firebase, code generation, atau layer tambahan yang tidak diajarkan.

---

## 2. Prinsip Implementasi

Selama implementasi, ikuti prinsip berikut:

1. Kode harus sederhana dan mudah dibaca.
2. Gunakan GetX untuk state management dan navigation.
3. Gunakan MVC sederhana.
4. Jangan membuat folder `repository/`, `usecase/`, atau `services/`.
5. Model menggunakan `fromMap()` dan `toMap()` manual.
6. State menggunakan `.obs`.
7. UI menggunakan `Obx()` untuk membaca state.
8. Form menggunakan `GlobalKey<FormState>`.
9. Error handling cukup menggunakan try-catch sederhana.
10. Gunakan `Get.snackbar()` untuk pesan berhasil atau gagal.
11. Gunakan `Get.dialog()` untuk konfirmasi delete dan logout.
12. Jangan overengineering.

---

## 3. Urutan Dokumentasi yang Harus Dibaca

Sebelum coding, baca dokumen dalam urutan berikut:

```text
docs/01_prd.md
docs/02_mvp.md
docs/03_features.md
docs/04_api_database.md
docs/05_project_plan.md
docs/06_user_flow.md
docs/07_screen_list.md
docs/08_implementation_guide.md
```

Gunakan referensi UI dari:

```text
docs/ui-reference/01_login_home_plant_detail.png
docs/ui-reference/02_my_garden_add_plant_edit_plant.png
docs/ui-reference/03_splash_profile_empty_error_states.png
```

---

## 4. Package yang Digunakan

Package yang digunakan dalam project:

```bash
flutter pub add get http sqflite path image_picker shared_preferences intl cached_network_image
```

Keterangan package:

| Package                | Fungsi                                         |
| ---------------------- | ---------------------------------------------- |
| `get`                  | Navigation, state management, snackbar, dialog |
| `http`                 | Mengambil data dari REST API                   |
| `sqflite`              | Database SQLite                                |
| `path`                 | Mengatur path database SQLite                  |
| `image_picker`         | Mengambil foto tanaman                         |
| `shared_preferences`   | Menyimpan status login                         |
| `intl`                 | Format tanggal                                 |
| `cached_network_image` | Menampilkan gambar dari URL                    |

Catatan:

- Jangan menambahkan package baru tanpa kebutuhan jelas.
- Jangan menggunakan Dio, Provider, Riverpod, BLoC, Firebase, Hive, atau Drift.
- Jika package tambahan benar-benar dibutuhkan, tanyakan dulu.

---

## 5. Struktur Folder Final

Gunakan struktur folder berikut:

```text
lib/
  main.dart

  model/
    plant.dart
    my_plant.dart

  controller/
    auth_controller.dart
    plant_controller.dart
    garden_controller.dart

  screen/
    splash_screen.dart
    login_screen.dart
    home_screen.dart
    detail_screen.dart
    my_garden_screen.dart
    plant_form_screen.dart
    profile_screen.dart

  dataaccess/
    my_plant_dataaccess.dart

  provider/
    database_provider.dart

  utils/
    constants.dart
```

Jangan membuat folder berikut:

```text
repository/
usecase/
services/
bloc/
provider/ untuk state management
```

Catatan:

- Folder `provider/` hanya digunakan untuk database provider SQLite.
- State management tetap menggunakan GetX di folder `controller/`.

---

## 6. Urutan Implementasi Coding

Implementasi sebaiknya dilakukan bertahap agar mudah dicek.

Urutan pengerjaan yang disarankan:

1. Setup package.
2. Buat folder project.
3. Buat `utils/constants.dart`.
4. Buat model `plant.dart`.
5. Buat model `my_plant.dart`.
6. Buat `main.dart` dengan `GetMaterialApp`.
7. Buat `auth_controller.dart`.
8. Buat `splash_screen.dart`.
9. Buat `login_screen.dart`.
10. Buat `home_screen.dart` dengan data dummy.
11. Buat `detail_screen.dart`.
12. Buat navigation antar screen.
13. Buat `plant_controller.dart` untuk REST API.
14. Hubungkan Home Screen ke API.
15. Buat `database_provider.dart`.
16. Buat `my_plant_dataaccess.dart`.
17. Buat `garden_controller.dart`.
18. Buat `my_garden_screen.dart`.
19. Buat `plant_form_screen.dart`.
20. Implementasi CRUD SQLite.
21. Implementasi kamera dengan `image_picker`.
22. Buat `profile_screen.dart`.
23. Implementasi logout.
24. Rapikan UI sesuai referensi gambar.
25. Testing manual.

---

## 7. File `constants.dart`

File:

```text
lib/utils/constants.dart
```

Fungsi:

1. Menyimpan base URL.
2. Menyimpan API key.
3. Menyimpan warna utama jika dibutuhkan.
4. Menyimpan teks default jika dibutuhkan.

Isi minimal:

```dart
import 'package:flutter/material.dart';

const String baseUrl = "https://perenual.com/api";
const String apiKey = "ISI_API_KEY_KAMU";

const Color primaryColor = Color(0xFF2E7D32);
const Color secondaryColor = Color(0xFF66BB6A);
const Color backgroundColor = Color(0xFFF7FAF5);

const String defaultImageMessage = "Data gambar tidak tersedia";
```

Catatan:

- Jangan menulis API key langsung di screen.
- API key cukup diletakkan di satu file ini.
- Untuk project kuliah, cara ini sudah cukup sederhana.

---

## 8. Implementasi `main.dart`

File:

```text
lib/main.dart
```

Gunakan `GetMaterialApp`.

Konsep isi:

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantcare_app/screen/splash_screen.dart';
import 'package:plantcare_app/utils/constants.dart';

void main() {
  runApp(const PlantCareApp());
}

class PlantCareApp extends StatelessWidget {
  const PlantCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlantCare',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
```

Catatan:

- Gunakan `GetMaterialApp`, bukan `MaterialApp`.
- Jangan membuat routing kompleks dulu.
- Untuk project sederhana, `Get.to()` langsung cukup.

---

## 9. Model `Plant`

File:

```text
lib/model/plant.dart
```

Fungsi:

Model untuk data tanaman dari API.

Field minimal:

```text
apiId
name
scientificName
imageUrl
watering
sunlight
description
```

Aturan:

1. Field public.
2. Tidak perlu immutable.
3. Tidak perlu `copyWith`.
4. Gunakan `fromMap()` manual.
5. Gunakan default value jika data API kosong.

Contoh konsep:

```dart
class Plant {
  int apiId;
  String name;
  String scientificName;
  String imageUrl;
  String watering;
  String sunlight;
  String description;

  Plant({
    required this.apiId,
    required this.name,
    required this.scientificName,
    required this.imageUrl,
    required this.watering,
    required this.sunlight,
    required this.description,
  });

  factory Plant.fromMap(Map<String, dynamic> map) {
    String scientificNameText = "";

    if (map["scientific_name"] != null && map["scientific_name"] is List) {
      scientificNameText = map["scientific_name"].join(", ");
    }

    String imageUrlText = "";
    if (map["default_image"] != null) {
      imageUrlText = map["default_image"]["regular_url"] ?? "";
    }

    String sunlightText = "";
    if (map["sunlight"] != null && map["sunlight"] is List) {
      sunlightText = map["sunlight"].join(", ");
    } else if (map["sunlight"] != null) {
      sunlightText = map["sunlight"].toString();
    }

    return Plant(
      apiId: map["id"] ?? 0,
      name: map["common_name"] ?? "Tanaman tanpa nama",
      scientificName: scientificNameText,
      imageUrl: imageUrlText,
      watering: map["watering"] ?? "Data watering tidak tersedia",
      sunlight: sunlightText.isEmpty ? "Data sunlight tidak tersedia" : sunlightText,
      description: map["description"] ?? "Data deskripsi tidak tersedia",
    );
  }

  Map<String, dynamic> toMap() => {
    "apiId": apiId,
    "name": name,
    "scientificName": scientificName,
    "imageUrl": imageUrl,
    "watering": watering,
    "sunlight": sunlight,
    "description": description,
  };
}
```

---

## 10. Model `MyPlant`

File:

```text
lib/model/my_plant.dart
```

Fungsi:

Model untuk data tanaman yang disimpan ke SQLite.

Field minimal:

```text
id
apiId
name
scientificName
imageUrl
localImagePath
watering
sunlight
note
createdAt
```

Contoh konsep:

```dart
class MyPlant {
  int? id;
  int? apiId;
  String name;
  String scientificName;
  String imageUrl;
  String localImagePath;
  String watering;
  String sunlight;
  String note;
  String createdAt;

  MyPlant({
    this.id,
    this.apiId,
    required this.name,
    required this.scientificName,
    required this.imageUrl,
    required this.localImagePath,
    required this.watering,
    required this.sunlight,
    required this.note,
    required this.createdAt,
  });

  factory MyPlant.fromMap(Map<String, dynamic> map) => MyPlant(
    id: map["id"],
    apiId: map["api_id"],
    name: map["name"] ?? "",
    scientificName: map["scientific_name"] ?? "",
    imageUrl: map["image_url"] ?? "",
    localImagePath: map["local_image_path"] ?? "",
    watering: map["watering"] ?? "",
    sunlight: map["sunlight"] ?? "",
    note: map["note"] ?? "",
    createdAt: map["created_at"] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "api_id": apiId,
    "name": name,
    "scientific_name": scientificName,
    "image_url": imageUrl,
    "local_image_path": localImagePath,
    "watering": watering,
    "sunlight": sunlight,
    "note": note,
    "created_at": createdAt,
  };
}
```

Catatan:

- Jika insert data baru, `id` boleh null.
- Jika error karena id null saat insert, hapus `id` dari map sebelum insert.

---

## 11. Auth Controller

File:

```text
lib/controller/auth_controller.dart
```

Fungsi:

1. Mengecek status login.
2. Login sederhana.
3. Logout.
4. Menyimpan status login ke SharedPreferences.

State:

```text
isLoading
isLoggedIn
```

Data login default:

```text
username: admin
password: admin123
```

Method yang dibutuhkan:

| Method               | Fungsi                   |
| -------------------- | ------------------------ |
| `checkLoginStatus()` | Mengecek status login    |
| `login()`            | Login sederhana          |
| `logout()`           | Logout                   |
| `showLogoutDialog()` | Dialog konfirmasi logout |

Konsep implementasi:

```dart
class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  Future<void> checkLoginStatus() async {}

  Future<void> login(String username, String password) async {}

  Future<void> logout() async {}

  void showLogoutDialog() {}
}
```

Catatan:

- Gunakan SharedPreferences.
- Setelah login berhasil, gunakan `Get.offAll(() => const HomeScreen())`.
- Setelah logout, gunakan `Get.offAll(() => const LoginScreen())`.
- Gunakan `Get.snackbar()` untuk pesan.

---

## 12. Plant Controller

File:

```text
lib/controller/plant_controller.dart
```

Fungsi:

1. Mengambil daftar tanaman dari API.
2. Search tanaman.
3. Mengambil detail tanaman.
4. Menyimpan data selected plant.
5. Mengatur loading.

State:

```text
plants
selectedPlant
isLoading
keyword
```

Method yang dibutuhkan:

| Method                         | Fungsi                                |
| ------------------------------ | ------------------------------------- |
| `fetchPlants()`                | Mengambil list tanaman                |
| `searchPlants(String keyword)` | Search tanaman                        |
| `fetchPlantDetail(int id)`     | Mengambil detail tanaman              |
| `clearSearch()`                | Menghapus search dan memuat list awal |

Konsep:

```dart
class PlantController extends GetxController {
  var plants = <Plant>[].obs;
  var selectedPlant = Rxn<Plant>();
  var isLoading = false.obs;

  Future<void> fetchPlants() async {}

  Future<void> searchPlants(String keyword) async {}

  Future<void> fetchPlantDetail(int id) async {}
}
```

Catatan:

- Gunakan package `http`.
- Gunakan `jsonDecode`.
- Gunakan try-catch.
- Jangan menggunakan Dio.
- Jika gagal, tampilkan `Get.snackbar()`.

---

## 13. Database Provider

File:

```text
lib/provider/database_provider.dart
```

Fungsi:

1. Membuka database SQLite.
2. Membuat database jika belum ada.
3. Membuat table `my_garden`.

Database:

```text
plantcare.db
```

Table:

```text
my_garden
```

SQL create table:

```sql
CREATE TABLE my_garden (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  api_id INTEGER,
  name TEXT,
  scientific_name TEXT,
  image_url TEXT,
  local_image_path TEXT,
  watering TEXT,
  sunlight TEXT,
  note TEXT,
  created_at TEXT
);
```

Catatan:

- Gunakan singleton sederhana.
- Gunakan `sqflite`.
- Gunakan `path`.
- Jangan membuat database logic di screen.

---

## 14. My Plant DataAccess

File:

```text
lib/dataaccess/my_plant_dataaccess.dart
```

Fungsi:

CRUD SQLite untuk table `my_garden`.

Method yang dibutuhkan:

| Method                       | Fungsi                    |
| ---------------------------- | ------------------------- |
| `insertPlant(MyPlant plant)` | Insert data               |
| `getAllPlants()`             | Ambil semua data          |
| `getPlantById(int id)`       | Ambil data berdasarkan ID |
| `updatePlant(MyPlant plant)` | Update data               |
| `deletePlant(int id)`        | Delete data               |

Catatan:

- DataAccess hanya untuk query SQLite.
- Jangan menaruh UI logic di DataAccess.
- Jangan menaruh snackbar di DataAccess jika ingin lebih rapi.
- Snackbar cukup dari controller.

---

## 15. Garden Controller

File:

```text
lib/controller/garden_controller.dart
```

Fungsi:

1. Mengambil data My Garden.
2. Insert tanaman.
3. Update tanaman.
4. Delete tanaman.
5. Ambil foto dari kamera.
6. Mengatur state form.

State:

```text
myPlants
isLoading
imagePath
```

Method yang dibutuhkan:

| Method                            | Fungsi                 |
| --------------------------------- | ---------------------- |
| `loadPlants()`                    | Ambil data SQLite      |
| `addPlant(MyPlant plant)`         | Insert tanaman         |
| `updatePlant(MyPlant plant)`      | Update tanaman         |
| `deletePlant(int id)`             | Delete tanaman         |
| `pickImageFromCamera()`           | Ambil foto dari kamera |
| `clearFormState()`                | Reset state form       |
| `showDeleteDialog(MyPlant plant)` | Konfirmasi hapus       |

Catatan:

- Gunakan `ImagePicker`.
- Simpan path gambar ke `imagePath`.
- Setelah insert/update/delete, panggil ulang `loadPlants()`.
- Gunakan `Get.snackbar()` untuk pesan.

---

## 16. Screen Implementation Order

Implementasi screen sebaiknya dilakukan urut seperti ini:

```text
1. splash_screen.dart
2. login_screen.dart
3. home_screen.dart
4. detail_screen.dart
5. my_garden_screen.dart
6. plant_form_screen.dart
7. profile_screen.dart
```

Alasan:

1. Splash dan login menentukan alur awal.
2. Home dan detail menguji REST API.
3. My Garden dan form menguji SQLite CRUD.
4. Profile menyelesaikan logout.

---

## 17. Splash Screen Implementation

File:

```text
lib/screen/splash_screen.dart
```

Tugas:

1. Tampilkan logo leaf.
2. Tampilkan nama PlantCare.
3. Tampilkan loading.
4. Panggil `AuthController.checkLoginStatus()`.
5. Arahkan ke Login atau Home.

Catatan:

- Gunakan `Get.put(AuthController())`.
- Gunakan `Get.offAll()`.
- Tidak perlu animasi kompleks.

---

## 18. Login Screen Implementation

File:

```text
lib/screen/login_screen.dart
```

Tugas:

1. Buat form login.
2. Buat input username.
3. Buat input password.
4. Validasi input.
5. Panggil `AuthController.login()`.
6. Navigasi ke Home jika berhasil.

Komponen:

```text
Scaffold
SingleChildScrollView
Form
TextFormField
ElevatedButton
```

Catatan:

- Password gunakan `obscureText: true`.
- Gunakan desain dari `01_login_home_plant_detail.png`.
- Jangan buat register atau forgot password.

---

## 19. Home Screen Implementation

File:

```text
lib/screen/home_screen.dart
```

Tugas:

1. Tampilkan AppBar PlantCare.
2. Tampilkan search bar.
3. Tampilkan list tanaman.
4. Tampilkan loading.
5. Tampilkan empty state jika data kosong.
6. Navigasi ke Detail Screen saat card diklik.
7. Navigasi ke My Garden.
8. Navigasi ke Profile.

Komponen:

```text
Scaffold
AppBar
TextField
ListView.builder
Card
CachedNetworkImage
BottomNavigationBar
```

Catatan:

- Gunakan `PlantController`.
- Gunakan `Obx()`.
- Data awal dari `fetchPlants()`.
- Search cukup menggunakan tombol search, tidak harus real-time.

---

## 20. Detail Screen Implementation

File:

```text
lib/screen/detail_screen.dart
```

Tugas:

1. Tampilkan gambar besar tanaman.
2. Tampilkan nama tanaman.
3. Tampilkan nama ilmiah.
4. Tampilkan watering.
5. Tampilkan sunlight.
6. Tampilkan deskripsi.
7. Buat tombol Save to My Garden.
8. Simpan data ke SQLite melalui `GardenController`.

Catatan:

- Data plant dapat diterima dari `Get.arguments`.
- Jika detail API dipakai, panggil `fetchPlantDetail(id)`.
- Gunakan desain dari `01_login_home_plant_detail.png`.

---

## 21. My Garden Screen Implementation

File:

```text
lib/screen/my_garden_screen.dart
```

Tugas:

1. Load data SQLite.
2. Tampilkan list My Garden.
3. Tampilkan empty state jika kosong.
4. Tombol add plant.
5. Tombol edit.
6. Tombol delete.
7. Bottom navigation.

Catatan:

- Gunakan `GardenController`.
- Gunakan `Obx()`.
- Untuk gambar:
  1. Jika `localImagePath` ada, gunakan `Image.file`.
  2. Jika tidak ada tetapi `imageUrl` ada, gunakan `CachedNetworkImage`.
  3. Jika kosong, tampilkan placeholder.

---

## 22. Plant Form Screen Implementation

File:

```text
lib/screen/plant_form_screen.dart
```

Tugas:

1. Bisa digunakan untuk Add dan Edit.
2. Jika mode Add, form kosong.
3. Jika mode Edit, form terisi data lama.
4. User bisa ambil foto.
5. Save insert data ke SQLite.
6. Update mengubah data SQLite.

Parameter yang dapat dikirim lewat `Get.arguments`:

```text
mode: add / edit
plant: MyPlant
```

Field form:

```text
Plant Name
Scientific Name
Watering
Sunlight
Note
Photo
```

Validasi:

1. Plant Name wajib.
2. Watering wajib.
3. Sunlight wajib.

Catatan:

- Gunakan `GlobalKey<FormState>`.
- Gunakan `TextEditingController`.
- Gunakan `SingleChildScrollView`.
- Gunakan desain dari `02_my_garden_add_plant_edit_plant.png`.

---

## 23. Profile Screen Implementation

File:

```text
lib/screen/profile_screen.dart
```

Tugas:

1. Tampilkan username `admin`.
2. Tampilkan subtitle `PlantCare User`.
3. Tampilkan jumlah tanaman tersimpan.
4. Tampilkan app version `1.0.0`.
5. Tampilkan tombol logout.
6. Logout menggunakan dialog konfirmasi.

Catatan:

- Tidak perlu edit profile.
- Tidak perlu upload avatar.
- Gunakan desain dari `03_splash_profile_empty_error_states.png`.

---

## 24. Empty State dan Error State

Empty state dan error state bisa dibuat langsung di screen masing-masing atau dibuat sebagai widget kecil jika ingin rapi.

Jika membuat widget, letakkan di:

```text
lib/screen/
```

atau langsung di dalam screen.

Jangan membuat folder widget jika tidak diperlukan, kecuali project sudah mulai sulit dibaca.

Empty state digunakan saat:

1. My Garden kosong.
2. Search tidak menemukan hasil.

Error state digunakan saat:

1. API gagal.
2. SQLite gagal.
3. Data detail gagal dimuat.

Contoh teks empty state:

```text
No plants yet
Your garden is still empty. Add your first plant to get started.
```

Contoh teks error state:

```text
Something went wrong
Failed to load plant data. Please check your connection and try again.
```

---

## 25. Navigation Guide

Gunakan GetX navigation.

Contoh:

```dart
Get.to(() => const MyGardenScreen());
Get.to(() => DetailScreen(), arguments: plant);
Get.back();
Get.offAll(() => const LoginScreen());
```

Aturan:

1. `Get.to()` untuk pindah halaman biasa.
2. `Get.back()` untuk kembali.
3. `Get.offAll()` untuk login/logout agar stack halaman dibersihkan.
4. Jangan membuat route management kompleks dulu.

---

## 26. Snackbar dan Dialog

Gunakan `Get.snackbar()` untuk pesan.

Contoh pesan sukses:

```text
Berhasil
Data tanaman berhasil disimpan
```

Contoh pesan error:

```text
Gagal
Gagal mengambil data tanaman
```

Gunakan `Get.dialog()` untuk:

1. Konfirmasi hapus tanaman.
2. Konfirmasi logout.

Dialog delete:

```text
Title: Hapus Tanaman
Message: Apakah kamu yakin ingin menghapus tanaman ini?
Button: Batal, Hapus
```

Dialog logout:

```text
Title: Logout
Message: Apakah kamu yakin ingin keluar?
Button: Batal, Logout
```

---

## 27. REST API Implementation Notes

Endpoint yang digunakan:

```text
GET /species-list?key=API_KEY
GET /species-list?key=API_KEY&q=KEYWORD
GET /species/details/{id}?key=API_KEY
```

Base URL:

```text
https://perenual.com/api
```

Hal yang perlu diperhatikan:

1. Response list berada pada field `data`.
2. `scientific_name` bisa berbentuk list.
3. `default_image` bisa null.
4. `sunlight` bisa list.
5. `watering` bisa kosong.
6. Gunakan default text jika data kosong.

Jangan langsung percaya semua field API selalu ada.

---

## 28. SQLite Implementation Notes

Database:

```text
plantcare.db
```

Table:

```text
my_garden
```

Saat insert data baru:

1. `id` boleh null.
2. `api_id` boleh null.
3. `local_image_path` boleh kosong.
4. `image_url` boleh kosong.

Setelah insert/update/delete:

1. Panggil ulang `loadPlants()`.
2. Tampilkan snackbar.
3. Kembali ke My Garden jika dari form.

---

## 29. Camera Implementation Notes

Gunakan package:

```text
image_picker
```

Flow:

```text
User klik tombol kamera
    ↓
ImagePicker membuka kamera
    ↓
User mengambil foto
    ↓
Path foto disimpan ke imagePath
    ↓
Preview foto ditampilkan
    ↓
Saat save, path disimpan ke SQLite
```

Catatan:

- Tidak perlu upload gambar ke server.
- Tidak perlu crop image.
- Tidak perlu compress image.
- Simpan path saja di SQLite.
- Jika user batal mengambil foto, jangan tampilkan error berlebihan.

---

## 30. UI Implementation Notes

Gunakan referensi desain dari folder:

```text
docs/ui-reference/
```

Prinsip UI:

1. Light mode only.
2. Primary color hijau.
3. Background terang.
4. Card putih.
5. Rounded corner.
6. Soft shadow sederhana.
7. Jarak antar elemen cukup.
8. Tidak perlu animasi kompleks.
9. Gunakan Material Design sederhana.

Warna utama:

```text
Primary: #2E7D32
Secondary: #66BB6A
Background: #F7FAF5
Text: #263238
Subtext: #757575
```

---

## 31. Manual Testing Checklist

Gunakan checklist ini setelah implementasi.

| No  | Test Case                                     | Status |
| --- | --------------------------------------------- | ------ |
| 1   | Aplikasi dapat dibuka                         | Belum  |
| 2   | Splash screen tampil                          | Belum  |
| 3   | User belum login diarahkan ke Login           | Belum  |
| 4   | Login dengan username/password benar berhasil | Belum  |
| 5   | Login dengan username/password salah gagal    | Belum  |
| 6   | Home menampilkan list tanaman dari API        | Belum  |
| 7   | Search tanaman berjalan                       | Belum  |
| 8   | Detail tanaman tampil                         | Belum  |
| 9   | Save to My Garden berhasil                    | Belum  |
| 10  | My Garden menampilkan data SQLite             | Belum  |
| 11  | Add Plant berhasil                            | Belum  |
| 12  | Edit Plant berhasil                           | Belum  |
| 13  | Delete Plant berhasil                         | Belum  |
| 14  | Dialog delete muncul                          | Belum  |
| 15  | Kamera dapat mengambil foto                   | Belum  |
| 16  | Foto tampil di form                           | Belum  |
| 17  | Foto tersimpan sebagai path lokal             | Belum  |
| 18  | Profile tampil                                | Belum  |
| 19  | Logout berhasil                               | Belum  |
| 20  | Aplikasi tidak crash saat API gagal           | Belum  |

---

## 32. Hal yang Tidak Perlu Dikerjakan

Agar project tetap sederhana, jangan mengerjakan:

1. Register user.
2. Login backend asli.
3. Firebase.
4. Push notification.
5. AI plant detection.
6. Upload foto ke server.
7. Maps.
8. Dark mode.
9. Multi-language.
10. Role admin dan user.
11. Clean Architecture.
12. Repository pattern.
13. Unit test.
14. Widget test.
15. Code generation.
16. Complex animation.
17. Advanced dependency injection.

---

## 33. Target Akhir Implementasi

Project dianggap selesai jika:

1. Aplikasi dapat dijalankan.
2. Splash mengecek status login.
3. Login dan logout berjalan.
4. Home menampilkan data tanaman dari API.
5. Search tanaman berjalan.
6. Detail tanaman tampil.
7. Tanaman dapat disimpan ke My Garden.
8. My Garden menggunakan SQLite.
9. CRUD SQLite berjalan.
10. Form tambah dan edit berjalan.
11. Kamera berjalan.
12. Foto tersimpan sebagai path lokal.
13. UI mengikuti referensi desain.
14. GetX digunakan untuk state dan navigation.
15. Project tetap sederhana dan sesuai `AGENTS.md`.

---

## 34. Kesimpulan

Implementation Guide ini menjadi panduan teknis untuk membangun PlantCare App secara bertahap.

Ikuti dokumen ini bersama `AGENTS.md` agar project tetap sederhana, mudah dipahami, dan sesuai dengan materi perkuliahan Flutter.
