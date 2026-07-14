# Screen List - PlantCare App

## 1. Ringkasan

Dokumen ini berisi daftar screen yang dibutuhkan dalam project **PlantCare App**.

Setiap screen dijelaskan berdasarkan:

1. Nama screen.
2. Fungsi screen.
3. Komponen UI.
4. Controller yang digunakan.
5. State yang dibutuhkan.
6. Aksi user.
7. Navigasi.

Dokumen ini dibuat agar implementasi UI dan logic aplikasi lebih mudah dipahami.

Project menggunakan:

- Flutter
- GetX
- REST API
- SQLite
- SharedPreferences
- Image Picker

Struktur project mengikuti MVC sederhana:

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

---

## 2. Daftar Screen Utama

| No  | Screen              | File                       | Fungsi                            |
| --- | ------------------- | -------------------------- | --------------------------------- |
| 1   | Splash Screen       | `splash_screen.dart`       | Mengecek status login             |
| 2   | Login Screen        | `login_screen.dart`        | Form login sederhana              |
| 3   | Home Screen         | `home_screen.dart`         | Menampilkan list tanaman dari API |
| 4   | Plant Detail Screen | `detail_screen.dart`       | Menampilkan detail tanaman        |
| 5   | My Garden Screen    | `my_garden_screen.dart`    | Menampilkan tanaman dari SQLite   |
| 6   | Plant Form Screen   | `plant_form_screen.dart`   | Form tambah dan edit tanaman      |
| 7   | Profile Screen      | `profile_screen.dart`      | Profil sederhana dan logout       |
| 8   | State Components    | Komponen di screen terkait | Empty state dan error state       |

---

## 3. Splash Screen

## 3.1 File

```text
lib/screen/splash_screen.dart
```

## 3.2 Fungsi

Splash Screen adalah halaman pertama yang muncul saat aplikasi dibuka. Screen ini digunakan untuk mengecek apakah pengguna sudah login atau belum.

## 3.3 Komponen UI

| Komponen                  | Keterangan                |
| ------------------------- | ------------------------- |
| Scaffold                  | Struktur utama halaman    |
| Container                 | Background                |
| Column                    | Menyusun logo dan teks    |
| Icon                      | Leaf icon aplikasi        |
| Text                      | Nama aplikasi dan tagline |
| CircularProgressIndicator | Loading sederhana         |

## 3.4 Controller

| Controller       | Fungsi                |
| ---------------- | --------------------- |
| `AuthController` | Mengecek status login |

## 3.5 State

| State        | Keterangan                          |
| ------------ | ----------------------------------- |
| `isLoggedIn` | Status login dari SharedPreferences |

## 3.6 Aksi

Tidak ada aksi user langsung.

## 3.7 Navigasi

| Kondisi          | Navigasi     |
| ---------------- | ------------ |
| User sudah login | Home Screen  |
| User belum login | Login Screen |

## 3.8 Catatan Implementasi

1. Gunakan `Future.delayed()` singkat jika ingin splash terasa natural.
2. Gunakan `Get.offAll()` agar user tidak kembali ke splash.
3. Jangan membuat animasi kompleks.

---

## 4. Login Screen

## 4.1 File

```text
lib/screen/login_screen.dart
```

## 4.2 Fungsi

Login Screen digunakan agar pengguna dapat masuk ke aplikasi.

Login pada versi MVP bersifat sederhana dan tidak menggunakan backend.

## 4.3 Komponen UI

| Komponen              | Keterangan                     |
| --------------------- | ------------------------------ |
| Scaffold              | Struktur utama                 |
| SingleChildScrollView | Agar aman saat keyboard muncul |
| Form                  | Form login                     |
| TextFormField         | Input username dan password    |
| ElevatedButton        | Tombol login                   |
| Icon                  | Leaf icon                      |
| Text                  | App name dan tagline           |

## 4.4 Controller

| Controller       | Fungsi                     |
| ---------------- | -------------------------- |
| `AuthController` | Login, simpan status login |

## 4.5 State

| State                | Keterangan                                |
| -------------------- | ----------------------------------------- |
| `usernameController` | Text editing controller username          |
| `passwordController` | Text editing controller password          |
| `isLoading`          | Loading saat proses login jika dibutuhkan |

## 4.6 Validasi

| Field    | Validasi    |
| -------- | ----------- |
| Username | Wajib diisi |
| Password | Wajib diisi |

## 4.7 Data Login Default

```text
Username: admin
Password: admin123
```

## 4.8 Aksi User

| Aksi             | Hasil                     |
| ---------------- | ------------------------- |
| Mengisi username | Input username berubah    |
| Mengisi password | Input password berubah    |
| Klik Login       | Validasi dan proses login |

## 4.9 Navigasi

| Kondisi        | Navigasi              |
| -------------- | --------------------- |
| Login berhasil | Home Screen           |
| Login gagal    | Tetap di Login Screen |

## 4.10 Catatan Implementasi

1. Gunakan `GlobalKey<FormState>`.
2. Gunakan `TextFormField` dengan validator.
3. Gunakan `Get.snackbar()` untuk pesan error atau sukses.
4. Gunakan `Get.offAll()` setelah login berhasil.

---

## 5. Home Screen

## 5.1 File

```text
lib/screen/home_screen.dart
```

## 5.2 Fungsi

Home Screen adalah halaman utama aplikasi. Screen ini menampilkan daftar tanaman dari public API.

## 5.3 Komponen UI

| Komponen                  | Keterangan                              |
| ------------------------- | --------------------------------------- |
| Scaffold                  | Struktur utama                          |
| AppBar                    | Judul PlantCare dan aksi profile/logout |
| TextField                 | Search tanaman                          |
| ListView                  | Menampilkan daftar tanaman              |
| Card                      | Item tanaman                            |
| CachedNetworkImage        | Gambar tanaman dari URL                 |
| CircularProgressIndicator | Loading state                           |
| BottomNavigationBar       | Navigasi Home, My Garden, Profile       |
| IconButton                | Search, profile, logout                 |

## 5.4 Controller

| Controller         | Fungsi                             |
| ------------------ | ---------------------------------- |
| `PlantController`  | Mengambil data tanaman dari API    |
| `AuthController`   | Logout jika tombol logout ada      |
| `GardenController` | Opsional untuk jumlah saved plants |

## 5.5 State

| State           | Keterangan            |
| --------------- | --------------------- |
| `plants`        | List tanaman dari API |
| `isLoading`     | Loading data API      |
| `keyword`       | Keyword pencarian     |
| `selectedPlant` | Tanaman yang dipilih  |

## 5.6 Aksi User

| Aksi               | Hasil                     |
| ------------------ | ------------------------- |
| Membuka Home       | API plant list dipanggil  |
| Klik plant card    | Masuk ke Detail Screen    |
| Mengetik search    | Mengubah keyword          |
| Klik tombol search | Memanggil search API      |
| Klik My Garden     | Masuk ke My Garden Screen |
| Klik Profile       | Masuk ke Profile Screen   |

## 5.7 Navigasi

| Aksi            | Navigasi         |
| --------------- | ---------------- |
| Klik plant card | Detail Screen    |
| Klik My Garden  | My Garden Screen |
| Klik Profile    | Profile Screen   |

## 5.8 Kondisi UI

| Kondisi       | Tampilan                  |
| ------------- | ------------------------- |
| Loading       | CircularProgressIndicator |
| Data tersedia | ListView Plant Card       |
| Data kosong   | Empty State               |
| Error API     | Error State atau snackbar |

## 5.9 Catatan Implementasi

1. Gunakan `Obx()` untuk membaca `plants` dan `isLoading`.
2. Search tidak harus real-time.
3. Gunakan ListView.builder.
4. Jika gambar kosong, tampilkan placeholder.
5. Jangan membuat filter kompleks untuk MVP.

---

## 6. Plant Detail Screen

## 6.1 File

```text
lib/screen/detail_screen.dart
```

## 6.2 Fungsi

Plant Detail Screen digunakan untuk menampilkan informasi detail tanaman yang dipilih dari Home Screen.

## 6.3 Komponen UI

| Komponen                   | Keterangan                               |
| -------------------------- | ---------------------------------------- |
| Scaffold                   | Struktur utama                           |
| AppBar                     | Tombol back dan judul detail             |
| Image / CachedNetworkImage | Gambar tanaman                           |
| Text                       | Nama tanaman, scientific name, deskripsi |
| Card / Container           | Info watering dan sunlight               |
| ElevatedButton             | Save to My Garden                        |
| Icon                       | Water drop dan sun icon                  |
| CircularProgressIndicator  | Loading detail                           |

## 6.4 Controller

| Controller         | Fungsi                      |
| ------------------ | --------------------------- |
| `PlantController`  | Mengambil detail tanaman    |
| `GardenController` | Menyimpan tanaman ke SQLite |

## 6.5 State

| State           | Keterangan                             |
| --------------- | -------------------------------------- |
| `selectedPlant` | Data detail tanaman                    |
| `isLoading`     | Loading detail                         |
| `myPlants`      | Data tanaman tersimpan jika diperlukan |

## 6.6 Aksi User

| Aksi                   | Hasil                    |
| ---------------------- | ------------------------ |
| Membuka detail         | Load detail tanaman      |
| Klik Save to My Garden | Simpan tanaman ke SQLite |
| Klik Back              | Kembali ke Home          |

## 6.7 Navigasi

| Aksi          | Navigasi                              |
| ------------- | ------------------------------------- |
| Back          | Home Screen                           |
| Save berhasil | Tetap di Detail atau menuju My Garden |

## 6.8 Kondisi UI

| Kondisi         | Tampilan                  |
| --------------- | ------------------------- |
| Loading         | CircularProgressIndicator |
| Detail tersedia | Detail tanaman tampil     |
| Gambar kosong   | Placeholder image         |
| Error           | Snackbar error            |

## 6.9 Catatan Implementasi

1. Data dapat dikirim dari Home ke Detail menggunakan argument GetX.
2. Jika API detail digunakan, panggil detail berdasarkan ID.
3. Tombol Save memanggil `GardenController`.
4. Gunakan `Get.snackbar()` setelah berhasil menyimpan.

---

## 7. My Garden Screen

## 7.1 File

```text
lib/screen/my_garden_screen.dart
```

## 7.2 Fungsi

My Garden Screen digunakan untuk menampilkan data tanaman yang disimpan pengguna di SQLite.

## 7.3 Komponen UI

| Komponen             | Keterangan                        |
| -------------------- | --------------------------------- |
| Scaffold             | Struktur utama                    |
| AppBar               | Judul My Garden                   |
| ListView             | List tanaman dari SQLite          |
| Card                 | Item tanaman                      |
| Image.file           | Foto lokal                        |
| CachedNetworkImage   | Gambar dari URL API               |
| FloatingActionButton | Tambah tanaman                    |
| IconButton           | Edit dan delete                   |
| BottomNavigationBar  | Navigasi Home, My Garden, Profile |

## 7.4 Controller

| Controller         | Fungsi                        |
| ------------------ | ----------------------------- |
| `GardenController` | CRUD SQLite                   |
| `AuthController`   | Opsional untuk logout/profile |

## 7.5 State

| State       | Keterangan                     |
| ----------- | ------------------------------ |
| `myPlants`  | List tanaman dari SQLite       |
| `isLoading` | Loading data SQLite            |
| `imagePath` | Path foto lokal jika digunakan |

## 7.6 Aksi User

| Aksi              | Hasil                      |
| ----------------- | -------------------------- |
| Membuka My Garden | Data SQLite dimuat         |
| Klik Add          | Masuk ke Plant Form tambah |
| Klik Edit         | Masuk ke Plant Form edit   |
| Klik Delete       | Dialog konfirmasi hapus    |
| Klik Home         | Kembali ke Home            |
| Klik Profile      | Masuk ke Profile           |

## 7.7 Navigasi

| Aksi       | Navigasi                    |
| ---------- | --------------------------- |
| Add Plant  | Plant Form Screen mode add  |
| Edit Plant | Plant Form Screen mode edit |
| Home       | Home Screen                 |
| Profile    | Profile Screen              |

## 7.8 Kondisi UI

| Kondisi         | Tampilan                  |
| --------------- | ------------------------- |
| Loading         | CircularProgressIndicator |
| Data tersedia   | ListView My Garden        |
| Data kosong     | Empty State               |
| Delete berhasil | Snackbar dan refresh list |

## 7.9 Catatan Implementasi

1. Gunakan `Obx()` untuk list `myPlants`.
2. Panggil `getAllPlants()` saat screen dibuka.
3. Untuk gambar, prioritaskan `localImagePath`, lalu `imageUrl`.
4. Delete harus menggunakan dialog konfirmasi.

---

## 8. Plant Form Screen

## 8.1 File

```text
lib/screen/plant_form_screen.dart
```

## 8.2 Fungsi

Plant Form Screen digunakan untuk dua mode:

1. Add Plant
2. Edit Plant

Agar project sederhana, add dan edit menggunakan satu file screen yang sama.

## 8.3 Mode Screen

| Mode | Keterangan                     |
| ---- | ------------------------------ |
| Add  | Form kosong untuk tanaman baru |
| Edit | Form terisi data lama          |

## 8.4 Komponen UI

| Komponen              | Keterangan                          |
| --------------------- | ----------------------------------- |
| Scaffold              | Struktur utama                      |
| AppBar                | Judul Add Plant atau Edit Plant     |
| SingleChildScrollView | Agar form aman saat keyboard muncul |
| Form                  | Form input                          |
| TextFormField         | Input data tanaman                  |
| Image.file            | Preview foto lokal                  |
| Container             | Placeholder foto                    |
| IconButton            | Tombol kamera                       |
| ElevatedButton        | Save atau Update                    |
| OutlinedButton        | Delete opsional pada mode edit      |

## 8.5 Controller

| Controller         | Fungsi                 |
| ------------------ | ---------------------- |
| `GardenController` | Insert, update, kamera |

## 8.6 State

| State                      | Keterangan                 |
| -------------------------- | -------------------------- |
| `nameController`           | Input nama tanaman         |
| `scientificNameController` | Input nama ilmiah          |
| `wateringController`       | Input watering             |
| `sunlightController`       | Input sunlight             |
| `noteController`           | Input catatan              |
| `imagePath`                | Path foto                  |
| `isLoading`                | Loading saat simpan/update |

## 8.7 Form Field

| Field           | Wajib | Keterangan       |
| --------------- | ----- | ---------------- |
| Plant Name      | Ya    | Nama tanaman     |
| Scientific Name | Tidak | Nama ilmiah      |
| Watering        | Ya    | Kebutuhan air    |
| Sunlight        | Ya    | Kebutuhan cahaya |
| Note            | Tidak | Catatan          |
| Photo           | Tidak | Foto tanaman     |

## 8.8 Aksi User

| Aksi              | Hasil                           |
| ----------------- | ------------------------------- |
| Isi form          | Data masuk ke controller        |
| Klik kamera       | Buka kamera dengan image_picker |
| Klik Save Plant   | Insert data ke SQLite           |
| Klik Update Plant | Update data SQLite              |
| Klik Back         | Kembali ke My Garden            |

## 8.9 Navigasi

| Kondisi         | Navigasi         |
| --------------- | ---------------- |
| Save berhasil   | My Garden Screen |
| Update berhasil | My Garden Screen |
| Back            | My Garden Screen |

## 8.10 Catatan Implementasi

1. Gunakan `GlobalKey<FormState>`.
2. Gunakan validator pada field wajib.
3. Gunakan satu screen untuk add dan edit.
4. Judul AppBar berubah sesuai mode.
5. Tombol utama berubah sesuai mode.
6. Jangan membuat form terlalu panjang.

---

## 9. Profile Screen

## 9.1 File

```text
lib/screen/profile_screen.dart
```

## 9.2 Fungsi

Profile Screen digunakan untuk menampilkan informasi user sederhana dan tombol logout.

## 9.3 Komponen UI

| Komponen                        | Keterangan                             |
| ------------------------------- | -------------------------------------- |
| Scaffold                        | Struktur utama                         |
| AppBar                          | Judul Profile                          |
| Icon / CircleAvatar             | Avatar user                            |
| Text                            | Username dan subtitle                  |
| Card                            | Informasi saved plants dan app version |
| ElevatedButton / OutlinedButton | Logout                                 |
| BottomNavigationBar             | Home, My Garden, Profile               |

## 9.4 Controller

| Controller         | Fungsi                             |
| ------------------ | ---------------------------------- |
| `AuthController`   | Logout                             |
| `GardenController` | Mengambil jumlah tanaman tersimpan |

## 9.5 State

| State        | Keterangan                           |
| ------------ | ------------------------------------ |
| `isLoggedIn` | Status login                         |
| `myPlants`   | Untuk menghitung jumlah saved plants |

## 9.6 Aksi User

| Aksi           | Hasil                    |
| -------------- | ------------------------ |
| Klik Logout    | Dialog konfirmasi logout |
| Klik Home      | Home Screen              |
| Klik My Garden | My Garden Screen         |

## 9.7 Navigasi

| Aksi            | Navigasi         |
| --------------- | ---------------- |
| Home            | Home Screen      |
| My Garden       | My Garden Screen |
| Logout berhasil | Login Screen     |

## 9.8 Catatan Implementasi

1. Profile tidak perlu fitur edit.
2. Username dapat dibuat statis: `admin`.
3. App version dapat dibuat statis: `1.0.0`.
4. Logout menggunakan `Get.offAll()` ke Login Screen.

---

## 10. Empty State Component

## 10.1 Fungsi

Empty State digunakan ketika data kosong.

## 10.2 Lokasi Penggunaan

| Screen           | Kondisi                     |
| ---------------- | --------------------------- |
| Home Screen      | Search tidak menemukan data |
| My Garden Screen | Belum ada tanaman tersimpan |

## 10.3 Komponen UI

| Komponen       | Keterangan             |
| -------------- | ---------------------- |
| Icon           | Plant pot / empty icon |
| Text           | Judul empty state      |
| Text           | Pesan penjelasan       |
| ElevatedButton | Aksi seperti Add Plant |

## 10.4 Contoh Teks

```text
No plants yet
Your garden is still empty. Add your first plant to get started.
```

---

## 11. Error State Component

## 11.1 Fungsi

Error State digunakan ketika data gagal dimuat.

## 11.2 Lokasi Penggunaan

| Screen           | Kondisi             |
| ---------------- | ------------------- |
| Home Screen      | API gagal           |
| Detail Screen    | Detail gagal dimuat |
| My Garden Screen | SQLite error        |

## 11.3 Komponen UI

| Komponen       | Keterangan         |
| -------------- | ------------------ |
| Icon           | Warning / wifi off |
| Text           | Judul error        |
| Text           | Pesan error        |
| ElevatedButton | Try Again          |

## 11.4 Contoh Teks

```text
Something went wrong
Failed to load plant data. Please check your connection and try again.
```

---

## 12. Bottom Navigation

## 12.1 Menu

| Menu      | Screen           |
| --------- | ---------------- |
| Home      | Home Screen      |
| My Garden | My Garden Screen |
| Profile   | Profile Screen   |

## 12.2 Catatan

Bottom Navigation boleh digunakan untuk mempermudah navigasi. Jika ingin lebih sederhana, Profile bisa dibuka dari AppBar dan My Garden dari tombol di Home.

Untuk konsistensi UI, disarankan menggunakan bottom navigation pada:

1. Home Screen.
2. My Garden Screen.
3. Profile Screen.

---

## 13. UI Reference Images

Referensi desain UI berada di folder:

```text
docs/ui-reference/
```

Daftar file:

```text
01_login_home_plant_detail.png
02_my_garden_add_plant_edit_plant.png
03_splash_profile_empty_error_states.png
```

Isi file:

| File                                       | Isi                                       |
| ------------------------------------------ | ----------------------------------------- |
| `01_login_home_plant_detail.png`           | Login, Home, Plant Detail                 |
| `02_my_garden_add_plant_edit_plant.png`    | My Garden, Add Plant, Edit Plant          |
| `03_splash_profile_empty_error_states.png` | Splash, Profile, Empty State, Error State |

---

## 14. Ringkasan Controller per Screen

| Screen              | Controller                            |
| ------------------- | ------------------------------------- |
| Splash Screen       | `AuthController`                      |
| Login Screen        | `AuthController`                      |
| Home Screen         | `PlantController`, `AuthController`   |
| Plant Detail Screen | `PlantController`, `GardenController` |
| My Garden Screen    | `GardenController`                    |
| Plant Form Screen   | `GardenController`                    |
| Profile Screen      | `AuthController`, `GardenController`  |

---

## 15. Ringkasan Navigation

```text
Splash Screen
  ├── Login Screen
  └── Home Screen

Login Screen
  └── Home Screen

Home Screen
  ├── Plant Detail Screen
  ├── My Garden Screen
  └── Profile Screen

Plant Detail Screen
  └── My Garden Screen atau Home Screen

My Garden Screen
  ├── Plant Form Screen mode add
  ├── Plant Form Screen mode edit
  ├── Home Screen
  └── Profile Screen

Profile Screen
  ├── Home Screen
  ├── My Garden Screen
  └── Login Screen setelah logout
```

---

## 16. Kesimpulan

Screen List ini menjadi panduan implementasi tampilan PlantCare App. Setiap screen dibuat sederhana, sesuai dengan materi perkuliahan, dan dapat diimplementasikan menggunakan Flutter widget standar serta GetX.

Dengan dokumen ini, proses generate kode atau pengembangan manual akan lebih terarah karena setiap screen sudah memiliki fungsi, controller, state, dan alur navigasi yang jelas.
