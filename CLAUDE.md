# CLAUDE.md — Catatan untuk AI Coding Agent

Project Flutter ini untuk tugas kuliah (universitas, level pemula–menengah). Baca `AGENTS.md` dulu — itu aturan utama. File ini berisi pengingat tambahan khusus agent.

## Aturan utama (dari AGENTS.md)
- MVC sederhana: `model/`, `controller/`, `screen/`, `dataaccess/`, `provider`. Jangan buat layer `repository/`/`usecase/`/`services/`/BLoC.
- State pakai `GetX` `Rx` + `Obx`. Field model public mutable (kecuali `id`). `fromMap`/`toMap` manual — tanpa codegen.
- Jangan overengineering: jangan pakai freezed, stream/rxDart, get_it, unit test kecuali diminta.
- Utamakan `StatelessWidget`. Pakai `Get.to()`/`Get.back()`, `Get.snackbar()`.
- Penamaan file `snake_case.dart`; import pakai `package:`.

## Rahasia / .env (kebijakan keamanan — disetujui user)
- `flutter_dotenv` diperbolehkan (pengecualian aturan "jangan tambah lib tanpa tanya" — disetujui untuk keamanan).
- **Jangan** hard-code API key di `lib/`. Simpan di `.env` (gitignored).
- `.env.example` adalah template yang di-commit; `.env` tidak di-commit.
- Baca key via `dotenv.env["KEY"]`. Lihat `lib/utils/constants.dart` (getter `apiKey`) dan `lib/main.dart` (load sebelum `runApp`).
- `geolocator` dipakai untuk lokasi; kalau kelak ada Google Maps key, simpan di `.env` juga, bukan inline di `AndroidManifest`/`Info.plist`.

## Pengetatan panggilan API (wajib — lihat AGENTS.md "Security API Call")
- Semua HTTP ada di controller (mis. `lib/controller/plant_controller.dart`).
- `apiKey` tetap di `constants.dart`; jangan dipindah ke controller.
- Jangan log/print/tampilkan API key.
- Guard: `if (apiKey.isEmpty) { Get.snackbar(...); return; }` sebelum tiap request.
- Tiap call dibungkus try-catch; cek `response.statusCode == 200` sebelum `jsonDecode`.
- Tambah timeout via `Future.timeout(Duration(seconds: 15))` (tanpa package baru).
- Saat gagal (timeout / non-200 / exception): `Get.snackbar(...)`.
- Tetap sederhana. JANGAN tambah package HTTP/retry baru.

## API
- Perenual API (`baseUrl` di `constants.dart`). Key dikirim sebagai param `?key=` query.
- Lihat `docs/04_api_database.md` untuk endpoint.

## Verifikasi
- Jalankan `flutter analyze` sebelum bilang selesai. Pertahankan tetap hijau.
- Jangan jalankan `flutter pub get` / build kecuali diminta atau perlu verifikasi; kalau jalanin, laporkan output aslinya.
