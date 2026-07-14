# Features - PlantCare App

## 1. Ringkasan

Dokumen ini berisi daftar fitur PlantCare App secara lebih detail. Fitur disusun berdasarkan kebutuhan aplikasi, materi perkuliahan, dan batasan project agar tetap sederhana.

PlantCare App menggunakan Flutter dengan GetX, REST API, SQLite, dan kamera. Struktur project mengikuti pola MVC sederhana:

```text id="n1jhby"
lib/
  model/
  controller/
  screen/
  dataaccess/
  provider/
```

Fitur dalam dokumen ini dibagi menjadi:

1. Authentication
2. Splash Screen
3. Home / Plant List
4. Search Plant
5. Plant Detail
6. My Garden
7. Add Plant
8. Edit Plant
9. Delete Plant
10. Camera
11. Local Database
12. REST API
13. Security REST API
14. Error Handling
15. UI Components

---

## 2. Authentication

## 2.1 Login Sederhana

### Deskripsi

Login digunakan sebagai pintu masuk aplikasi. Pada versi awal, login dibuat sederhana tanpa backend.

### Input

| Field    | Tipe | Wajib | Keterangan        |
| -------- | ---- | ----- | ----------------- |
| Username | Text | Ya    | Username pengguna |
| Password | Text | Ya    | Password pengguna |

### Data Login Default

```text id="dwv9uz"
Username: admin
Password: admin123
```

### Validasi

1. Username tidak boleh kosong.
2. Password tidak boleh kosong.
3. Username dan password harus sesuai dengan data login default.

### Jika Berhasil

1. Simpan status login ke SharedPreferences.
2. Arahkan pengguna ke Home Screen.
3. Tampilkan pesan berhasil menggunakan `Get.snackbar()`.

### Jika Gagal

1. Tampilkan pesan error menggunakan `Get.snackbar()`.
2. Tetap di Login Screen.

---

## 2.2 Logout

### Deskripsi

Logout digunakan untuk keluar dari aplikasi.

### Alur

1. Pengguna menekan tombol logout.
2. Aplikasi menampilkan dialog konfirmasi.
3. Jika pengguna memilih logout, hapus status login.
4. Arahkan pengguna ke Login Screen.

### Output

Pengguna keluar dari aplikasi dan harus login kembali.

---

## 3. Splash Screen

### Deskripsi

Splash Screen adalah halaman awal untuk mengecek status login.

### Fitur

1. Menampilkan nama aplikasi.
2. Menampilkan teks loading sederhana.
3. Mengecek status login dari SharedPreferences.
4. Mengarahkan pengguna ke halaman yang sesuai.

### Alur

```text id="pbe5ir"
Aplikasi dibuka
    ↓
Splash Screen
    ↓
Cek status login
    ↓
Jika login = true → Home Screen
Jika login = false → Login Screen
```

### Catatan

Splash screen tidak perlu animasi kompleks.

---

## 4. Home / Plant List

### Deskripsi

Home Screen menampilkan daftar tanaman dari public API.

### Fitur

1. Menampilkan daftar tanaman.
2. Menampilkan gambar tanaman.
3. Menampilkan nama umum tanaman.
4. Menampilkan nama ilmiah jika tersedia.
5. Menampilkan loading ketika mengambil data.
6. Menampilkan pesan error jika gagal mengambil data.
7. Menyediakan search tanaman.
8. Menyediakan tombol menuju My Garden.
9. Menyediakan tombol logout atau profile.

### Komponen UI

1. AppBar.
2. TextField search.
3. ListView.
4. Card tanaman.
5. CachedNetworkImage.
6. CircularProgressIndicator.
7. FloatingActionButton atau tombol My Garden.

### Data yang Ditampilkan

| Data            | Keterangan                  |
| --------------- | --------------------------- |
| Image           | Gambar tanaman dari API     |
| Common Name     | Nama umum tanaman           |
| Scientific Name | Nama ilmiah tanaman         |
| Watering        | Kebutuhan air jika tersedia |

---

## 5. Search Plant

### Deskripsi

Search digunakan untuk mencari tanaman berdasarkan keyword.

### Input

| Field   | Tipe | Keterangan                     |
| ------- | ---- | ------------------------------ |
| Keyword | Text | Nama tanaman yang ingin dicari |

### Alur

1. Pengguna mengetik keyword.
2. Pengguna menekan tombol search.
3. Controller memanggil API search.
4. List tanaman diperbarui berdasarkan hasil pencarian.

### Validasi

1. Jika keyword kosong, tampilkan semua tanaman.
2. Jika hasil tidak ditemukan, tampilkan pesan data kosong.

### Catatan

Search tidak perlu real-time. Untuk versi sederhana, search dijalankan ketika pengguna menekan tombol search.

---

## 6. Plant Detail

### Deskripsi

Plant Detail menampilkan informasi lengkap tanaman yang dipilih dari Home Screen.

### Fitur

1. Menampilkan gambar tanaman.
2. Menampilkan nama umum.
3. Menampilkan nama ilmiah.
4. Menampilkan watering.
5. Menampilkan sunlight.
6. Menampilkan deskripsi jika tersedia.
7. Menyediakan tombol simpan ke My Garden.
8. Menampilkan snackbar ketika data berhasil disimpan.

### Data Detail

| Data            | Keterangan                      |
| --------------- | ------------------------------- |
| ID              | ID tanaman dari API             |
| Common Name     | Nama umum tanaman               |
| Scientific Name | Nama ilmiah                     |
| Image URL       | Gambar tanaman                  |
| Watering        | Kebutuhan air                   |
| Sunlight        | Kebutuhan cahaya                |
| Description     | Deskripsi tanaman jika tersedia |

### Kondisi Data Kosong

Jika data tertentu tidak tersedia dari API, tampilkan teks default:

```text id="ahxmzf"
Data tidak tersedia
```

---

## 7. My Garden

### Deskripsi

My Garden adalah halaman untuk menampilkan tanaman yang disimpan oleh pengguna. Data berasal dari SQLite.

### Fitur

1. Menampilkan tanaman yang tersimpan di SQLite.
2. Menampilkan nama tanaman.
3. Menampilkan gambar dari API atau foto lokal.
4. Menampilkan watering dan sunlight.
5. Menyediakan tombol tambah tanaman.
6. Menyediakan tombol edit tanaman.
7. Menyediakan tombol hapus tanaman.
8. Menampilkan pesan jika data kosong.

### Empty State

Jika belum ada tanaman:

```text id="xzzpbg"
Belum ada tanaman di My Garden.
Tambahkan tanaman favoritmu terlebih dahulu.
```

### Prioritas Gambar

Urutan gambar yang digunakan:

1. Jika ada `local_image_path`, tampilkan foto lokal.
2. Jika tidak ada, tampilkan `image_url`.
3. Jika keduanya kosong, tampilkan placeholder.

---

## 8. Add Plant

### Deskripsi

Add Plant digunakan untuk menambahkan tanaman pribadi secara manual ke My Garden.

### Input Form

| Field           | Tipe  | Wajib | Keterangan               |
| --------------- | ----- | ----- | ------------------------ |
| Name            | Text  | Ya    | Nama tanaman             |
| Scientific Name | Text  | Tidak | Nama ilmiah              |
| Watering        | Text  | Ya    | Kebutuhan air            |
| Sunlight        | Text  | Ya    | Kebutuhan cahaya         |
| Note            | Text  | Tidak | Catatan pribadi          |
| Photo           | Image | Tidak | Foto tanaman dari kamera |

### Validasi

1. Name wajib diisi.
2. Watering wajib diisi.
3. Sunlight wajib diisi.
4. Note boleh kosong.
5. Photo boleh kosong.

### Output

Data tanaman masuk ke SQLite dan muncul di My Garden.

---

## 9. Edit Plant

### Deskripsi

Edit Plant digunakan untuk mengubah data tanaman yang sudah tersimpan.

### Fitur

1. Menampilkan data lama di dalam form.
2. Pengguna dapat mengubah data.
3. Pengguna dapat mengganti foto tanaman.
4. Data di SQLite diperbarui.
5. Setelah berhasil, pengguna kembali ke My Garden.

### Validasi

Validasi sama seperti Add Plant:

1. Name wajib diisi.
2. Watering wajib diisi.
3. Sunlight wajib diisi.

---

## 10. Delete Plant

### Deskripsi

Delete Plant digunakan untuk menghapus tanaman dari My Garden.

### Alur

1. Pengguna menekan tombol hapus.
2. Aplikasi menampilkan dialog konfirmasi.
3. Jika pengguna memilih batal, data tidak dihapus.
4. Jika pengguna memilih hapus, data dihapus dari SQLite.
5. List My Garden diperbarui.

### Dialog Konfirmasi

```text id="to4kir"
Judul: Hapus Tanaman
Pesan: Apakah kamu yakin ingin menghapus tanaman ini?
Tombol: Batal, Hapus
```

---

## 11. Camera

### Deskripsi

Camera digunakan untuk mengambil foto tanaman pribadi.

### Package

```text id="0r2hrq"
image_picker
```

### Fitur

1. Ambil foto dari kamera.
2. Ambil gambar dari galeri jika dibutuhkan.
3. Menampilkan preview foto di form.
4. Menyimpan path foto ke SQLite.

### Catatan

Untuk MVP, foto tidak diupload ke server. Aplikasi hanya menyimpan path lokal gambar.

---

## 12. Local Database SQLite

### Deskripsi

SQLite digunakan untuk menyimpan data My Garden.

### Fungsi Database

1. Insert tanaman.
2. Select semua tanaman.
3. Select tanaman berdasarkan ID.
4. Update tanaman.
5. Delete tanaman.

### Table Utama

```text id="jwj3dc"
my_garden
```

### Data yang Disimpan

| Field            | Tipe    | Keterangan                |
| ---------------- | ------- | ------------------------- |
| id               | INTEGER | Primary key lokal         |
| api_id           | INTEGER | ID dari API, boleh kosong |
| name             | TEXT    | Nama tanaman              |
| scientific_name  | TEXT    | Nama ilmiah               |
| image_url        | TEXT    | URL gambar API            |
| local_image_path | TEXT    | Path foto lokal           |
| watering         | TEXT    | Kebutuhan air             |
| sunlight         | TEXT    | Kebutuhan cahaya          |
| note             | TEXT    | Catatan pengguna          |
| created_at       | TEXT    | Tanggal dibuat            |

---

## 13. REST API

### Deskripsi

REST API digunakan untuk mengambil data tanaman dari public API.

### API yang Digunakan

```text id="5x7w46"
Perenual Plant API
```

### Endpoint yang Digunakan

| Fitur          | Method | Endpoint                              |
| -------------- | ------ | ------------------------------------- |
| Daftar tanaman | GET    | `/species-list?key=API_KEY`           |
| Search tanaman | GET    | `/species-list?key=API_KEY&q=keyword` |
| Detail tanaman | GET    | `/species/details/{id}?key=API_KEY`   |

### Data dari API

1. ID tanaman.
2. Nama umum tanaman.
3. Nama ilmiah.
4. Gambar tanaman.
5. Watering.
6. Sunlight.
7. Deskripsi jika tersedia.

### Error API

Jika API gagal diakses:

1. Tampilkan snackbar error.
2. Jangan crash.
3. Jika data list kosong, tampilkan empty state.

---

## 14. Security REST API

### Deskripsi

Security REST API dibuat sederhana sesuai kebutuhan project kuliah.

### Implementasi

1. API key disimpan di satu file, misalnya:

```text id="ndzk8r"
lib/utils/constants.dart
```

2. API key tidak ditulis berulang di banyak file.
3. Jika ada token login sederhana, simpan di SharedPreferences.
4. Request API dibungkus dengan try-catch.
5. Jangan tampilkan API key di UI.

### Catatan

Untuk project kuliah, API key tetap bisa terlihat di source code. Namun minimal API key dikelola dengan rapi di satu tempat agar lebih mudah dijelaskan pada sesi Security REST API.

---

## 15. Error Handling

### Deskripsi

Error handling dibuat sederhana agar mudah dipahami.

### Jenis Error

| Error         | Solusi                |
| ------------- | --------------------- |
| API gagal     | Tampilkan snackbar    |
| Data kosong   | Tampilkan empty state |
| Gambar kosong | Tampilkan placeholder |
| SQLite error  | Tampilkan snackbar    |
| Kamera gagal  | Tampilkan snackbar    |
| Form kosong   | Tampilkan validator   |

### Contoh Pesan

```text id="9i91ji"
Gagal mengambil data tanaman
Data tanaman tidak ditemukan
Nama tanaman wajib diisi
Foto gagal diambil
Data berhasil disimpan
```

---

## 16. UI Components

### Komponen yang Dibutuhkan

1. Plant Card.
2. Loading Widget.
3. Empty State Widget.
4. Form Input.
5. Image Placeholder.
6. Confirmation Dialog.

### Plant Card

Plant Card digunakan di Home dan My Garden.

Isi Plant Card:

1. Gambar tanaman.
2. Nama tanaman.
3. Nama ilmiah.
4. Watering atau sunlight.
5. Tombol aksi jika diperlukan.

---

## 17. State Management GetX

### Controller yang Digunakan

| Controller       | Fungsi                                 |
| ---------------- | -------------------------------------- |
| AuthController   | Login, logout, cek status login        |
| PlantController  | Ambil data API, search, detail tanaman |
| GardenController | CRUD SQLite dan kamera                 |

### Contoh State

```text id="u0v6mf"
isLoading
plants
selectedPlant
myGardenPlants
imagePath
```

### Aturan

1. Gunakan `GetxController`.
2. Gunakan `.obs` untuk state.
3. Gunakan `Obx()` di UI.
4. Gunakan `Get.to()` untuk navigasi.
5. Gunakan `Get.back()` untuk kembali.
6. Gunakan `Get.snackbar()` untuk notifikasi.

---

## 18. Mapping Fitur ke Materi Kuliah

| Materi                        | Implementasi                            |
| ----------------------------- | --------------------------------------- |
| Pengenalan Flutter dan Widget | Text, Image, Button, Card               |
| Layout Widget                 | Column, Row, Container, ListView        |
| Layout Desain Lanjutan        | Card layout, form layout, detail layout |
| Flutter Navigation            | Get.to, Get.back                        |
| ListView Flutter              | Daftar tanaman                          |
| Flutter Form                  | Login, tambah tanaman, edit tanaman     |
| Flutter SQLite                | My Garden local database                |
| Flutter SQLite CRUD           | Insert, read, update, delete tanaman    |
| Flutter REST API              | Ambil data tanaman dari API             |
| Flutter CRUD                  | CRUD tanaman pribadi                    |
| Akses Camera                  | Foto tanaman                            |
| Security REST API             | API key, token sederhana, try-catch     |

---

## 19. Prioritas Fitur

### Prioritas 1 - Wajib Selesai

1. Login.
2. Home list tanaman.
3. Detail tanaman.
4. My Garden SQLite.
5. Tambah tanaman.
6. Edit tanaman.
7. Hapus tanaman.
8. Kamera.
9. Logout.

### Prioritas 2 - Jika Ada Waktu

1. Search tanaman.
2. Pull to refresh.
3. Placeholder image.
4. Profile sederhana.
5. Filter tanaman.

### Prioritas 3 - Tidak Wajib

1. Reminder.
2. Register.
3. Upload foto.
4. AI plant detection.
5. Firebase.

---

## 20. Kesimpulan

Fitur PlantCare App dibuat untuk memenuhi kebutuhan project mata kuliah Flutter tanpa membuat aplikasi terlalu kompleks. Fitur utama berfokus pada penggunaan GetX, REST API, ListView, Form, SQLite CRUD, kamera, dan security REST API sederhana.

Dengan fitur yang ada di dokumen ini, project sudah cukup kuat untuk dipresentasikan sebagai aplikasi mobile berbasis Flutter.
