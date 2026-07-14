# PlantCare App

PlantCare App adalah aplikasi mobile berbasis Flutter untuk membantu pengguna mencari informasi tanaman, melihat detail perawatan tanaman, dan menyimpan tanaman ke koleksi pribadi menggunakan SQLite.

## Fitur

- Login sederhana
- Daftar tanaman dari public API
- Search tanaman
- Detail tanaman
- Simpan tanaman ke My Garden
- CRUD tanaman pribadi
- Ambil foto tanaman menggunakan kamera
- Profile sederhana
- Logout

## Teknologi

- Flutter
- Dart
- GetX
- REST API
- SQLite
- Image Picker
- SharedPreferences

## Package

- get
- http
- sqflite
- path
- path_provider
- image_picker
- shared_preferences
- intl
- cached_network_image

## Struktur Folder

```text
lib/
  main.dart
  model/
  controller/
  screen/
  dataaccess/
  provider/
  utils/
```

## Public API

Aplikasi menggunakan Perenual Plant API.

Base URL:

```text
https://perenual.com/api
```

Endpoint utama:

```text
/species-list
/species/details/{id}
```

API key disimpan di `lib/utils/constants.dart` dan tidak ditampilkan di README atau UI aplikasi.

## Login Default

```text
Username: admin
Password: admin123
```

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

## Manual Testing

| No | Test Case | Status |
|---|---|---|
| 1 | Splash screen muncul | [ ] |
| 2 | Login berhasil dengan admin/admin123 | [ ] |
| 3 | Login gagal dengan data salah | [ ] |
| 4 | Home menampilkan data tanaman | [ ] |
| 5 | Search tanaman berjalan | [ ] |
| 6 | Detail tanaman tampil | [ ] |
| 7 | Save to My Garden berhasil | [ ] |
| 8 | My Garden menampilkan data SQLite | [ ] |
| 9 | Add Plant berhasil | [ ] |
| 10 | Edit Plant berhasil | [ ] |
| 11 | Delete Plant berhasil | [ ] |
| 12 | Kamera berhasil mengambil foto | [ ] |
| 13 | Foto tampil di My Garden | [ ] |
| 14 | Profile menampilkan jumlah tanaman | [ ] |
| 15 | Logout berhasil | [ ] |
| 16 | Back button setelah logout tidak kembali ke Home | [ ] |

## Catatan

Project ini dibuat untuk mata kuliah pengembangan aplikasi mobile. Arsitektur dibuat sederhana menggunakan MVC sederhana dan GetX.
