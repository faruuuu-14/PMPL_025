# Pemrograman Multi Platform Lanjutan (IT312)

Repositori ini mendokumentasikan pengerjaan tugas, modul praktikum, dan proyek perkuliahan untuk mata kuliah **Pemrograman Multi Platform Lanjutan (IT312)** dengan memanfaatkan framework **Flutter** dan bahasa pemrograman **Dart**. Dokumentasi ini diperbarui secara berkala mengikuti perkembangan setiap pertemuan perkuliahan.

---

## Daftar Pertemuan dan Progres

| Pertemuan | Topik Materi | Status | Snapshot / Referensi |
|---|---|---|---|
| Pertemuan 1 | Review PMP Dasar, Asynchronous (Future, `async`/`await`), dan Dart Stream (`async*`/`yield`) | Selesai | [Branch pertemuan-1](https://github.com/faruuuu-14/PMPL_025/tree/pertemuan-1) / [Tag pertemuan-1](https://github.com/faruuuu-14/PMPL_025/releases/tag/pertemuan-1) |
| Pertemuan 2 | REST API Deep Dive: Dio HTTP Client, UI State Management, dan Infinite Scroll Pagination | Selesai | [Branch main](https://github.com/faruuuu-14/PMPL_025) / [Tag pertemuan-2](https://github.com/faruuuu-14/PMPL_025/releases/tag/pertemuan-2) |
| Pertemuan 3 | Belum Dimulai | Terjadwal | - |

---

## Rincian Modul Perkuliahan

### Pertemuan 1 — Review PMP Dasar dan Dart Async

Fokus pembahasan pada pertemuan ini meliputi evaluasi pemahaman arsitektur dasar Flutter serta implementasi pemrosesan asinkronus untuk menjaga responsivitas antarmuka aplikasi (*User Interface*).

* **Simulasi Synchronous (Blocking):**
  Menggunakan `sleep()` untuk mendemonstrasikan pemblokiran pada *Main UI Thread*. Pemanggilan fungsi ini menyebabkan animasi indikator visual mengalami pembekuan (*freeze*) selama 3 detik.
* **Simulasi Asynchronous (Non-Blocking):**
  Menggunakan `await Future.delayed()` untuk mengalihkan proses intensif ke latar belakang (*background*), memastikan antarmuka pengguna tetap berjalan secara lancar tanpa hambatan.
* **Dart Stream Realtime:**
  Mengalirkan data sekuensial (angka 1 hingga 5) secara berkala tiap detik menggunakan generator `async*` dan `yield`, yang dipantau secara reaktif menggunakan widget `StreamBuilder`.
* **Arsip Kode:**
  Seluruh implementasi modul pertemuan 1 tersimpan secara mandiri pada [Branch pertemuan-1](https://github.com/faruuuu-14/PMPL_025/tree/pertemuan-1).

### Pertemuan 2 — REST API Deep Dive: Dio, State Management, dan Pagination

Fokus pembahasan pada pertemuan ini adalah integrasi jaringan tingkat lanjut menggunakan paket `Dio`, penanganan status tampilan antarmuka secara komprehensif, serta penerapan teknik *Infinite Scroll*.

* **Endpoint API:**
  `https://jsonplaceholder.typicode.com/posts?_page={page}&_limit=10`
* **Arsitektur dan Struktur Berkas:**
  ```text
  lib/
  ├── main.dart             # Antarmuka Feed Berita, State Management, dan Infinite Scroll
  ├── models/
  │   └── post_model.dart   # Model Data PostModel dan Factory Constructor fromJson
  └── services/
      └── api_service.dart  # Konfigurasi Dio, BaseOptions, Interceptor, dan Error Handling
  ```
* **Komponen Teknis:**
  * **Dio Client Setup:** Konfigurasi `BaseOptions` terpusat (`baseUrl`, batas waktu `connectTimeout` dan `receiveTimeout` selama 10 detik) serta aktivasi `LogInterceptor` untuk inspeksi jaringan.
  * **Infinite Scroll Pagination:** Penggunaan `ScrollController` dengan pendeteksian ambang batas (200 piksel sebelum batas akhir) untuk memicu pemanggilan data halaman berikutnya secara otomatis.
  * **Pola UI State Management:**
    1. *Loading State:* Menampilkan indikator proses saat pertama kali memuat data.
    2. *Error State:* Menangkap `DioException` dan memetakan kode status menjadi pesan kesalahan yang informatif dengan opsi *Coba Lagi*.
    3. *Empty State:* Tampilan notifikasi ketika respons data kosong.
    4. *Success State:* Penyajian data dalam bentuk kartu daftar dengan dukungan fitur pembaruan *Pull to Refresh* (`RefreshIndicator`).

---

## Panduan Menjalankan Proyek

### Prasyarat Sistem
* Flutter SDK versi 3.47.4 (Channel stable) atau yang lebih baru
* Dart SDK versi 3.13.3 atau kompatibel
* Browser Google Chrome / Microsoft Edge

### Langkah Eksekusi

1. Unduh seluruh dependensi proyek:
   ```powershell
   flutter pub get
   ```

2. Jalankan aplikasi pada platform web dengan port terdefinisi:
   ```powershell
   flutter run -d chrome --web-port 8080
   ```
   *(Alternatif: Buka proyek pada Visual Studio Code dan tekan tombol **F5**)*.

3. Buka peramban web pada alamat:
   `http://localhost:8080`

---

## Spesifikasi Lingkungan Pengembangan

* **Framework:** Flutter 3.47.4 (Channel stable)
* **Bahasa Pemrograman:** Dart 3.13.3
* **Editor:** Visual Studio Code
* **Version Control:** Git & GitHub
