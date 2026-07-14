# Project Plan - PlantCare App

## 1. Ringkasan

Dokumen ini berisi rencana pengerjaan project **PlantCare App** berdasarkan silabus mata kuliah pengembangan aplikasi mobile Flutter.

Project ini dibuat secara bertahap mengikuti materi perkuliahan, mulai dari pengenalan Android, Flutter widget, layout, navigation, ListView, form, SQLite, REST API, CRUD, kamera, sampai security REST API.

Rencana ini dibuat agar proses pengerjaan project lebih terarah dan tidak melebar ke fitur yang terlalu kompleks.

---

## 2. Informasi Project

| Item                | Keterangan                  |
| ------------------- | --------------------------- |
| Nama Project        | PlantCare App               |
| Nama Folder Flutter | `plantcare_app`             |
| Platform            | Android                     |
| Framework           | Flutter                     |
| Bahasa              | Dart                        |
| State Management    | GetX                        |
| Database Lokal      | SQLite                      |
| Public API          | Perenual Plant API          |
| Arsitektur          | MVC sederhana               |
| Target Project      | Project mata kuliah Flutter |

---

## 3. Tujuan Project

Tujuan project ini adalah membuat aplikasi mobile sederhana yang dapat:

1. Menampilkan data tanaman dari public API.
2. Menampilkan detail tanaman.
3. Menyimpan tanaman ke SQLite.
4. Mengelola tanaman pribadi dengan CRUD.
5. Mengambil foto tanaman menggunakan kamera.
6. Menggunakan GetX untuk navigasi dan state management.
7. Menggunakan form dengan validasi.
8. Menerapkan security REST API sederhana.

---

## 4. Scope Project

## 4.1 Scope Utama

Fitur yang akan dibuat:

1. Splash screen.
2. Login sederhana.
3. Home screen daftar tanaman.
4. Search tanaman.
5. Detail tanaman.
6. My Garden.
7. Tambah tanaman pribadi.
8. Edit tanaman pribadi.
9. Hapus tanaman pribadi.
10. Kamera untuk foto tanaman.
11. Logout.
12. Error handling sederhana.

---

## 4.2 Di Luar Scope

Fitur berikut tidak dikerjakan pada tahap utama:

1. Register user.
2. Login backend asli.
3. Firebase.
4. Push notification.
5. AI plant detection.
6. Upload foto ke server.
7. Maps.
8. Payment.
9. Role admin dan user.
10. Clean Architecture.
11. Repository pattern.
12. Unit testing.

---

## 5. Struktur Folder Project

Struktur folder yang digunakan:

```text id="afk76r"
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

  dataaccess/
    my_plant_dataaccess.dart

  provider/
    database_provider.dart

  utils/
    constants.dart
```

Catatan:

1. Tidak menggunakan folder `repository/`.
2. Tidak menggunakan folder `usecase/`.
3. Tidak menggunakan arsitektur Clean Architecture.
4. Logic utama berada di controller.
5. CRUD SQLite berada di dataaccess.
6. Koneksi database berada di provider.

---

## 6. Package yang Digunakan

Package yang digunakan:

```bash id="i2rsnf"
flutter pub add get http sqflite path image_picker shared_preferences intl cached_network_image
```

Kegunaan package:

| Package                | Fungsi                          |
| ---------------------- | ------------------------------- |
| `get`                  | Navigation dan state management |
| `http`                 | Mengambil data dari REST API    |
| `sqflite`              | Database SQLite                 |
| `path`                 | Path database SQLite            |
| `image_picker`         | Mengambil foto tanaman          |
| `shared_preferences`   | Menyimpan status login          |
| `intl`                 | Format tanggal                  |
| `cached_network_image` | Menampilkan gambar dari URL     |

---

## 7. Rencana Berdasarkan Sesi Perkuliahan

## Sesi 1 - Pengenalan Android dan Kontrak Perkuliahan

### Materi

Pengenalan Android, kontrak perkuliahan, dan gambaran project mobile.

### Implementasi Project

1. Menentukan ide project PlantCare App.
2. Menentukan masalah yang ingin diselesaikan.
3. Menentukan fitur utama aplikasi.
4. Membuat dokumen awal:
   - PRD
   - MVP
   - Features
   - API & Database
   - Project Plan

### Output

1. Ide project sudah jelas.
2. Scope project sudah ditentukan.
3. Dokumen project tersedia.

---

## Sesi 2 - Pengenalan Flutter dan Widget

### Materi

Pengenalan Flutter, struktur project Flutter, dan widget dasar.

### Implementasi Project

1. Inisialisasi project Flutter dengan nama:

```text id="xt31d7"
plantcare_app
```

2. Menambahkan package yang dibutuhkan.
3. Membuat struktur folder.
4. Membuat file `main.dart`.
5. Membuat screen awal sederhana.
6. Membuat widget dasar seperti:
   - Text
   - Image
   - Icon
   - ElevatedButton
   - TextField

### Output

1. Project Flutter dapat dijalankan.
2. Struktur folder awal sudah tersedia.
3. Tampilan awal sederhana tersedia.

---

## Sesi 3 - Layout Widget

### Materi

Layout dasar Flutter menggunakan widget seperti Column, Row, Container, Padding, dan Card.

### Implementasi Project

1. Membuat UI Login Screen.
2. Membuat UI Home Screen awal.
3. Membuat Plant Card sederhana.
4. Mengatur layout dengan:
   - Column
   - Row
   - Container
   - Padding
   - Card
   - SizedBox

### Output

1. Login Screen memiliki layout rapi.
2. Home Screen memiliki layout awal.
3. Plant Card dapat ditampilkan secara statis.

---

## Sesi 4 - Layout Desain Lanjutan

### Materi

Layout lebih lanjut dan perapian tampilan aplikasi.

### Implementasi Project

1. Membuat Detail Screen.
2. Membuat My Garden Screen.
3. Membuat Plant Form Screen.
4. Menambahkan tampilan:
   - Empty state
   - Loading state
   - Image placeholder
   - Form layout

### Output

1. Detail Screen tersedia.
2. My Garden Screen tersedia.
3. Form tambah/edit tanaman tersedia secara tampilan.

---

## Sesi 5 - Flutter Navigation

### Materi

Navigasi antar halaman di Flutter.

### Implementasi Project

1. Menggunakan GetX untuk navigasi.
2. Mengubah `MaterialApp` menjadi `GetMaterialApp`.
3. Implementasi navigasi:
   - Splash ke Login
   - Splash ke Home
   - Login ke Home
   - Home ke Detail
   - Home ke My Garden
   - My Garden ke Form
   - Form kembali ke My Garden

### Output

1. Navigasi antar halaman berjalan.
2. Aplikasi sudah memiliki alur halaman utama.

---

## Sesi 6 - ListView Flutter

### Materi

Menampilkan data menggunakan ListView.

### Implementasi Project

1. Membuat ListView tanaman di Home Screen.
2. Membuat ListView My Garden.
3. Membuat Plant Card reusable sederhana.
4. Menampilkan data dummy terlebih dahulu jika API belum siap.

### Output

1. Home Screen dapat menampilkan daftar tanaman.
2. My Garden Screen dapat menampilkan daftar tanaman.
3. Plant Card digunakan untuk list data.

---

## Sesi 7 - Flutter Form

### Materi

Form input, TextFormField, validator, dan GlobalKey FormState.

### Implementasi Project

1. Membuat form login.
2. Membuat form tambah tanaman.
3. Membuat form edit tanaman.
4. Menambahkan validasi:
   - Nama tanaman wajib diisi.
   - Watering wajib diisi.
   - Sunlight wajib diisi.
   - Username wajib diisi.
   - Password wajib diisi.

### Output

1. Login form memiliki validasi.
2. Form tambah tanaman memiliki validasi.
3. Form edit tanaman memiliki validasi.

---

## Sesi 8 - UTS

### Target UTS

Pada UTS, aplikasi minimal sudah memiliki:

1. Struktur project.
2. Login Screen.
3. Home Screen.
4. Detail Screen.
5. My Garden Screen.
6. Navigation.
7. ListView.
8. Form tambah/edit.
9. UI berjalan dengan data dummy atau data awal.

### Output

Aplikasi dapat didemonstrasikan secara UI dan alur navigation.

---

## Sesi 9 - Flutter SQLite

### Materi

Pengenalan SQLite di Flutter.

### Implementasi Project

1. Membuat `database_provider.dart`.
2. Membuat database `plantcare.db`.
3. Membuat table `my_garden`.
4. Membuka koneksi database.
5. Menyiapkan struktur `MyPlant`.

### Output

1. Database SQLite berhasil dibuat.
2. Table `my_garden` tersedia.
3. Project siap melakukan CRUD lokal.

---

## Sesi 10 - Flutter SQLite CRUD

### Materi

Insert, read, update, dan delete data menggunakan SQLite.

### Implementasi Project

1. Membuat `my_plant_dataaccess.dart`.
2. Implementasi fungsi:
   - Insert plant
   - Get all plants
   - Get plant by id
   - Update plant
   - Delete plant

3. Menghubungkan CRUD SQLite ke GardenController.
4. Menampilkan data SQLite di My Garden Screen.

### Output

1. Data tanaman dapat disimpan.
2. Data tanaman dapat ditampilkan.
3. Data tanaman dapat diedit.
4. Data tanaman dapat dihapus.

---

## Sesi 11 - Flutter REST API

### Materi

Mengambil data dari REST API.

### Implementasi Project

1. Membuat konfigurasi API di `constants.dart`.
2. Membuat model `Plant`.
3. Membuat fungsi API di `plant_controller.dart`.
4. Mengambil data tanaman dari API.
5. Menampilkan data API di Home Screen.
6. Membuat loading state sederhana.
7. Membuat error handling sederhana.

### Output

1. Aplikasi dapat mengambil data tanaman dari API.
2. Home Screen menampilkan data dari API.
3. Search tanaman mulai bisa digunakan.

---

## Sesi 12 - Flutter CRUD

### Materi

CRUD aplikasi secara lengkap.

### Implementasi Project

1. Menghubungkan data API ke SQLite.
2. Menambahkan fitur simpan tanaman dari Detail Screen ke My Garden.
3. Menyempurnakan tambah tanaman manual.
4. Menyempurnakan edit tanaman.
5. Menyempurnakan hapus tanaman.
6. Menambahkan snackbar sukses dan gagal.

### Output

1. Data API dapat disimpan ke SQLite.
2. CRUD tanaman pribadi berjalan lengkap.
3. My Garden berjalan sebagai fitur utama lokal.

---

## Sesi 13 - Akses Camera

### Materi

Mengakses kamera dari aplikasi Flutter.

### Implementasi Project

1. Menambahkan fitur ambil foto di Plant Form Screen.
2. Menggunakan package `image_picker`.
3. Menampilkan preview foto.
4. Menyimpan path foto ke SQLite.
5. Menampilkan foto lokal di My Garden.

### Output

1. Pengguna dapat mengambil foto tanaman.
2. Foto tampil di form.
3. Foto tersimpan sebagai path lokal.
4. Foto dapat ditampilkan kembali di My Garden.

---

## Sesi 14 - Security REST API

### Materi

Keamanan saat menggunakan REST API.

### Implementasi Project

1. Menyimpan base URL dan API key di `constants.dart`.
2. Tidak menulis API key langsung di screen.
3. Tidak menampilkan API key di UI.
4. Membuat try-catch pada request API.
5. Menyimpan status login dengan SharedPreferences.
6. Menambahkan logout.
7. Menjelaskan batasan security pada project kuliah.

### Output

1. API key dikelola di satu tempat.
2. Request API lebih rapi.
3. Login/logout sederhana berjalan.
4. Aplikasi memiliki penjelasan security REST API sederhana.

---

## 8. Timeline Pengerjaan

| Tahap    | Fokus                   | Output                          |
| -------- | ----------------------- | ------------------------------- |
| Tahap 1  | Dokumentasi dan setup   | PRD, MVP, struktur project      |
| Tahap 2  | UI dasar                | Login, Home, Detail, My Garden  |
| Tahap 3  | Navigation dan ListView | GetX navigation, list tanaman   |
| Tahap 4  | Form                    | Login form, Plant form          |
| Tahap 5  | SQLite                  | Database dan CRUD               |
| Tahap 6  | REST API                | Data tanaman dari API           |
| Tahap 7  | Integrasi               | API ke SQLite, My Garden        |
| Tahap 8  | Kamera                  | Foto tanaman                    |
| Tahap 9  | Security dan finalisasi | API key, logout, error handling |
| Tahap 10 | Presentasi              | Demo dan laporan akhir          |

---

## 9. Prioritas Pengerjaan

## 9.1 Prioritas Wajib

Fitur yang harus selesai:

1. Login.
2. Home list tanaman.
3. Detail tanaman.
4. My Garden.
5. SQLite CRUD.
6. REST API.
7. Form tambah/edit.
8. Kamera.
9. Logout.

---

## 9.2 Prioritas Tambahan

Fitur yang dikerjakan jika waktu cukup:

1. Search tanaman.
2. Pull to refresh.
3. Profile sederhana.
4. Empty state lebih rapi.
5. Placeholder image.
6. Filter tanaman.

---

## 9.3 Tidak Dikerjakan

Fitur yang tidak dikerjakan:

1. Firebase.
2. Push notification.
3. AI detection.
4. Upload image.
5. Multi-role user.
6. Payment.
7. Maps.
8. Clean Architecture.

---

## 10. Target UTS

Target saat UTS:

1. Project Flutter sudah berjalan.
2. Struktur folder sudah sesuai.
3. Login Screen sudah ada.
4. Home Screen sudah ada.
5. Detail Screen sudah ada.
6. My Garden Screen sudah ada.
7. Navigation menggunakan GetX sudah berjalan.
8. ListView sudah ada.
9. Form tambah/edit sudah ada.
10. Data boleh masih dummy atau sebagian statis.

---

## 11. Target Final Project

Target final project:

1. Login dan logout berjalan.
2. Home menampilkan data tanaman dari API.
3. Search tanaman berjalan.
4. Detail tanaman berjalan.
5. Simpan tanaman ke My Garden berjalan.
6. My Garden mengambil data dari SQLite.
7. Tambah tanaman pribadi berjalan.
8. Edit tanaman berjalan.
9. Hapus tanaman berjalan.
10. Kamera berjalan.
11. Data foto tersimpan sebagai path lokal.
12. API key dikelola di satu file.
13. Error handling sederhana tersedia.
14. Project dapat dipresentasikan dengan baik.

---

## 12. Testing Manual

Testing dilakukan secara manual.

Checklist testing:

| No  | Test Case                           | Status |
| --- | ----------------------------------- | ------ |
| 1   | Aplikasi dapat dibuka               | Belum  |
| 2   | Splash screen tampil                | Belum  |
| 3   | Login dengan data benar berhasil    | Belum  |
| 4   | Login dengan data salah gagal       | Belum  |
| 5   | Home menampilkan data tanaman       | Belum  |
| 6   | Search tanaman berjalan             | Belum  |
| 7   | Detail tanaman tampil               | Belum  |
| 8   | Tanaman dapat disimpan ke My Garden | Belum  |
| 9   | My Garden menampilkan data SQLite   | Belum  |
| 10  | Tambah tanaman pribadi berhasil     | Belum  |
| 11  | Edit tanaman berhasil               | Belum  |
| 12  | Hapus tanaman berhasil              | Belum  |
| 13  | Kamera dapat mengambil foto         | Belum  |
| 14  | Foto tampil di form                 | Belum  |
| 15  | Logout berhasil                     | Belum  |
| 16  | Aplikasi tidak crash saat API error | Belum  |

---

## 13. Risiko Project

| Risiko                   | Dampak                    | Solusi                              |
| ------------------------ | ------------------------- | ----------------------------------- |
| API limit habis          | Data tidak tampil         | Gunakan data dummy sementara        |
| API key salah            | Request gagal             | Cek ulang API key di constants      |
| Internet mati            | Data API tidak tampil     | Tampilkan snackbar error            |
| Kamera tidak muncul      | Foto tidak bisa diambil   | Cek permission dan emulator/device  |
| SQLite error             | Data tidak tersimpan      | Cek query dan struktur table        |
| Project terlalu kompleks | Sulit selesai             | Tetap ikuti MVP                     |
| UI belum rapi            | Presentasi kurang menarik | Rapikan setelah fitur utama selesai |

---

## 14. Strategi Presentasi

Saat presentasi, alur demo yang disarankan:

1. Jelaskan tujuan aplikasi.
2. Tunjukkan login.
3. Tunjukkan Home Screen.
4. Cari tanaman menggunakan search.
5. Buka detail tanaman.
6. Simpan tanaman ke My Garden.
7. Buka My Garden.
8. Tambah tanaman pribadi.
9. Ambil foto tanaman.
10. Edit tanaman.
11. Hapus tanaman.
12. Logout.
13. Jelaskan penggunaan API, SQLite, GetX, dan kamera.

---

## 15. Kesimpulan

Project Plan ini menjadi panduan pengerjaan PlantCare App dari awal sampai final. Rencana dibuat berdasarkan silabus perkuliahan agar setiap materi dapat diterapkan langsung dalam project.

Dengan mengikuti rencana ini, PlantCare App dapat selesai secara bertahap, tetap sederhana, dan sesuai dengan kemampuan beginner-to-intermediate Flutter.
