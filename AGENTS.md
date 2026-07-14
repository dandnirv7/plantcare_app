# AGENTS.md — Panduan Proyek Flutter

## Konteks

PlantCare App adalah proyek Flutter untuk tugas kuliah bersama Pak Nur. Kode harus sederhana, mudah dibaca, dan sesuai tingkat pemula hingga menengah. Jangan melakukan overengineering.

## Urutan Dokumentasi

Baca dokumen berikut sebelum melakukan coding:

1. `docs/01_prd.md`
2. `docs/02_mvp.md`
3. `docs/03_features.md`
4. `docs/04_api_database.md`
5. `docs/05_project_plan.md`
6. `docs/06_user_flow.md`
7. `docs/07_screen_list.md`
8. `docs/08_implementation_guide.md`

Gunakan referensi UI berikut:

- `docs/ui_reference/01_auth_home_detail.png`
- `docs/ui_reference/02_garden_form_crud.png`
- `docs/ui_reference/03_splash_profile_states.png`

Dokumentasi Markdown ditulis dalam bahasa Indonesia. Pesan error pada aplikasi ditulis dalam bahasa Inggris agar konsisten.

## Tech Stack yang Diizinkan

| Kategori | Package / alat |
| --- | --- |
| State management | `get: ^4.x` — `GetMaterialApp`, `Obx`, `GetxController`, `Get.put`, `Get.to`, `Get.snackbar` |
| HTTP | `http` |
| Database lokal | `sqflite`, `path`, `path_provider` |
| Perangkat dan UI | `image_picker`, `shared_preferences`, `intl`, `cached_network_image`, `geolocator`, `flutter_map`, `latlong2`, `permission_handler`, `video_player` |
| Environment dan dasar | `flutter_dotenv`, `cupertino_icons`, `flutter_lints` |

Jangan menambah package di luar daftar tanpa persetujuan. GPS memakai `geolocator`; Google Maps tidak diperlukan.

`flutter_map` dan `latlong2` hanya digunakan untuk preview OpenStreetMap sederhana. Tidak perlu API key Google Maps, map picker, routing, atau pencarian alamat.

`permission_handler` hanya digunakan untuk memeriksa izin kamera sebelum mengambil foto atau merekam video. `video_player` hanya digunakan untuk preview video lokal sederhana di form atau My Garden. Jangan gunakan keduanya untuk arsitektur kompleks atau fitur lanjutan.

## Arsitektur: MVC Sederhana

```text
lib/
  main.dart
  model/       kelas data dengan fromMap/toMap manual
  controller/  GetxController untuk state dan logika bisnis
  screen/      halaman UI; utamakan StatelessWidget
  dataaccess/  query CRUD SQLite
  provider/    DatabaseProvider singleton
  utils/       constants dan konfigurasi API
```

- Jangan membuat `repository/`, `usecase/`, `services/`, BLoC, Riverpod, Provider, atau Clean Architecture.
- Gunakan state Rx di controller, bukan `Stream` atau `ValueNotifier`.
- Gunakan `Get.to()`, `Get.back()`, `Get.offAll()`, `Get.snackbar()`, dan `Get.dialog()` untuk navigasi/notifikasi.

## Autentikasi dan Sesi

- Register dan login menggunakan tabel SQLite `users` melalui `UserDataAccess`.
- Sesi disimpan dengan SharedPreferences setelah login berhasil.
- Splash mengecek sesi; Profile menampilkan username aktif dari `AuthController`/SharedPreferences.
- Password disimpan plain text hanya untuk demo pembelajaran dan tidak aman untuk aplikasi produksi.

## Environment dan Keamanan API

- Muat `.env` di `main()` dengan `WidgetsFlutterBinding.ensureInitialized()` dan `await dotenv.load(fileName: ".env")`.
- Daftarkan `.env` sebagai asset Flutter pada `pubspec.yaml`.
- Simpan key Perenual asli hanya di `.env` yang diabaikan Git; commit `.env.example` dengan `PERENUAL_API_KEY=ISI_API_KEY_KAMU`.
- Baca key hanya melalui getter `apiKey` di `lib/utils/constants.dart`; jangan hard-code di screen/controller.
- Setiap pemanggilan PlantController harus mengecek key kosong, memakai `try-catch`, mengecek `response.statusCode == 200`, memakai timeout, dan menampilkan `Get.snackbar()` saat gagal.
- Jangan pernah print, log, atau menampilkan API key.

## Konvensi Model dan Kode

- Model memakai field public mutable serta `fromMap()`/`toMap()` manual; jangan gunakan freezed, json_serializable, `copyWith`, atau code generation.
- Gunakan `snake_case.dart`, class PascalCase, member camelCase, package import, dan `const` jika memungkinkan.
- Form memakai `GlobalKey<FormState>`, `TextFormField`, dan validator.

## Jaga Ruang Lingkup Tetap Sederhana

Jangan menambahkan Firebase, upload server, AI detection, Google Maps, dependency injection lanjutan, animasi kompleks, unit/widget/integration test, atau layer arsitektur lain. Path gambar/video lokal dan koordinat disimpan di SQLite.
