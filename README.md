# PlantCare App

PlantCare App adalah project UAS berbasis Flutter untuk membantu pengguna mencari informasi tanaman, melihat detail perawatan tanaman, dan mengelola koleksi tanaman pribadi melalui fitur **My Garden**.

Aplikasi ini menggabungkan data tanaman dari **Perenual Plant API**, autentikasi lokal menggunakan SQLite, penyimpanan data tanaman lokal, fitur kamera, lokasi GPS, dan pengamanan sederhana pada pemanggilan API.

---

## Fitur Utama

PlantCare App memiliki fitur utama berikut:

- Registrasi user lokal menggunakan SQLite
- Login menggunakan akun yang sudah didaftarkan
- Penyimpanan sesi login menggunakan SharedPreferences
- Splash screen untuk mengecek status login
- Daftar tanaman dari public REST API
- Pencarian tanaman
- Detail tanaman
- Simpan tanaman dari API ke My Garden
- Tambah tanaman pribadi
- Edit tanaman pribadi
- Hapus tanaman pribadi
- Penyimpanan lokal menggunakan SQLite
- Ambil foto tanaman menggunakan kamera
- Rekam video tanaman menggunakan kamera
- Simpan path foto dan video secara lokal
- Ambil lokasi GPS pengguna
- Simpan latitude dan longitude tanaman
- Tampilan lokasi tanaman menggunakan koordinat
- Preview peta sederhana menggunakan OpenStreetMap
- Profile user
- Logout
- Empty state dan error state sederhana
- Security API Call sederhana

---

## Kebutuhan UAS yang Dipenuhi

Aplikasi ini dibuat untuk memenuhi kebutuhan UAS berikut:

| No  | Kebutuhan              | Implementasi                                                                              |
| --- | ---------------------- | ----------------------------------------------------------------------------------------- |
| 1   | Widget Layout          | Layout pada Login, Register, Home, Detail, My Garden, Form, dan Profile                   |
| 2   | Widget Component       | Text, Icon, Image, Card, Button, TextFormField, ListTile, AppBar, dan lainnya             |
| 3   | Navigasi               | Navigasi antar halaman menggunakan GetX                                                   |
| 4   | List View              | ListView untuk daftar tanaman dan My Garden                                               |
| 5   | Local Storage SQLite   | SQLite untuk data user dan data tanaman                                                   |
| 6   | Widget Form            | Form register, login, tambah tanaman, dan edit tanaman                                    |
| 7   | REST API               | Mengambil data tanaman dari Perenual Plant API                                            |
| 8   | Camera Picture + Video | Mengambil foto dan merekam video menggunakan image_picker                                 |
| 9   | GPS & Location         | Mengambil latitude dan longitude menggunakan geolocator                                   |
| 10  | Security API Call      | API key dari `.env`, validasi API key, try-catch, timeout, dan pengecekan status response |

---

## Teknologi yang Digunakan

Aplikasi ini menggunakan teknologi berikut:

- Flutter
- Dart
- GetX
- REST API
- SQLite
- SharedPreferences
- Image Picker
- Geolocator
- OpenStreetMap
- Flutter Dotenv

---

## Package yang Digunakan

Package utama yang digunakan:

- `get`
- `http`
- `sqflite`
- `path`
- `path_provider`
- `image_picker`
- `shared_preferences`
- `intl`
- `cached_network_image`
- `geolocator`
- `flutter_dotenv`
- `flutter_map`
- `latlong2`
- `cupertino_icons`
- `flutter_lints`

---

## Struktur Folder

Struktur folder utama project:

```text
lib/
  main.dart

  model/
    plant.dart
    my_plant.dart
    user.dart

  controller/
    auth_controller.dart
    plant_controller.dart
    garden_controller.dart

  screen/
    splash_screen.dart
    login_screen.dart
    register_screen.dart
    home_screen.dart
    detail_screen.dart
    my_garden_screen.dart
    plant_form_screen.dart
    profile_screen.dart

  dataaccess/
    user_dataaccess.dart
    my_plant_dataaccess.dart

  provider/
    database_provider.dart

  utils/
    constants.dart

docs/
  01_prd.md
  02_mvp.md
  03_features.md
  04_api_database.md
  05_project_plan.md
  06_user_flow.md
  07_screen_list.md
  08_implementation_guide.md
  09_testing_checklist.md
  10_uas_requirement_mapping.md

docs/ui_reference/
  01_auth_home_detail.png
  02_garden_form_crud.png
  03_splash_profile_states.png
```

---

## Arsitektur Project

Project ini menggunakan arsitektur **MVC sederhana** agar tetap mudah dipahami dan sesuai dengan pembelajaran mata kuliah.

Pembagian folder:

| Folder        | Fungsi                                                       |
| ------------- | ------------------------------------------------------------ |
| `model/`      | Berisi class data seperti Plant, MyPlant, dan User           |
| `controller/` | Berisi logic aplikasi dan state menggunakan GetX             |
| `screen/`     | Berisi tampilan halaman aplikasi                             |
| `dataaccess/` | Berisi fungsi CRUD SQLite                                    |
| `provider/`   | Berisi konfigurasi database SQLite                           |
| `utils/`      | Berisi konfigurasi umum seperti warna, base URL, dan API key |

Project ini tidak menggunakan Clean Architecture, Repository Pattern, BLoC, Riverpod, atau struktur yang terlalu kompleks.

---

## Public API

Aplikasi menggunakan **Perenual Plant API** untuk mengambil data tanaman.

Base URL:

```text
https://perenual.com/api
```

Endpoint utama:

```text
/species-list
/species/details/{id}
```

Fitur API yang digunakan:

- Mengambil daftar tanaman
- Mencari tanaman
- Mengambil detail tanaman

---

## Environment Setup

API key disimpan menggunakan file `.env`.

Langkah setup:

1. Copy file `.env.example` menjadi `.env`.

```bash
cp .env.example .env
```

2. Isi API key Perenual di file `.env`.

```text
PERENUAL_API_KEY=your_perenual_api_key
```

3. Pastikan file `.env` tidak di-commit ke repository public.

---

## Security API Call

Security API Call pada project ini dibuat sederhana dan sesuai kebutuhan UAS.

Implementasi yang digunakan:

- API key tidak ditulis langsung di screen
- API key dibaca dari `.env` menggunakan `flutter_dotenv`
- `constants.dart` menyediakan getter untuk API key
- API key tidak ditampilkan di UI
- API key tidak di-print atau di-log
- Request API dilakukan melalui `PlantController`
- API call menggunakan `try-catch`
- API call mengecek `response.statusCode`
- API call menggunakan timeout
- Jika API key kosong atau request gagal, aplikasi menampilkan snackbar error

Dengan pendekatan ini, aplikasi tidak crash saat request gagal dan pemanggilan API menjadi lebih aman serta terstruktur.

---

## Autentikasi Lokal

Aplikasi menggunakan autentikasi lokal berbasis SQLite.

Alur autentikasi:

1. User membuka aplikasi.
2. Jika belum login, user diarahkan ke Login Screen.
3. User dapat membuka Register Screen untuk membuat akun.
4. Data user disimpan ke table `users` di SQLite.
5. Setelah register, user login menggunakan akun yang sudah dibuat.
6. Status login dan username disimpan menggunakan SharedPreferences.
7. Profile menampilkan username user yang sedang login.
8. Logout menghapus session dan mengarahkan user kembali ke Login Screen.

Catatan:

Password pada project ini disimpan secara plain text hanya untuk kebutuhan pembelajaran dan demo UAS. Cara ini tidak disarankan untuk aplikasi production.

---

## Database SQLite

Database lokal yang digunakan:

```text
plantcare.db
```

Table utama:

```text
users
my_garden
```

### Table `users`

Table `users` digunakan untuk menyimpan akun lokal.

Field utama:

| Field        | Keterangan          |
| ------------ | ------------------- |
| `id`         | ID user             |
| `username`   | Username user       |
| `password`   | Password user       |
| `created_at` | Tanggal akun dibuat |

### Table `my_garden`

Table `my_garden` digunakan untuk menyimpan data tanaman pribadi.

Field utama:

| Field              | Keterangan                 |
| ------------------ | -------------------------- |
| `id`               | ID lokal tanaman           |
| `api_id`           | ID tanaman dari API        |
| `name`             | Nama tanaman               |
| `scientific_name`  | Nama ilmiah                |
| `image_url`        | URL gambar dari API        |
| `local_image_path` | Path foto lokal            |
| `local_video_path` | Path video lokal           |
| `watering`         | Informasi kebutuhan air    |
| `sunlight`         | Informasi kebutuhan cahaya |
| `note`             | Catatan tanaman            |
| `latitude`         | Latitude lokasi tanaman    |
| `longitude`        | Longitude lokasi tanaman   |
| `created_at`       | Tanggal data dibuat        |

---

## Camera Picture dan Video

Aplikasi menggunakan package `image_picker` untuk fitur kamera.

Fitur kamera:

- Mengambil foto tanaman
- Merekam video tanaman
- Menampilkan status media pada form
- Menyimpan path foto ke SQLite
- Menyimpan path video ke SQLite

Catatan:

Aplikasi tidak melakukan upload foto atau video ke server. Data media hanya disimpan sebagai path lokal di perangkat.

---

## GPS dan Location

Aplikasi menggunakan package `geolocator` untuk mengambil lokasi pengguna.

Data lokasi yang digunakan:

- Latitude
- Longitude

Alur fitur lokasi:

1. User membuka form tambah/edit tanaman.
2. User menekan tombol ambil lokasi.
3. Aplikasi meminta izin lokasi.
4. Jika izin diberikan, aplikasi mengambil latitude dan longitude.
5. Latitude dan longitude disimpan ke SQLite bersama data tanaman.
6. Data lokasi ditampilkan di My Garden.

Aplikasi juga dapat menampilkan preview peta sederhana menggunakan OpenStreetMap melalui `flutter_map`. Fitur ini tidak membutuhkan Google Maps API key.

---

## UI Reference

Referensi desain UI berada di folder:

```text
docs/ui_reference/
```

Daftar file:

```text
01_auth_home_detail.png
02_garden_form_crud.png
03_splash_profile_states.png
```

Keterangan:

| File                           | Isi                                           |
| ------------------------------ | --------------------------------------------- |
| `01_auth_home_detail.png`      | Login, Home, dan Detail Tanaman               |
| `02_garden_form_crud.png`      | My Garden, Add Plant, dan Edit Plant          |
| `03_splash_profile_states.png` | Splash, Profile, Empty State, dan Error State |

---

## Cara Menjalankan Project

Pastikan Flutter sudah terinstall.

Install dependencies:

```bash
flutter pub get
```

Jalankan aplikasi:

```bash
flutter run
```

Cek error analyzer:

```bash
flutter analyze
```

---

## Manual Testing

Checklist manual testing lengkap tersedia di:

```text
docs/09_testing_checklist.md
```

Ringkasan test yang perlu dilakukan:

| No  | Test Case                                        | Status |
| --- | ------------------------------------------------ | ------ |
| 1   | Splash screen muncul                             | [ ]    |
| 2   | Register user baru berhasil                      | [ ]    |
| 3   | Login dengan user terdaftar berhasil             | [ ]    |
| 4   | Login dengan data salah gagal                    | [ ]    |
| 5   | Home menampilkan data tanaman dari API           | [ ]    |
| 6   | Search tanaman berjalan                          | [ ]    |
| 7   | Detail tanaman tampil                            | [ ]    |
| 8   | Save to My Garden berhasil                       | [ ]    |
| 9   | My Garden menampilkan data SQLite                | [ ]    |
| 10  | Add Plant berhasil                               | [ ]    |
| 11  | Edit Plant berhasil                              | [ ]    |
| 12  | Delete Plant berhasil                            | [ ]    |
| 13  | Kamera berhasil mengambil foto                   | [ ]    |
| 14  | Kamera berhasil merekam video                    | [ ]    |
| 15  | Foto dan video tersimpan sebagai path lokal      | [ ]    |
| 16  | GPS berhasil mengambil latitude dan longitude    | [ ]    |
| 17  | Lokasi tersimpan di SQLite                       | [ ]    |
| 18  | Preview map tampil jika koordinat valid          | [ ]    |
| 19  | Profile menampilkan username login               | [ ]    |
| 20  | Logout berhasil                                  | [ ]    |
| 21  | Back button setelah logout tidak kembali ke Home | [ ]    |
| 22  | API error tidak membuat aplikasi crash           | [ ]    |

---

## Catatan Project

Project ini dibuat untuk mata kuliah pengembangan aplikasi mobile.

Fokus utama project:

- Menerapkan materi Flutter dasar sampai menengah
- Menggunakan GetX untuk state management dan navigasi
- Menggunakan REST API
- Menggunakan SQLite sebagai local storage
- Menggunakan kamera
- Menggunakan GPS/location
- Menerapkan security API call sederhana
- Menjaga struktur project tetap mudah dipahami

Project ini sengaja dibuat dengan pendekatan sederhana agar sesuai dengan pembelajaran kelas dan mudah dipresentasikan saat UAS.
