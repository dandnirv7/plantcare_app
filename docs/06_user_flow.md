# User Flow - PlantCare App

## 1. Ringkasan

Dokumen ini menjelaskan alur penggunaan aplikasi **PlantCare App** dari awal aplikasi dibuka sampai pengguna menggunakan fitur utama.

User flow dibuat agar proses implementasi screen, navigation, controller, dan logic aplikasi menjadi lebih jelas.

Aplikasi menggunakan:

- Flutter
- GetX untuk navigation dan state management
- SQLite untuk data My Garden
- Public API untuk data tanaman
- SharedPreferences untuk status login
- Image Picker untuk kamera

---

## 2. Daftar Screen

Screen utama pada aplikasi:

| No  | Screen              | Fungsi                                      |
| --- | ------------------- | ------------------------------------------- |
| 1   | Splash Screen       | Mengecek status login pengguna              |
| 2   | Login Screen        | Form login sederhana                        |
| 3   | Home Screen         | Menampilkan daftar tanaman dari API         |
| 4   | Plant Detail Screen | Menampilkan detail tanaman                  |
| 5   | My Garden Screen    | Menampilkan tanaman yang disimpan di SQLite |
| 6   | Add Plant Screen    | Menambah tanaman pribadi                    |
| 7   | Edit Plant Screen   | Mengedit tanaman pribadi                    |
| 8   | Profile Screen      | Menampilkan profil sederhana dan logout     |
| 9   | State Components    | Tampilan empty state dan error state        |

---

## 3. Alur Utama Aplikasi

Alur utama aplikasi:

```text id="d02x7v"
Aplikasi dibuka
    ↓
Splash Screen
    ↓
Cek status login
    ↓
Jika belum login → Login Screen
Jika sudah login → Home Screen
```

Setelah pengguna masuk ke Home Screen:

```text id="amc0dx"
Home Screen
    ├── Pilih tanaman → Plant Detail Screen
    ├── Search tanaman → Home Screen menampilkan hasil pencarian
    ├── Buka My Garden → My Garden Screen
    ├── Buka Profile → Profile Screen
    └── Logout → Login Screen
```

---

## 4. Splash Flow

## 4.1 Tujuan

Splash Screen digunakan untuk mengecek apakah pengguna sudah login atau belum.

## 4.2 Alur

```text id="lw8rau"
Aplikasi dibuka
    ↓
Splash Screen tampil
    ↓
AuthController mengecek SharedPreferences
    ↓
Apakah user sudah login?
    ├── Ya → Home Screen
    └── Tidak → Login Screen
```

## 4.3 State yang Digunakan

| State        | Keterangan                          |
| ------------ | ----------------------------------- |
| `isLoggedIn` | Status login dari SharedPreferences |

## 4.4 Output

| Kondisi          | Tujuan       |
| ---------------- | ------------ |
| User sudah login | Home Screen  |
| User belum login | Login Screen |

---

## 5. Login Flow

## 5.1 Tujuan

Login Flow digunakan agar pengguna dapat masuk ke aplikasi.

Untuk MVP, login dibuat sederhana tanpa backend.

### Data Login Default

Aplikasi menggunakan autentikasi lokal. Pengguna mendaftar akun lewat fitur Register, lalu login dengan akun tersebut. Tidak ada akun default yang di-hard-code.

## 5.3 Alur Login Berhasil

```text id="g2kaoa"
Login Screen
    ↓
User mengisi username dan password
    ↓
User menekan tombol Login
    ↓
Form divalidasi
    ↓
Username dan password benar
    ↓
Simpan status login ke SharedPreferences
    ↓
Tampilkan snackbar berhasil
    ↓
Arahkan ke Home Screen
```

## 5.4 Alur Login Gagal

```text id="jqpb6f"
Login Screen
    ↓
User mengisi username dan password
    ↓
User menekan tombol Login
    ↓
Form divalidasi
    ↓
Username atau password salah
    ↓
Tampilkan snackbar error
    ↓
Tetap di Login Screen
```

## 5.5 Validasi Form

| Field    | Validasi           |
| -------- | ------------------ |
| Username | Tidak boleh kosong |
| Password | Tidak boleh kosong |

## 5.6 Output

| Kondisi        | Output                |
| -------------- | --------------------- |
| Login berhasil | Masuk ke Home Screen  |
| Login gagal    | Muncul snackbar error |
| Field kosong   | Muncul pesan validasi |

---

## 6. Home Flow

## 6.1 Tujuan

Home Screen digunakan untuk menampilkan daftar tanaman dari public API.

## 6.2 Alur Load Data Tanaman

```text id="im5r0r"
Home Screen dibuka
    ↓
PlantController memanggil API plant list
    ↓
isLoading = true
    ↓
API mengembalikan data
    ↓
Data disimpan ke list plants
    ↓
isLoading = false
    ↓
ListView menampilkan daftar tanaman
```

## 6.3 Alur Jika API Gagal

```text id="zu3748"
Home Screen dibuka
    ↓
PlantController memanggil API
    ↓
API gagal / internet bermasalah
    ↓
isLoading = false
    ↓
Tampilkan snackbar error
    ↓
Tampilkan error state atau list kosong
```

## 6.4 Aksi di Home Screen

| Aksi User                | Tujuan               |
| ------------------------ | -------------------- |
| Klik plant card          | Plant Detail Screen  |
| Ketik keyword search     | Mengisi keyword      |
| Tekan tombol search      | Memanggil API search |
| Klik My Garden           | My Garden Screen     |
| Klik Profile             | Profile Screen       |
| Pull refresh jika dibuat | Load ulang data API  |

---

## 7. Search Plant Flow

## 7.1 Tujuan

Search digunakan untuk mencari tanaman berdasarkan keyword.

## 7.2 Alur Search

```text id="pbnjvi"
Home Screen
    ↓
User mengetik keyword
    ↓
User menekan tombol search
    ↓
PlantController memanggil API search
    ↓
isLoading = true
    ↓
API mengembalikan hasil
    ↓
List plants diperbarui
    ↓
isLoading = false
```

## 7.3 Jika Keyword Kosong

```text id="6vf229"
User menekan search dengan keyword kosong
    ↓
Aplikasi memanggil ulang plant list default
    ↓
List tanaman awal ditampilkan
```

## 7.4 Jika Hasil Kosong

```text id="vftw8x"
Search dijalankan
    ↓
API berhasil
    ↓
Data tidak ditemukan
    ↓
Tampilkan empty state
```

---

## 8. Plant Detail Flow

## 8.1 Tujuan

Plant Detail Screen digunakan untuk melihat informasi tanaman secara lebih lengkap.

## 8.2 Alur Buka Detail

```text id="iz57lx"
Home Screen
    ↓
User memilih salah satu plant card
    ↓
Navigasi ke Plant Detail Screen
    ↓
PlantController mengambil detail tanaman berdasarkan ID
    ↓
Detail tanaman ditampilkan
```

## 8.3 Data yang Ditampilkan

| Data            | Keterangan              |
| --------------- | ----------------------- |
| Plant image     | Gambar tanaman          |
| Common name     | Nama umum tanaman       |
| Scientific name | Nama ilmiah             |
| Watering        | Kebutuhan air           |
| Sunlight        | Kebutuhan cahaya        |
| Description     | Deskripsi jika tersedia |

---

## 9. Save to My Garden Flow

## 9.1 Tujuan

Pengguna dapat menyimpan tanaman dari API ke My Garden.

## 9.2 Alur Simpan

```text id="cjzzp0"
Plant Detail Screen
    ↓
User menekan tombol Save to My Garden
    ↓
Data plant dikonversi menjadi MyPlant
    ↓
GardenController memanggil insert SQLite
    ↓
Data tersimpan ke table my_garden
    ↓
Tampilkan snackbar berhasil
```

## 9.3 Jika Simpan Gagal

```text id="xmu210"
User menekan Save to My Garden
    ↓
Insert SQLite gagal
    ↓
Tampilkan snackbar error
```

## 9.4 Output

| Kondisi  | Output                     |
| -------- | -------------------------- |
| Berhasil | Tanaman masuk ke My Garden |
| Gagal    | Snackbar error             |

---

## 10. My Garden Flow

## 10.1 Tujuan

My Garden Screen menampilkan tanaman yang disimpan di SQLite.

## 10.2 Alur Load My Garden

```text id="vcpj73"
My Garden Screen dibuka
    ↓
GardenController mengambil data dari SQLite
    ↓
isLoading = true
    ↓
Data berhasil diambil
    ↓
myPlants diperbarui
    ↓
isLoading = false
    ↓
ListView menampilkan tanaman
```

## 10.3 Jika My Garden Kosong

```text id="yl35tn"
My Garden Screen dibuka
    ↓
SQLite tidak memiliki data
    ↓
Tampilkan empty state
```

## 10.4 Aksi di My Garden

| Aksi User       | Tujuan                                   |
| --------------- | ---------------------------------------- |
| Klik Add Plant  | Add Plant Screen                         |
| Klik Edit       | Edit Plant Screen                        |
| Klik Delete     | Dialog konfirmasi hapus                  |
| Klik plant card | Bisa menuju Edit Plant atau Detail lokal |
| Klik Home       | Home Screen                              |
| Klik Profile    | Profile Screen                           |

---

## 11. Add Plant Flow

## 11.1 Tujuan

Add Plant Screen digunakan untuk menambahkan tanaman pribadi secara manual.

## 11.2 Alur Tambah Tanaman

```text id="jvcl8s"
My Garden Screen
    ↓
User menekan Add Plant
    ↓
Add Plant Screen terbuka
    ↓
User mengisi form
    ↓
User dapat mengambil foto tanaman
    ↓
User menekan Save Plant
    ↓
Form divalidasi
    ↓
Data disimpan ke SQLite
    ↓
Snackbar berhasil ditampilkan
    ↓
Kembali ke My Garden Screen
```

## 11.3 Validasi Form

| Field           | Validasi    |
| --------------- | ----------- |
| Plant Name      | Wajib diisi |
| Scientific Name | Opsional    |
| Watering        | Wajib diisi |
| Sunlight        | Wajib diisi |
| Note            | Opsional    |
| Photo           | Opsional    |

## 11.4 Jika Validasi Gagal

```text id="kdi6wq"
User menekan Save Plant
    ↓
Form belum valid
    ↓
Tampilkan pesan validasi pada field yang kosong
    ↓
Tetap di Add Plant Screen
```

---

## 12. Edit Plant Flow

## 12.1 Tujuan

Edit Plant Screen digunakan untuk mengubah data tanaman yang sudah tersimpan.

## 12.2 Alur Edit Tanaman

```text id="gm725s"
My Garden Screen
    ↓
User menekan Edit pada salah satu tanaman
    ↓
Edit Plant Screen terbuka
    ↓
Form terisi data lama
    ↓
User mengubah data
    ↓
User dapat mengganti foto
    ↓
User menekan Update Plant
    ↓
Form divalidasi
    ↓
Data SQLite diperbarui
    ↓
Snackbar berhasil ditampilkan
    ↓
Kembali ke My Garden Screen
```

## 12.3 Jika Update Gagal

```text id="c3gw4f"
User menekan Update Plant
    ↓
Update SQLite gagal
    ↓
Tampilkan snackbar error
    ↓
Tetap di Edit Plant Screen
```

---

## 13. Delete Plant Flow

## 13.1 Tujuan

Delete Plant Flow digunakan untuk menghapus tanaman dari My Garden.

## 13.2 Alur Delete

```text id="6p2w8e"
My Garden Screen
    ↓
User menekan Delete
    ↓
Dialog konfirmasi tampil
    ↓
Apakah user yakin?
    ├── Tidak → Dialog ditutup, data tidak dihapus
    └── Ya → Data dihapus dari SQLite
            ↓
            Snackbar berhasil ditampilkan
            ↓
            List My Garden diperbarui
```

## 13.3 Dialog

```text id="a8sqng"
Title: Hapus Tanaman
Message: Apakah kamu yakin ingin menghapus tanaman ini?
Button: Batal, Hapus
```

---

## 14. Camera Flow

## 14.1 Tujuan

Camera digunakan untuk mengambil foto tanaman pribadi.

## 14.2 Alur Ambil Foto

```text id="93bmj8"
Add/Edit Plant Screen
    ↓
User menekan area foto atau tombol kamera
    ↓
ImagePicker membuka kamera
    ↓
User mengambil foto
    ↓
Path foto disimpan ke state imagePath
    ↓
Preview foto ditampilkan di form
    ↓
Saat form disimpan, path foto masuk ke SQLite
```

## 14.3 Jika Kamera Gagal

```text id="9ep6tn"
User membuka kamera
    ↓
Kamera gagal / user batal
    ↓
Tampilkan snackbar jika diperlukan
    ↓
Tetap di form
```

---

## 15. Profile Flow

## 15.1 Tujuan

Profile Screen digunakan untuk menampilkan informasi user sederhana dan tombol logout.

## 15.2 Alur Buka Profile

```text id="o7xu89"
Home Screen / My Garden Screen
    ↓
User menekan Profile
    ↓
Profile Screen terbuka
    ↓
Tampilkan username dan informasi aplikasi
```

## 15.3 Data yang Ditampilkan

| Data            | Keterangan                                             |
| --------------- | ------------------------------------------------------ |
| Username        | Username akun yang sedang login (dari Register/SQLite) |
| Role / Subtitle | PlantCare User                                         |
| Saved Plants    | Jumlah data di My Garden                               |
| App Version     | 1.0.0                                                  |

---

## 16. Logout Flow

## 16.1 Tujuan

Logout digunakan untuk keluar dari aplikasi.

## 16.2 Alur Logout

```text id="x602l1"
Profile Screen
    ↓
User menekan Logout
    ↓
Dialog konfirmasi tampil
    ↓
Apakah user yakin logout?
    ├── Tidak → Dialog ditutup
    └── Ya → Hapus status login dari SharedPreferences
            ↓
            Arahkan ke Login Screen
```

## 16.3 Output

| Kondisi           | Output                       |
| ----------------- | ---------------------------- |
| Logout berhasil   | User kembali ke Login Screen |
| Logout dibatalkan | User tetap di Profile Screen |

---

## 17. Empty State Flow

## 17.1 Kondisi Empty State

Empty state muncul ketika data kosong.

Contoh kondisi:

1. My Garden belum memiliki tanaman.
2. Search tanaman tidak menemukan hasil.
3. API berhasil dipanggil tetapi data kosong.

## 17.2 Tampilan Empty State

```text id="43lgrv"
Icon: Plant pot / empty garden
Title: No plants yet
Message: Your garden is still empty. Add your first plant to get started.
Button: Add Plant
```

## 17.3 Aksi Empty State

| Lokasi        | Aksi                                          |
| ------------- | --------------------------------------------- |
| My Garden     | Tombol Add Plant menuju Add Plant Screen      |
| Search Result | Tombol Clear Search atau kembali ke list awal |

---

## 18. Error State Flow

## 18.1 Kondisi Error State

Error state muncul ketika terjadi kesalahan.

Contoh kondisi:

1. Internet bermasalah.
2. API gagal diakses.
3. API key salah.
4. SQLite gagal mengambil data.

## 18.2 Tampilan Error State

```text id="j955uj"
Icon: Warning / wifi off
Title: Something went wrong
Message: Failed to load plant data. Please check your connection and try again.
Button: Try Again
```

## 18.3 Aksi Error State

| Lokasi       | Aksi                             |
| ------------ | -------------------------------- |
| Home Screen  | Try Again memanggil ulang API    |
| Plant Detail | Try Again memanggil ulang detail |
| My Garden    | Try Again membaca ulang SQLite   |

---

## 19. Bottom Navigation Flow

Aplikasi dapat menggunakan BottomNavigationBar sederhana.

Menu:

| Menu      | Screen           |
| --------- | ---------------- |
| Home      | Home Screen      |
| My Garden | My Garden Screen |
| Profile   | Profile Screen   |

Alur:

```text id="zaagqv"
Home ↔ My Garden ↔ Profile
```

Catatan:

Bottom navigation tidak wajib dibuat terlalu kompleks. Jika ingin lebih sederhana, My Garden dan Profile juga bisa dibuka melalui AppBar icon atau button.

---

## 20. GetX Navigation

Navigasi menggunakan GetX.

Contoh alur navigation:

```text id="tbek1a"
Get.to(() => DetailScreen())
Get.to(() => MyGardenScreen())
Get.to(() => PlantFormScreen())
Get.back()
Get.offAll(() => LoginScreen())
```

Aturan:

1. Gunakan `Get.to()` untuk berpindah ke screen baru.
2. Gunakan `Get.back()` untuk kembali.
3. Gunakan `Get.offAll()` setelah logout agar user tidak bisa kembali ke Home menggunakan tombol back.
4. Gunakan `Get.snackbar()` untuk pesan berhasil atau gagal.
5. Jangan membuat navigation system terlalu kompleks.

---

## 21. Ringkasan Alur Lengkap

```text id="g55gh7"
Splash Screen
    ↓
Cek Login
    ├── Belum Login
    │       ↓
    │   Login Screen
    │       ↓
    │   Home Screen
    │
    └── Sudah Login
            ↓
        Home Screen
            ├── Search Plant
            ├── Plant Detail
            │       └── Save to My Garden
            │
            ├── My Garden
            │       ├── Add Plant
            │       ├── Edit Plant
            │       └── Delete Plant
            │
            └── Profile
                    └── Logout
                            ↓
                        Login Screen
```

---

## 22. Kesimpulan

User flow PlantCare App dibuat sederhana agar mudah diimplementasikan menggunakan Flutter dan GetX. Alur utama aplikasi dimulai dari Splash Screen, Login Screen, Home Screen, Detail Screen, My Garden, Form CRUD tanaman, kamera, Profile, dan Logout.

Dengan user flow ini, proses implementasi screen dan controller menjadi lebih jelas serta tetap sesuai dengan scope project mata kuliah.
