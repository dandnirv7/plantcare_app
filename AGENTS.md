# AGENTS.md — Flutter Project Guidelines

## Context

This workspace is a collection of Flutter projects created for university coursework (with Pak Nur). These are beginner-to-intermediate level projects. **Keep code simple, readable, and within what has been taught in class.**

## Tech Stack (Yang Diizinkan)

| Kategori | Library |
|----------|---------|
| **State Management** | `get: ^4.x` (GetX) — `GetMaterialApp`, `Obx`, `GetxController`, `Get.put`, `Get.to`, `Get.snackbar` |
| **Database** | `sqflite`, `path_provider`, `path` |
| **HTTP** | `http` atau `GetConnect()` bawaan GetX |
| **UI pendukung** | `google_maps_flutter`, `image_picker`, `cached_network_image`, `shared_preferences`, `intl` |
| **Lainnya** | `cupertino_icons`, `flutter_lints` |

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

| Aspek | Aturan |
|-------|--------|
| **File naming** | `snake_case.dart` |
| **Class naming** | `PascalCase` |
| **Method/variable** | `camelCase` |
| **Private members** | Prefix `_` |
| **Const** | Gunakan `const` jika memungkinkan |
| **Widget type** | `StatelessWidget` > `StatefulWidget` |
| **Form** | `GlobalKey<FormState>`, `TextFormField` dengan validator |
| **Navigasi** | `Get.to()` / `Get.back()` |
| **Notifikasi** | `Get.snackbar()` / `Get.dialog()` |
| **Imports** | Pakai `package:` (bukan relative path) |

## What NOT To Do (Larangan Overengineering)

| ❌ Jangan gunakan | ✅ Cukup pakai |
|---|---|
| BLoC / Riverpod / Provider / Redux | GetX (`Obx` + `GetxController`) |
| freezed / json_serializable / build_runner | `fromMap` / `toMap` manual |
| Clean Architecture / DDD / Repository | MVC sederhana (model-controller-screen) |
| Unit test / widget test / integration test | — |
| Advanced DI (get_it, injectable) | `Get.put()` / `Get.lazyPut()` |
| Streams / async* / rxDart | `Rx` variabel + `Obx` |
| State terpisah (loading/error/success) | `isLoading.obs` + spinner sederhana |
| Animasi kompleks / Hero / CustomPainter | Default Flutter widgets |
| Computed / selectors / memoization | `Obx(() => ...)` langsung di UI |
| Advanced error handling / retry logic | Minimal try-catch |
| Code generation apapun | — |

## Contoh File Referensi

Lihat file berikut sebagai referensi cara penulisan yang benar:

- **Model:** `flutter_restapi/lib/model/product.dart`
- **Controller:** `flutter_restapi/lib/controller/productcontroller.dart`
- **DataAccess:** `paknur10_sqlite_crud/flutter-sqlite-crud/lib/dataaccess/contact_dataaccess.dart`
- **Provider DB:** `paknur10_sqlite_crud/flutter-sqlite-crud/lib/provider/database_provider.dart`
- **Screen:** `flutter_restapi/lib/screen/home_screen.dart`
