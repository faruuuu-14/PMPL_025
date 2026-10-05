# Pemrograman Multi Platform Lanjutan (IT312)

Repositori ini mendokumentasikan pengerjaan tugas, modul praktikum, dan proyek perkuliahan untuk mata kuliah **Pemrograman Multi Platform Lanjutan (IT312)** dengan memanfaatkan framework **Flutter** dan bahasa pemrograman **Dart**. Dokumentasi ini diperbarui secara berkala mengikuti perkembangan setiap pertemuan perkuliahan.

---

## Daftar Pertemuan dan Progres

| Pertemuan   | Topik Materi                                                                                 | Status  | Snapshot / Referensi                                                                                                                                               |
| ----------- | -------------------------------------------------------------------------------------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Pertemuan 1 | Review PMP Dasar, Asynchronous (Future, `async`/`await`), dan Dart Stream (`async*`/`yield`) | Selesai | [Branch pertemuan-1](https://github.com/faruuuu-14/PMPL_025/tree/pertemuan-1) / [Tag pertemuan-1](https://github.com/faruuuu-14/PMPL_025/releases/tag/pertemuan-1) |
| Pertemuan 2 | REST API Deep Dive: Dio HTTP Client, UI State Management, dan Infinite Scroll Pagination     | Selesai | [Branch pertemuan-2](https://github.com/faruuuu-14/PMPL_025/tree/pertemuan-2) / [Tag pertemuan-2](https://github.com/faruuuu-14/PMPL_025/releases/tag/pertemuan-2) |
| Pertemuan 3 | Provider, Simulasi Login, dan REST API Reqres.in                                             | Selesai | [Branch pertemuan-3](https://github.com/faruuuu-14/PMPL_025/tree/pertemuan-3) / [Tag pertemuan-3](https://github.com/faruuuu-14/PMPL_025/releases/tag/pertemuan-3) |
| Pertemuan 4 | Firebase Authentication, Email & Password Auth, dan Auth State Listener dengan Provider     | Selesai | [Branch pertemuan-4](https://github.com/faruuuu-14/PMPL_025/tree/pertemuan-4) / [Tag pertemuan-4](https://github.com/faruuuu-14/PMPL_025/releases/tag/pertemuan-4) |

---

## Rincian Modul Perkuliahan

### Pertemuan 1 — Review PMP Dasar dan Dart Async

Fokus pembahasan pada pertemuan ini meliputi evaluasi pemahaman arsitektur dasar Flutter serta implementasi pemrosesan asinkronus untuk menjaga responsivitas antarmuka aplikasi (_User Interface_).

- **Simulasi Synchronous (Blocking):**
  Menggunakan `sleep()` untuk mendemonstrasikan pemblokiran pada _Main UI Thread_. Pemanggilan fungsi ini menyebabkan animasi indikator visual mengalami pembekuan (_freeze_) selama 3 detik.
- **Simulasi Asynchronous (Non-Blocking):**
  Menggunakan `await Future.delayed()` untuk mengalihkan proses intensif ke latar belakang (_background_), memastikan antarmuka pengguna tetap berjalan secara lancar tanpa hambatan.
- **Dart Stream Realtime:**
  Mengalirkan data sekuensial (angka 1 hingga 5) secara berkala tiap detik menggunakan generator `async*` dan `yield`, yang dipantau secara reaktif menggunakan widget `StreamBuilder`.
- **Arsip Kode:**
  Seluruh implementasi modul pertemuan 1 tersimpan secara mandiri pada [Branch pertemuan-1](https://github.com/faruuuu-14/PMPL_025/tree/pertemuan-1).

### Pertemuan 2 — REST API Deep Dive: Dio, State Management, dan Pagination

Fokus pembahasan pada pertemuan ini adalah integrasi jaringan tingkat lanjut menggunakan paket `Dio`, penanganan status tampilan antarmuka secara komprehensif, serta penerapan teknik _Infinite Scroll_.

- **Endpoint API:**
  `https://jsonplaceholder.typicode.com/posts?_page={page}&_limit=10`
- **Arsitektur dan Struktur Berkas:**
  ```text
  lib/
  ├── main.dart             # Antarmuka Feed Berita, State Management, dan Infinite Scroll
  ├── models/
  │   └── post_model.dart   # Model Data PostModel dan Factory Constructor fromJson
  └── services/
      └── api_service.dart  # Konfigurasi Dio, BaseOptions, Interceptor, dan Error Handling
  ```
- **Komponen Teknis:**
  - **Dio Client Setup:** Konfigurasi `BaseOptions` terpusat (`baseUrl`, batas waktu `connectTimeout` dan `receiveTimeout` selama 10 detik) serta aktivasi `LogInterceptor` untuk inspeksi jaringan.
  - **Infinite Scroll Pagination:** Penggunaan `ScrollController` dengan pendeteksian ambang batas (200 piksel sebelum batas akhir) untuk memicu pemanggilan data halaman berikutnya secara otomatis.
  - **Pola UI State Management:**
    1. _Loading State:_ Menampilkan indikator proses saat pertama kali memuat data.
    2. _Error State:_ Menangkap `DioException` dan memetakan kode status menjadi pesan kesalahan yang informatif dengan opsi _Coba Lagi_.
    3. _Empty State:_ Tampilan notifikasi ketika respons data kosong.
    4. _Success State:_ Penyajian data dalam bentuk kartu daftar dengan dukungan fitur pembaruan _Pull to Refresh_ (`RefreshIndicator`).

### Pertemuan 3 — Provider, Simulasi Login, dan REST API Reqres.in

Fokus pertemuan ini adalah pemisahan state autentikasi dan data menggunakan `Provider`, pemetaan JSON ke model, serta penanganan state loading, empty, dan error.

- **Login Demo:** Email tidak boleh kosong dan password minimal 6 karakter. Proses login disimulasikan selama 1 detik; tidak memerlukan akun server.
- **Endpoint API:** `https://reqres.in/api/users?page=1&per_page=10`, menggunakan header `x-api-key: reqres-free-v1`. Token login demo dipakai untuk state aplikasi, bukan dikirim sebagai header Bearer ke endpoint ini.
- **Pemetaan Pengguna:** `UserModel.fromJson` membaca `id`, `email`, `first_name`, `last_name`, dan `avatar` dari objek `data` pada respons Reqres.in.
- **State Data:** `DataProvider` mengelola `initial`, `loading`, `loaded`, `empty`, dan `error`, serta menyediakan pemuatan ulang melalui `RefreshIndicator`.
- **Materi Lanjutan:** `ProxyProvider` diperkenalkan sebagai teaser untuk meneruskan perubahan token antar-provider; praktikum ini masih menggunakan `MultiProvider`.

### Pertemuan 4 — Firebase Authentication, Email & Password Auth, dan Provider State Gating

Fokus praktikum pada pertemuan ini adalah merefaktor sistem autentikasi dari dummy token lokal menjadi integrasi penuh dengan **Cloud Firebase Authentication**, menangani pendaftaran (register), login, dan logout dengan email & password, mengolah pesan kesalahan autentikasi berbahasa Indonesia, serta menerapkan arsitektur *Auth Gating* berbasis `authStateChanges()` dan `Provider`.

- **Skema Arsitektur & Auth Gating:**
  - `UI Layer`: `LoginScreen` (toggle form Login & Register) dan router kondisional berbasis `Consumer<AuthProvider>`.
  - `AuthProvider`: Menyimpan objek state aktif `User?` Firebase (bukan lagi dummy string) dan memicu `notifyListeners()`. Properti `isAuthenticated` dievaluasi dari `_user != null`. Properti `token` tetap mengembalikan identifier pengguna (`_user?.uid`) untuk menjaga kompatibilitas `HomeScreen` tanpa perlu modifikasi.
  - `Firebase Auth Engine`: Menangani `createUserWithEmailAndPassword()` untuk pendaftaran dan `signInWithEmailAndPassword()` untuk login akun.
  - `Realtime Session Listener`: `FirebaseAuth.instance.authStateChanges()` mendengarkan perubahan status login/logout secara langsung dan menyinkronkan state ke `AuthProvider.setUser(user)`, memungkinkan aplikasi berpindah rute secara reaktif tanpa pemanggilan ulang API manual.
  - `Home REST (Dio)`: Halaman `HomeScreen` dan `ApiService` berbasis Dio tetap utuh dan memuat data pengguna secara normal setelah pengguna terautentikasi.
- **Penanganan Kesalahan Berbahasa Indonesia:**
  Memetakan kode kesalahan `FirebaseAuthException`:
  - `invalid-email`: "Format email tidak valid."
  - `user-disabled`: "Akun pengguna ini telah dinonaktifkan."
  - `user-not-found`: "Akun dengan email ini tidak ditemukan. Silakan daftar terlebih dahulu."
  - `wrong-password`: "Kata sandi salah. Silakan periksa kembali."
  - `email-already-in-use`: "Email sudah terdaftar. Silakan gunakan email lain atau langsung masuk."
  - `weak-password`: "Kata sandi terlalu lemah. Gunakan minimal 6 karakter."
  - `operation-not-allowed`: "Metode autentikasi Email & Password belum diaktifkan di Firebase Console."
  - `invalid-credential`: "Email atau kata sandi yang Anda masukkan salah."
  - `network-request-failed`: "Koneksi internet bermasalah. Periksa jaringan Anda."
  - `too-many-requests`: "Terlalu banyak percobaan gagal. Silakan coba lagi nanti."
- **Konfigurasi Lingkungan & Troubleshooting:**
  - `WidgetsFlutterBinding.ensureInitialized()`: Dipanggil sebelum `Firebase.initializeApp()` untuk memastikan binding engine siap.
  - `Bypass reCAPTCHA Emulator`: `FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true)` untuk kelancaran pengujian di lingkungan emulator.
  - `minSdkVersion`: Dikonfigurasi minimal 21 pada `android/app/build.gradle.kts` guna mencegah `PlatformException (Channel Error)`.

---

## Panduan Menjalankan Proyek

### Prasyarat Sistem

- Flutter SDK versi 3.47.4 (Channel stable) atau yang lebih baru
- Dart SDK versi 3.13.3 atau kompatibel
- Browser Google Chrome / Microsoft Edge

### Langkah Eksekusi

1. Unduh seluruh dependensi proyek:

   ```powershell
   flutter pub get
   ```

2. Jalankan aplikasi pada platform web dengan port terdefinisi:

   ```powershell
   flutter run -d chrome --web-port 8080
   ```

   _(Alternatif: Buka proyek pada Visual Studio Code dan tekan tombol **F5**)_.

3. Buka peramban web pada alamat:
   `http://localhost:8080`

---

## Spesifikasi Lingkungan Pengembangan

- **Framework:** Flutter 3.47.4 (Channel stable)
- **Bahasa Pemrograman:** Dart 3.13.3
- **Editor:** Visual Studio Code
- **Version Control:** Git & GitHub
