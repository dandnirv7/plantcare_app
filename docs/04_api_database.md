# API & Database - PlantCare App

## 1. Ringkasan

Dokumen ini menjelaskan rancangan penggunaan REST API dan database lokal SQLite pada PlantCare App.

Aplikasi menggunakan dua sumber data utama:

1. **Public API**
   Digunakan untuk mengambil daftar tanaman dan detail tanaman.

2. **SQLite Local Database**
   Digunakan untuk menyimpan tanaman pengguna pada fitur My Garden.

Project ini dibuat sederhana sesuai kebutuhan mata kuliah Flutter. Struktur project mengikuti MVC sederhana:

```text id="k4yc5e"
lib/
  model/
  controller/
  screen/
  dataaccess/
  provider/
```

---

## 2. Public API

## 2.1 API yang Digunakan

Public API utama yang digunakan:

```text id="gtb2ks"
Perenual Plant API
```

Base URL:

```text id="3pfulh"
https://perenual.com/api
```

API ini digunakan untuk mengambil data tanaman seperti nama tanaman, nama ilmiah, gambar, kebutuhan air, dan kebutuhan cahaya.

---

## 2.2 API Key

Perenual API membutuhkan API key.

API key disimpan di satu file agar mudah dikelola.

Rekomendasi file:

```text id="z281hn"
lib/utils/constants.dart
```

Contoh isi:

```dart id="37hppq"
const String baseUrl = "https://perenual.com/api";
const String apiKey = "ISI_API_KEY_KAMU";
```

Catatan:

1. Jangan menulis API key berulang-ulang di banyak file.
2. Jangan menampilkan API key di halaman aplikasi.
3. Untuk project kuliah, penyimpanan API key di constants masih cukup.
4. Jika materi security dibahas lebih lanjut, API key dapat dipindahkan ke metode penyimpanan yang lebih aman.

---

## 3. Endpoint API

## 3.1 Get Plant List

Endpoint ini digunakan untuk mengambil daftar tanaman.

### Request

```text id="cxzv8w"
GET /species-list?key=API_KEY
```

### Full URL Contoh

```text id="fm8cr2"
https://perenual.com/api/species-list?key=API_KEY
```

### Fungsi di Aplikasi

Digunakan pada:

```text id="l2ecjk"
Home Screen
```

### Data yang Diambil

1. ID tanaman.
2. Nama umum tanaman.
3. Nama ilmiah.
4. Gambar tanaman.

---

## 3.2 Search Plant

Endpoint ini digunakan untuk mencari tanaman berdasarkan keyword.

### Request

```text id="j86zjz"
GET /species-list?key=API_KEY&q=KEYWORD
```

### Full URL Contoh

```text id="215wo1"
https://perenual.com/api/species-list?key=API_KEY&q=rose
```

### Fungsi di Aplikasi

Digunakan pada:

```text id="5znilp"
Home Screen Search
```

### Alur

1. Pengguna mengetik keyword.
2. Pengguna menekan tombol search.
3. Controller memanggil endpoint search.
4. List tanaman diperbarui.

---

## 3.3 Get Plant Detail

Endpoint ini digunakan untuk mengambil detail tanaman berdasarkan ID.

### Request

```text id="h49371"
GET /species/details/{id}?key=API_KEY
```

### Full URL Contoh

```text id="ygye3m"
https://perenual.com/api/species/details/1?key=API_KEY
```

### Fungsi di Aplikasi

Digunakan pada:

```text id="22niwu"
Detail Screen
```

### Data yang Diambil

1. ID tanaman.
2. Nama umum tanaman.
3. Nama ilmiah.
4. Gambar tanaman.
5. Watering.
6. Sunlight.
7. Deskripsi jika tersedia.

---

## 4. Struktur Response API

## 4.1 Response Plant List

Contoh bentuk response sederhana:

```json id="dc0bga"
{
  "data": [
    {
      "id": 1,
      "common_name": "European Silver Fir",
      "scientific_name": ["Abies alba"],
      "default_image": {
        "regular_url": "https://example.com/image.jpg"
      }
    }
  ]
}
```

### Field yang Digunakan

| Field API                   | Digunakan Sebagai | Keterangan        |
| --------------------------- | ----------------- | ----------------- |
| `id`                        | `apiId`           | ID dari API       |
| `common_name`               | `name`            | Nama umum tanaman |
| `scientific_name`           | `scientificName`  | Nama ilmiah       |
| `default_image.regular_url` | `imageUrl`        | Gambar tanaman    |

---

## 4.2 Response Plant Detail

Contoh bentuk response sederhana:

```json id="9x8dfr"
{
  "id": 1,
  "common_name": "European Silver Fir",
  "scientific_name": ["Abies alba"],
  "default_image": {
    "regular_url": "https://example.com/image.jpg"
  },
  "watering": "Frequent",
  "sunlight": ["full sun"],
  "description": "Plant description here"
}
```

### Field yang Digunakan

| Field API                   | Digunakan Sebagai | Keterangan        |
| --------------------------- | ----------------- | ----------------- |
| `id`                        | `apiId`           | ID dari API       |
| `common_name`               | `name`            | Nama umum tanaman |
| `scientific_name`           | `scientificName`  | Nama ilmiah       |
| `default_image.regular_url` | `imageUrl`        | Gambar tanaman    |
| `watering`                  | `watering`        | Kebutuhan air     |
| `sunlight`                  | `sunlight`        | Kebutuhan cahaya  |
| `description`               | `description`     | Deskripsi tanaman |

---

## 5. Model Data

Project menggunakan model sederhana dengan `fromMap()` dan `toMap()` manual.

Tidak menggunakan:

1. Freezed.
2. Json Serializable.
3. Build Runner.
4. Immutable pattern.
5. CopyWith.

---

## 5.1 Model Plant

Model `Plant` digunakan untuk data tanaman dari API.

File:

```text id="jm4v91"
lib/model/plant.dart
```

Field:

| Field            | Tipe   | Keterangan          |
| ---------------- | ------ | ------------------- |
| `apiId`          | int    | ID tanaman dari API |
| `name`           | String | Nama umum tanaman   |
| `scientificName` | String | Nama ilmiah         |
| `imageUrl`       | String | URL gambar tanaman  |
| `watering`       | String | Kebutuhan air       |
| `sunlight`       | String | Kebutuhan cahaya    |
| `description`    | String | Deskripsi tanaman   |

Catatan:

1. Field dibuat public.
2. Field tidak perlu final.
3. Jika data dari API kosong, gunakan string kosong atau `Data tidak tersedia`.
4. Scientific name dari API bisa berbentuk list, sehingga perlu diubah menjadi string.

---

## 5.2 Model MyPlant

Model `MyPlant` digunakan untuk data tanaman yang disimpan di SQLite.

File:

```text id="e92ckd"
lib/model/my_plant.dart
```

Field:

| Field            | Tipe   | Keterangan                |
| ---------------- | ------ | ------------------------- |
| `id`             | int?   | ID lokal SQLite           |
| `apiId`          | int?   | ID dari API, boleh kosong |
| `name`           | String | Nama tanaman              |
| `scientificName` | String | Nama ilmiah               |
| `imageUrl`       | String | URL gambar dari API       |
| `localImagePath` | String | Path foto dari kamera     |
| `watering`       | String | Kebutuhan air             |
| `sunlight`       | String | Kebutuhan cahaya          |
| `note`           | String | Catatan pengguna          |
| `createdAt`      | String | Tanggal dibuat            |

Catatan:

1. `id` boleh null saat data belum masuk ke SQLite.
2. `apiId` boleh null untuk tanaman manual.
3. `localImagePath` boleh kosong.
4. `imageUrl` boleh kosong.

---

## 6. SQLite Database

## 6.1 Nama Database

Nama database:

```text id="hpc5uk"
plantcare.db
```

---

## 6.2 Versi Database

Versi awal database:

```text id="a6b5e2"
1
```

---

## 6.3 Table

Nama table:

```text id="d5n1no"
my_garden
```

Table ini menyimpan data tanaman milik pengguna.

---

## 6.4 Struktur Table `my_garden`

| Kolom              | Tipe SQLite                       | Keterangan                  |
| ------------------ | --------------------------------- | --------------------------- |
| `id`               | INTEGER PRIMARY KEY AUTOINCREMENT | ID lokal                    |
| `api_id`           | INTEGER                           | ID dari API                 |
| `name`             | TEXT                              | Nama tanaman                |
| `scientific_name`  | TEXT                              | Nama ilmiah                 |
| `image_url`        | TEXT                              | URL gambar dari API         |
| `local_image_path` | TEXT                              | Path foto lokal dari kamera |
| `watering`         | TEXT                              | Kebutuhan air               |
| `sunlight`         | TEXT                              | Kebutuhan cahaya            |
| `note`             | TEXT                              | Catatan pengguna            |
| `created_at`       | TEXT                              | Tanggal dibuat              |

---

## 6.5 SQL Create Table

```sql id="slo0jh"
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

---

## 7. Provider Database

Database provider digunakan untuk membuka database SQLite.

File:

```text id="vttw5t"
lib/provider/database_provider.dart
```

Tanggung jawab:

1. Membuat koneksi database.
2. Membuat database jika belum ada.
3. Membuat table `my_garden`.
4. Menyediakan object database untuk dataaccess.

Catatan:

Database provider dibuat sebagai singleton sederhana agar koneksi database tidak dibuat berulang-ulang.

---

## 8. DataAccess

DataAccess digunakan untuk fungsi CRUD SQLite.

File:

```text id="c8mxh9"
lib/dataaccess/my_plant_dataaccess.dart
```

Fungsi yang dibutuhkan:

| Fungsi              | Keterangan                          |
| ------------------- | ----------------------------------- |
| `insertPlant()`     | Menambah tanaman ke SQLite          |
| `getAllPlants()`    | Mengambil semua tanaman dari SQLite |
| `getPlantById()`    | Mengambil tanaman berdasarkan ID    |
| `updatePlant()`     | Mengubah data tanaman               |
| `deletePlant()`     | Menghapus tanaman                   |
| `deleteAllPlants()` | Opsional, untuk reset data          |

---

## 9. CRUD SQLite

## 9.1 Insert Plant

Digunakan ketika:

1. Pengguna menyimpan tanaman dari API ke My Garden.
2. Pengguna menambahkan tanaman pribadi melalui form.

Data masuk ke table:

```text id="vncjsa"
my_garden
```

---

## 9.2 Read Plants

Digunakan pada:

```text id="eygvtx"
My Garden Screen
```

Aplikasi mengambil semua data dari SQLite dan menampilkannya menggunakan ListView.

---

## 9.3 Update Plant

Digunakan pada:

```text id="e4008q"
Edit Plant Screen
```

Data yang diperbarui:

1. Nama tanaman.
2. Nama ilmiah.
3. Watering.
4. Sunlight.
5. Catatan.
6. Path foto lokal.

---

## 9.4 Delete Plant

Digunakan pada:

```text id="3566fa"
My Garden Screen
```

Sebelum delete, tampilkan dialog konfirmasi.

---

## 10. Relasi API dan SQLite

Data dari API dapat disimpan ke SQLite.

Alur:

```text id="c33uyy"
Home Screen
    ↓
Pilih tanaman
    ↓
Detail Screen
    ↓
Klik Simpan ke My Garden
    ↓
Data disimpan ke SQLite
    ↓
My Garden Screen menampilkan data
```

Mapping data API ke SQLite:

| Data API                    | Kolom SQLite               |
| --------------------------- | -------------------------- |
| `id`                        | `api_id`                   |
| `common_name`               | `name`                     |
| `scientific_name`           | `scientific_name`          |
| `default_image.regular_url` | `image_url`                |
| `watering`                  | `watering`                 |
| `sunlight`                  | `sunlight`                 |
| `description`               | `note` atau tidak disimpan |

---

## 11. Data Tanaman Manual

Pengguna juga dapat menambahkan tanaman secara manual tanpa data dari API.

Untuk tanaman manual:

| Kolom              | Nilai                    |
| ------------------ | ------------------------ |
| `api_id`           | null                     |
| `name`             | Diisi user               |
| `scientific_name`  | Diisi user atau kosong   |
| `image_url`        | kosong                   |
| `local_image_path` | Path foto lokal jika ada |
| `watering`         | Diisi user               |
| `sunlight`         | Diisi user               |
| `note`             | Diisi user               |
| `created_at`       | Tanggal saat data dibuat |

---

## 12. Controller yang Menggunakan API dan Database

## 12.1 PlantController

File:

```text id="a8qgzz"
lib/controller/plant_controller.dart
```

Tanggung jawab:

1. Mengambil daftar tanaman dari API.
2. Search tanaman.
3. Mengambil detail tanaman.
4. Menyimpan state loading.
5. Menyimpan list tanaman.
6. Menampilkan error menggunakan snackbar.

State yang dibutuhkan:

```text id="hrfl8x"
plants
selectedPlant
isLoading
keyword
```

---

## 12.2 GardenController

File:

```text id="i5diln"
lib/controller/garden_controller.dart
```

Tanggung jawab:

1. Mengambil data My Garden dari SQLite.
2. Menambah tanaman ke SQLite.
3. Mengedit tanaman.
4. Menghapus tanaman.
5. Mengambil foto dari kamera.
6. Menyimpan state form sederhana.

State yang dibutuhkan:

```text id="cb3bv1"
myPlants
isLoading
imagePath
```

---

## 13. Format Tanggal

Package:

```text id="pu4hsv"
intl
```

Format tanggal yang digunakan:

```text id="h76i7z"
yyyy-MM-dd HH:mm:ss
```

Contoh:

```text id="lwxqb9"
2026-07-09 14:30:00
```

Tanggal disimpan pada kolom:

```text id="n6n3mz"
created_at
```

---

## 14. Penanganan Data Kosong

## 14.1 Data API Kosong

Jika API tidak mengembalikan gambar:

```text id="nx4ta7"
Gunakan placeholder image
```

Jika nama tanaman kosong:

```text id="ouimpn"
Tanaman tanpa nama
```

Jika watering kosong:

```text id="1yntai"
Data watering tidak tersedia
```

Jika sunlight kosong:

```text id="gvpofx"
Data sunlight tidak tersedia
```

---

## 14.2 Data SQLite Kosong

Jika My Garden kosong:

```text id="vfimdw"
Belum ada tanaman di My Garden.
```

---

## 15. Error Handling

Error handling dibuat sederhana menggunakan try-catch.

## 15.1 Error API

Jika API gagal:

1. Set `isLoading` menjadi false.
2. Tampilkan snackbar.
3. Jangan crash aplikasi.

Pesan:

```text id="l4k6ja"
Gagal mengambil data tanaman
```

---

## 15.2 Error SQLite

Jika SQLite gagal:

1. Tampilkan snackbar.
2. Jangan crash aplikasi.

Pesan:

```text id="hbjvis"
Terjadi kesalahan database
```

---

## 15.3 Error Camera

Jika kamera gagal:

1. Tampilkan snackbar.
2. Jangan simpan path kosong sebagai error.

Pesan:

```text id="zr79ij"
Gagal mengambil foto
```

---

## 16. Security API

Untuk project ini, security API dibuat sederhana.

Aturan:

1. Base URL dan API key disimpan di satu file constants.
2. API key tidak ditulis langsung di screen.
3. API request dilakukan dari controller.
4. Jangan print API key di console.
5. Jangan tampilkan API key di UI.
6. Gunakan try-catch saat request API.

File yang disarankan:

```text id="gwmhth"
lib/utils/constants.dart
```

Isi minimal:

```dart id="odxink"
const String baseUrl = "https://perenual.com/api";
const String apiKey = "ISI_API_KEY_KAMU";
```

---

## 17. Contoh Struktur File Terkait API dan Database

```text id="hd2scg"
lib/
  model/
    plant.dart
    my_plant.dart

  controller/
    plant_controller.dart
    garden_controller.dart

  provider/
    database_provider.dart

  dataaccess/
    my_plant_dataaccess.dart

  utils/
    constants.dart
```

---

## 18. Urutan Implementasi

Urutan pengerjaan yang disarankan:

1. Buat `utils/constants.dart`.
2. Buat model `plant.dart`.
3. Buat model `my_plant.dart`.
4. Buat `plant_controller.dart`.
5. Tampilkan data API di Home Screen.
6. Buat `database_provider.dart`.
7. Buat `my_plant_dataaccess.dart`.
8. Buat `garden_controller.dart`.
9. Tampilkan data SQLite di My Garden Screen.
10. Tambahkan fungsi insert.
11. Tambahkan fungsi update.
12. Tambahkan fungsi delete.
13. Tambahkan kamera.
14. Tambahkan error handling sederhana.

---

## 19. Catatan Penting untuk Coding

1. Jangan membuat folder `repository/`.
2. Jangan membuat folder `usecase/`.
3. Jangan membuat folder `services/` jika mengikuti aturan MVC sederhana.
4. Jangan menggunakan Dio.
5. Jangan menggunakan Firebase.
6. Jangan menggunakan code generator.
7. Jangan menggunakan immutable model.
8. Gunakan `fromMap()` dan `toMap()` manual.
9. Gunakan `GetxController`.
10. Gunakan `Obx()` untuk update UI.
11. Gunakan `Get.snackbar()` untuk pesan berhasil atau gagal.

---

## 20. Kesimpulan

Rancangan API dan database pada PlantCare App dibuat sederhana agar sesuai dengan materi perkuliahan. Public API digunakan untuk mengambil data tanaman, sedangkan SQLite digunakan untuk menyimpan data My Garden.

Dengan rancangan ini, aplikasi sudah dapat menerapkan REST API, SQLite, CRUD, form, ListView, kamera, dan security API secara sederhana tanpa menggunakan arsitektur yang terlalu kompleks.
