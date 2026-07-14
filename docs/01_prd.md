# MVP - PlantCare App

## 1. Ringkasan MVP

MVP atau **Minimum Viable Product** adalah versi paling sederhana dari PlantCare App yang tetap bisa digunakan dan didemonstrasikan.

Pada versi MVP, aplikasi tidak harus memiliki semua fitur lanjutan. Fokus utama MVP adalah memastikan fitur inti berjalan dengan baik, yaitu:

1. Login sederhana.
2. Menampilkan daftar tanaman dari public API.
3. Menampilkan detail tanaman.
4. Menyimpan tanaman ke database lokal SQLite.
5. Mengelola tanaman pribadi dengan CRUD.
6. Mengambil foto tanaman menggunakan kamera.
7. Logout.

MVP ini dibuat agar project dapat selesai sesuai materi perkuliahan dan tidak terlalu kompleks.

---

## 2. Tujuan MVP

Tujuan MVP PlantCare App adalah:

1. Membuat aplikasi Flutter yang dapat berjalan di Android.
2. Mengimplementasikan GetX untuk navigasi dan state management sederhana.
3. Mengambil data tanaman dari public API.
4. Menampilkan data menggunakan ListView.
5. Membuat form tambah dan edit data.
6. Menyimpan data lokal menggunakan SQLite.
7. Menggunakan kamera untuk mengambil foto tanaman.
8. Menyimpan status login menggunakan SharedPreferences.
9. Menunjukkan penerapan materi perkuliahan secara lengkap.

---

## 3. Scope MVP

### 3.1 Termasuk dalam MVP

Fitur yang wajib ada dalam MVP:

1. Splash screen.
2. Login screen.
3. Home screen berisi daftar tanaman.
4. Search tanaman.
5. Detail tanaman.
6. Simpan tanaman ke My Garden.
7. My Garden screen.
8. Tambah tanaman pribadi.
9. Edit tanaman pribadi.
10. Hapus tanaman pribadi.
11. Ambil foto tanaman.
12. Logout.
13. Loading sederhana.
14. Error message sederhana menggunakan snackbar.

### 3.2 Tidak Termasuk dalam MVP

Fitur berikut tidak wajib dibuat pada versi MVP:

1. Register user.
2. Backend login asli.
3. Role admin dan user.
4. Push notification.
5. Reminder otomatis.
6. Firebase.
7. Upload gambar ke server.
8. Deteksi tanaman menggunakan AI.
9. Deteksi penyakit tanaman menggunakan AI.
10. Google Maps.
11. Kalender perawatan tanaman.
12. Dark mode.
13. Multi-language.
14. Unit test.
15. Clean Architecture.
16. Repository pattern.

---

## 4. Fitur MVP

## 4.1 Splash Screen

### Deskripsi

Splash screen adalah halaman awal aplikasi. Halaman ini digunakan untuk mengecek apakah pengguna sudah login atau belum.

### Alur

1. Aplikasi dibuka.
2. Splash screen tampil selama beberapa detik.
3. Aplikasi mengecek status login dari SharedPreferences.
4. Jika sudah login, pengguna diarahkan ke Home Screen.
5. Jika belum login, pengguna diarahkan ke Login Screen.

### Output

Pengguna diarahkan ke halaman yang sesuai berdasarkan status login.

---

## 4.2 Login Sederhana

### Deskripsi

Login digunakan agar aplikasi memiliki alur autentikasi dasar. Untuk MVP, login tidak menggunakan backend asli.

### Data Login

Aplikasi menggunakan autentikasi lokal. Pengguna mendaftar akun lewat fitur Register, lalu login dengan akun tersebut. Tidak ada akun default yang di-hard-code; sesi disimpan di SharedPreferences.

### Validasi

1. Username tidak boleh kosong.
2. Password tidak boleh kosong.
3. Username dan password harus sesuai dengan data login sederhana.

### Jika Login Berhasil

1. Status login disimpan menggunakan SharedPreferences.
2. Pengguna diarahkan ke Home Screen.
3. Aplikasi menampilkan snackbar berhasil login.

### Jika Login Gagal

1. Aplikasi menampilkan snackbar error.
2. Pengguna tetap berada di Login Screen.

---

## 4.3 Home Screen / Daftar Tanaman

### Deskripsi

Home Screen adalah halaman utama aplikasi. Halaman ini menampilkan daftar tanaman yang diambil dari public API.

### Fitur

1. Menampilkan daftar tanaman.
2. Menampilkan gambar tanaman.
3. Menampilkan nama umum tanaman.
4. Menampilkan nama ilmiah jika tersedia.
5. Search tanaman berdasarkan keyword.
6. Refresh data tanaman.
7. Tombol menuju My Garden.
8. Tombol logout atau profile.

### Komponen Flutter

1. Scaffold.
2. AppBar.
3. TextField untuk search.
4. ListView.
5. Card.
6. Image.
7. CircularProgressIndicator.
8. Get.snackbar untuk pesan error.

### State GetX

Contoh state yang dibutuhkan:

```text id="aabz99"
plants
isLoading
keyword
```

---

## 4.4 Detail Tanaman

### Deskripsi

Detail Tanaman menampilkan informasi lebih lengkap dari tanaman yang dipilih pengguna.

### Data yang Ditampilkan

1. Gambar tanaman.
2. Nama umum tanaman.
3. Nama ilmiah.
4. Watering.
5. Sunlight.
6. Deskripsi jika tersedia.
7. Tombol simpan ke My Garden.

### Fitur

1. Menampilkan data detail tanaman.
2. Menyimpan tanaman ke SQLite.
3. Menampilkan snackbar jika berhasil disimpan.
4. Menampilkan placeholder jika gambar tidak tersedia.

### Output

Tanaman yang dipilih dapat disimpan ke My Garden.

---

## 4.5 My Garden Screen

### Deskripsi

My Garden adalah halaman yang menampilkan tanaman milik pengguna. Data pada halaman ini berasal dari database SQLite.

### Fitur

1. Menampilkan list tanaman dari SQLite.
2. Menampilkan gambar dari API atau foto lokal.
3. Menampilkan nama tanaman.
4. Menampilkan watering dan sunlight.
5. Tombol tambah tanaman pribadi.
6. Tombol edit tanaman.
7. Tombol hapus tanaman.

### Kondisi Kosong

Jika belum ada data tanaman, tampilkan teks:

```text id="7zein3"
Belum ada tanaman di My Garden.
```

---

## 4.6 Tambah Tanaman Pribadi

### Deskripsi

Pengguna dapat menambahkan tanaman pribadi secara manual.

### Input Form

1. Nama tanaman.
2. Nama ilmiah.
3. Watering.
4. Sunlight.
5. Catatan.
6. Foto tanaman.

### Validasi Form

1. Nama tanaman wajib diisi.
2. Watering wajib diisi.
3. Sunlight wajib diisi.
4. Catatan boleh kosong.
5. Foto boleh kosong.

### Output

Data tanaman tersimpan ke SQLite dan muncul di My Garden.

---

## 4.7 Edit Tanaman Pribadi

### Deskripsi

Pengguna dapat mengubah data tanaman yang sudah tersimpan.

### Data yang Bisa Diedit

1. Nama tanaman.
2. Nama ilmiah.
3. Watering.
4. Sunlight.
5. Catatan.
6. Foto tanaman.

### Output

Data lama di SQLite diperbarui dengan data baru.

---

## 4.8 Hapus Tanaman Pribadi

### Deskripsi

Pengguna dapat menghapus tanaman dari My Garden.

### Alur

1. Pengguna menekan tombol hapus.
2. Aplikasi menampilkan dialog konfirmasi.
3. Jika pengguna memilih batal, data tidak dihapus.
4. Jika pengguna memilih hapus, data dihapus dari SQLite.
5. List My Garden diperbarui.

### Dialog

```text id="592xa3"
Apakah kamu yakin ingin menghapus tanaman ini?
```

---

## 4.9 Kamera

### Deskripsi

Fitur kamera digunakan untuk mengambil foto tanaman pribadi.

### Implementasi

Package yang digunakan:

```text id="8puuku"
image_picker
```

### Alur

1. Pengguna membuka form tambah atau edit tanaman.
2. Pengguna menekan tombol ambil foto.
3. Kamera terbuka.
4. Pengguna mengambil foto.
5. Path foto disimpan ke dalam form.
6. Saat data disimpan, path foto disimpan ke SQLite.

### Catatan

Aplikasi tidak perlu upload foto ke server pada versi MVP.

---

## 4.10 Logout

### Deskripsi

Logout digunakan untuk keluar dari aplikasi.

### Alur

1. Pengguna menekan tombol logout.
2. Status login di SharedPreferences dihapus atau diubah menjadi false.
3. Pengguna diarahkan kembali ke Login Screen.

---

## 5. Data yang Dibutuhkan

## 5.1 Data dari Public API

Data minimal dari API:

| Field             | Keterangan          |
| ----------------- | ------------------- |
| `id`              | ID tanaman dari API |
| `common_name`     | Nama umum tanaman   |
| `scientific_name` | Nama ilmiah         |
| `default_image`   | Gambar tanaman      |
| `watering`        | Kebutuhan air       |
| `sunlight`        | Kebutuhan cahaya    |

---

## 5.2 Data SQLite

Data minimal yang disimpan di SQLite:

| Field              | Keterangan                                     |
| ------------------ | ---------------------------------------------- |
| `id`               | ID lokal SQLite                                |
| `api_id`           | ID dari API, boleh kosong untuk tanaman manual |
| `name`             | Nama tanaman                                   |
| `scientific_name`  | Nama ilmiah                                    |
| `image_url`        | URL gambar dari API                            |
| `local_image_path` | Path foto lokal dari kamera                    |
| `watering`         | Kebutuhan air                                  |
| `sunlight`         | Kebutuhan cahaya                               |
| `note`             | Catatan pengguna                               |
| `created_at`       | Tanggal data dibuat                            |

---

## 6. Package yang Digunakan

Package yang digunakan dalam MVP:

```text id="duwz7h"
get
http
sqflite
path
image_picker
shared_preferences
intl
cached_network_image
```

Keterangan:

| Package                | Fungsi                                |
| ---------------------- | ------------------------------------- |
| `get`                  | Navigation dan state management       |
| `http`                 | Mengambil data dari public API        |
| `sqflite`              | Database SQLite                       |
| `path`                 | Mengatur path database                |
| `image_picker`         | Mengakses kamera                      |
| `shared_preferences`   | Menyimpan status login                |
| `intl`                 | Format tanggal                        |
| `cached_network_image` | Menampilkan dan cache gambar dari URL |

---

## 7. Struktur Folder MVP

Struktur folder mengikuti MVC sederhana:

```text id="m7fkpy"
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
```

---

## 8. Alur Navigasi MVP

```text id="sscvpc"
Splash Screen
    ├── jika sudah login → Home Screen
    └── jika belum login → Login Screen

Login Screen
    └── login berhasil → Home Screen

Home Screen
    ├── pilih tanaman → Detail Screen
    ├── buka My Garden → My Garden Screen
    └── logout → Login Screen

Detail Screen
    └── simpan tanaman → My Garden

My Garden Screen
    ├── tambah tanaman → Plant Form Screen
    ├── edit tanaman → Plant Form Screen
    └── hapus tanaman → Dialog Konfirmasi
```

---

## 9. Prioritas Pengerjaan

Urutan pengerjaan MVP:

1. Setup package.
2. Buat struktur folder.
3. Buat model.
4. Buat screen login dan home sederhana.
5. Buat navigation GetX.
6. Integrasi API daftar tanaman.
7. Buat detail tanaman.
8. Setup SQLite.
9. Buat CRUD My Garden.
10. Buat form tambah dan edit tanaman.
11. Tambahkan kamera.
12. Tambahkan logout.
13. Rapikan UI.
14. Testing manual.

---

## 10. Kriteria Selesai MVP

MVP dianggap selesai jika:

1. Aplikasi dapat dibuka tanpa error.
2. Splash screen dapat mengecek status login.
3. Login sederhana berjalan.
4. Home menampilkan list tanaman dari API.
5. Search tanaman berjalan.
6. Detail tanaman tampil.
7. Tanaman dapat disimpan ke SQLite.
8. My Garden menampilkan data dari SQLite.
9. Pengguna dapat menambah tanaman manual.
10. Pengguna dapat mengedit tanaman.
11. Pengguna dapat menghapus tanaman.
12. Kamera dapat mengambil foto.
13. Logout berjalan.
14. Project menggunakan GetX.
15. Struktur folder mengikuti MVC sederhana.

---

## 11. Hal yang Ditunda Setelah MVP

Fitur yang bisa dibuat setelah MVP selesai:

1. Register user.
2. Reminder penyiraman tanaman.
3. Penyimpanan API key yang lebih aman.
4. Halaman profile yang lebih lengkap.
5. Filter tanaman berdasarkan watering atau sunlight.
6. Favorite terpisah dari My Garden.
7. Upload foto ke server.
8. Statistik jumlah tanaman.
9. Dark mode.
10. UI yang lebih modern.

---

## 12. Kesimpulan

MVP PlantCare App berfokus pada fitur inti yang cukup untuk memenuhi kebutuhan project mata kuliah Flutter. Dengan fitur login, REST API, ListView, detail, SQLite CRUD, form, kamera, dan logout, aplikasi sudah mencakup sebagian besar materi dalam silabus.

MVP ini sengaja dibuat sederhana agar mudah dikerjakan, mudah dijelaskan saat presentasi, dan tetap sesuai dengan batasan project kuliah.
