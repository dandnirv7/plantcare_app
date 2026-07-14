# Pemetaan Kebutuhan UAS — PlantCare App

| Kebutuhan UAS | Implementasi di PlantCare App |
| --- | --- |
| Widget Layout | Material Scaffold, AppBar, Card, layout form, dan scrolling responsif sederhana di seluruh aplikasi. |
| Widget Component | TextFormField, ElevatedButton, ListTile/Card, widget gambar, dialog, snackbar, indikator loading, dan BottomNavigationBar sesuai kebutuhan. |
| Navigasi | Navigasi GetX dengan `Get.to`, `Get.back`, dan `Get.offAll` untuk routing auth. |
| List View | Home menampilkan data tanaman Perenual; My Garden menampilkan record SQLite pakai ListView. |
| Local Storage SQLite | `plantcare.db` berisi `users` dan `my_garden`; UserDataAccess dan MyPlantDataAccess menangani query. |
| Widget Form | Register, Login, dan Plant Form pakai `GlobalKey<FormState>`, TextFormField, dan validasi. |
| REST API | PlantController pakai HTTP untuk mengambil data list, search, dan detail Perenual. |
| Camera Picture + Video | image_picker untuk ambil foto/video kamera; path lokal disimpan tanpa upload server. |
| GPS & Location | geolocator mengambil koordinat saat ini; latitude dan longitude disimpan di SQLite dan bisa ditampilkan. |
| Security API Call | Key diambil dari `.env` via flutter_dotenv/constants; PlantController mengecek key kosong, try-catch, status 200, timeout, snackbar error, dan tidak menampilkan key. |

Project sengaja hanya menggunakan GetX dan MVC sederhana. Tidak menggunakan Firebase, Google Maps, layer repository, Clean Architecture, BLoC, Riverpod, atau Provider.
