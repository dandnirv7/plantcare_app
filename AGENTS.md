# AGENTS.md — Flutter Project Guidelines

## Context

This workspace is a collection of Flutter projects created for university coursework (with Pak Nur). These are beginner-to-intermediate level projects. **Keep code simple, readable, and within what has been taught in class.**

## Project Documentation Order

Before coding, read documentation in this order:

1. `docs/01_prd.md`
2. `docs/02_mvp.md`
3. `docs/03_features.md`
4. `docs/04_api_database.md`
5. `docs/05_project_plan.md`
6. `docs/06_user_flow.md`
7. `docs/07_screen_list.md`
8. `docs/08_implementation_guide.md`

Use UI references from:

- `docs/ui-reference/01_login_home_plant_detail.png`
- `docs/ui-reference/02_my_garden_add_plant_edit_plant.png`
- `docs/ui-reference/03_splash_profile_empty_error_states.png`

Follow `AGENTS.md` strictly. Do not overengineer.

## Tech Stack (Yang Diizinkan)

| Kategori             | Library                                                                                             |
| -------------------- | --------------------------------------------------------------------------------------------------- |
| **State Management** | `get: ^4.x` (GetX) — `GetMaterialApp`, `Obx`, `GetxController`, `Get.put`, `Get.to`, `Get.snackbar` |
| **Database**         | `sqflite`, `path_provider`, `path`                                                                  |
| **HTTP**             | `http` atau `GetConnect()` bawaan GetX                                                              |
| **UI pendukung**     | `google_maps_flutter`, `image_picker`, `cached_network_image`, `shared_preferences`, `intl`         |
| **Lainnya**           | `cupertino_icons`, `flutter_lints`, `flutter_dotenv`                                              |

**Technology stack choices must be explicitly listed here — do not introduce libraries not listed above without asking.**

## Architecture (MVC Sederhana)

```
lib/
  main.dart
  model/          → Class data dengan fromMap/toMap
  controller/     → GetxController untuk business logic & state
  screen/         → Halaman UI (StatelessWidget prefered)
  dataaccess/     → CRUD SQLite (jika pakai database)
  provider/       → DatabaseProvider singleton
```

- **Tidak boleh** menambah layer seperti `repository/`, `usecase/`, `services/`, `bloc/`
- Semua state pakai `Rx` di controller, bukan `Stream` atau `ValueNotifier`

## Environment & Secrets (.env)

Secrets (API key, dll) **wajib** dipisah dari source code demi keamanan.

- Pakai package `flutter_dotenv`. Load di `main()` via `await dotenv.load(fileName: ".env")` (butuh `WidgetsFlutterBinding.ensureInitialized()` + daftarin `.env` di `pubspec.yaml` → `assets`).
- Real key simpan di `.env` (sudah gitignored). Jangan hard-code secret di `lib/`.
- Commit hanya `.env.example` sebagai template (`PERENUAL_API_KEY=ISI_API_KEY_KAMU`).
- Baca secret lewat `dotenv.env["PERENUAL_API_KEY"]` — lihat `lib/utils/constants.dart` (getter `apiKey`).
- Di Android, `.env` dibaca dari asset, bukan file system.

## Security API Call (wajib di controller)

Setiap pemanggilan HTTP ke API wajib mengikuti aturan berikut:

- **API key tetap di `lib/utils/constants.dart`** (getter `apiKey`), jangan dipindah ke controller.
- **Jangan print/log/display API key** di mana pun.
- **Cek `apiKey` kosong** sebelum request (`if (apiKey.isEmpty) -> snackbar, return`).
- **Gunakan try-catch** di tiap method API call.
- **Cek `response.statusCode == 200`** sebelum parse JSON.
- **Beri timeout** pada request (`Future.timeout(Duration(...))` — bawaan Dart, tanpa package baru).
- **Tampilkan `Get.snackbar`** saat request gagal (timeout / non-200 / exception).
- Jaga tetap sederhana, ikuti pola `PlantController`. Jangan tambah package baru.

## Model Conventions

```dart
class Product {
  int id;           // public, mutable — NO private fields
  String title;     // NO final (kecuali id)
  dynamic price;    // dynamic untuk number (bukan int/double spesifik)

  Product({required this.id, required this.title, this.price});

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    id: map["id"],
    title: map["title"],
    price: map["price"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "price": price,
  };
}
```

- **Jangan gunakan** freezed, json_serializable, copyWith, atau immutable pattern
- Field public & mutable (kecuali id)

## Coding Style

| Aspek               | Aturan                                                   |
| ------------------- | -------------------------------------------------------- |
| **File naming**     | `snake_case.dart`                                        |
| **Class naming**    | `PascalCase`                                             |
| **Method/variable** | `camelCase`                                              |
| **Private members** | Prefix `_`                                               |
| **Const**           | Gunakan `const` jika memungkinkan                        |
| **Widget type**     | `StatelessWidget` > `StatefulWidget`                     |
| **Form**            | `GlobalKey<FormState>`, `TextFormField` dengan validator |
| **Navigasi**        | `Get.to()` / `Get.back()`                                |
| **Notifikasi**      | `Get.snackbar()` / `Get.dialog()`                        |
| **Imports**         | Pakai `package:` (bukan relative path)                   |

## What NOT To Do (Larangan Overengineering)

| ❌ Jangan gunakan                          | ✅ Cukup pakai                          |
| ------------------------------------------ | --------------------------------------- |
| BLoC / Riverpod / Provider / Redux         | GetX (`Obx` + `GetxController`)         |
| freezed / json_serializable / build_runner | `fromMap` / `toMap` manual              |
| Clean Architecture / DDD / Repository      | MVC sederhana (model-controller-screen) |
| Unit test / widget test / integration test | —                                       |
| Advanced DI (get_it, injectable)           | `Get.put()` / `Get.lazyPut()`           |
| Streams / async\* / rxDart                 | `Rx` variabel + `Obx`                   |
| State terpisah (loading/error/success)     | `isLoading.obs` + spinner sederhana     |
| Animasi kompleks / Hero / CustomPainter    | Default Flutter widgets                 |
| Computed / selectors / memoization         | `Obx(() => ...)` langsung di UI         |
| Advanced error handling / retry logic      | Minimal try-catch                       |
| Code generation apapun                     | —                                       |

## Contoh File Referensi

Lihat file berikut sebagai referensi cara penulisan yang benar:

- **Model:** `flutter_restapi/lib/model/product.dart`
- **Controller:** `flutter_restapi/lib/controller/productcontroller.dart`
- **DataAccess:** `paknur10_sqlite_crud/flutter-sqlite-crud/lib/dataaccess/contact_dataaccess.dart`
- **Provider DB:** `paknur10_sqlite_crud/flutter-sqlite-crud/lib/provider/database_provider.dart`
- **Screen:** `flutter_restapi/lib/screen/home_screen.dart`
