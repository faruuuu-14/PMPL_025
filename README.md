# Pemrograman Multi Platform Lanjutan (IT312)

Repositori ini berisi kumpulan tugas, praktikum, dan proyek perkuliahan untuk mata kuliah **Pemrograman Multi Platform Lanjutan (IT312)** menggunakan framework **Flutter** dan bahasa pemrograman **Dart**.

Repositori ini diperbarui secara berkala setiap pertemuan perkuliahan.

---

## 📚 Daftar Pertemuan & Progres Praktikum

| Pertemuan | Topik Materi | Status | Snapshot / Branch |
|---|---|:---:|---|
| **Pertemuan 1** | Review PMP Dasar, Asynchronous (Future, `async`/`await`), dan Dart Stream (`async*`/`yield`) | ✅ Selesai | [Branch `pertemuan-1`](https://github.com/faruuuu-14/PMPL_025/tree/pertemuan-1) / [Tag `pertemuan-1`](https://github.com/faruuuu-14/PMPL_025/releases/tag/pertemuan-1) |
| **Pertemuan 2** | REST API Deep Dive: Dio HTTP Client, UI State Management (Loading, Error, Empty, Success), & Infinite Scroll Pagination | ✅ Selesai | [Branch `main`](https://github.com/faruuuu-14/PMPL_025) / [Tag `pertemuan-2`](https://github.com/faruuuu-14/PMPL_025/releases/tag/pertemuan-2) |
| **Pertemuan 3** | *Upcoming* | ⏳ Segera | - |

---

## 📌 Rincian Tiap Pertemuan

### 🔹 Pertemuan 1 — Review PMP Dasar & Dart Async
* **Fokus:** Memahami perbedaan proses Synchronous (Blocking) vs Asynchronous (Non-Blocking) dan Stream realtime.
* **Fitur Utama:**
  * **Simulasi Synchronous:** Membuktikan bahwa pemanggilan `sleep()` memblokir *Main UI Thread* sehingga animasi spinner terhenti total selama 3 detik.
  * **Simulasi Asynchronous:** Membuktikan bahwa `await Future.delayed()` memproses tugas di latar belakang (*background*) sehingga UI dan animasi tetap berputar lancar.
  * **Stream Realtime:** Mengalirkan angka 1 hingga 5 bertahap tiap detik menggunakan generator `async*` dan `yield` yang didengarkan oleh widget `StreamBuilder`.
* **Arsip:** Kode utuh pertemuan 1 dapat dilihat di [branch `pertemuan-1`](https://github.com/faruuuu-14/PMPL_025/tree/pertemuan-1).

### 🔹 Pertemuan 2 — REST API Deep Dive: Dio, State & Pagination
* **Fokus:** Mengonsumsi REST API menggunakan client `Dio`, mengelola status UI secara menyeluruh, dan mengimplementasikan pagination *Infinite Scroll*.
* **API Endpoint:** `https://jsonplaceholder.typicode.com/posts?_page={page}&_limit=10`
* **Struktur Project:**
  ```text
  lib/
  ├── main.dart             # UI Feed Berita, Infinite Scroll & State Management
  ├── models/
  │   └── post_model.dart   # Model Data & JSON Parser (fromJson)
  └── services/
      └── api_service.dart  # Dio Setup, BaseOptions, Interceptor & Error Handling
  ```
* **Fitur Utama:**
  * **Dio Setup:** Konfigurasi terpusat `BaseOptions` (BaseUrl, connectTimeout 10s, receiveTimeout 10s) dan `LogInterceptor`.
  * **Infinite Scroll:** `ScrollController` mendeteksi scroll saat pengguna mendekati 200px dari dasar halaman untuk otomatis memuat halaman berita berikutnya.
  * **4 UI States:**
    1. *Loading State:* Indikator loading saat pertama kali memuat data.
    2. *Error State:* Tampilan ramah pengguna saat koneksi timeout / terputus beserta tombol *Coba Lagi*.
    3. *Empty State:* Tampilan ketika tidak ada data berita.
    4. *Success State:* Tampilan daftar berita dalam bentuk kartu dengan fitur *Pull to Refresh* (`RefreshIndicator`).

---

## 🚀 Panduan Menjalankan Proyek

### 1. Prasyarat
* Flutter SDK (Direkomendasikan versi `3.47.4` atau terbaru)
* Dart SDK (versi `3.13.3` atau kompatibel)
* Google Chrome atau browser web modern

### 2. Menjalankan Aplikasi
1. Buka terminal pada folder proyek:
   ```powershell
   flutter pub get
   ```
2. Jalankan aplikasi pada Google Chrome:
   ```powershell
   flutter run -d chrome --web-port 8080
   ```
   *(Atau tekan tombol **F5 / Play** langsung di VS Code)*.
3. Akses aplikasi melalui browser pada alamat:
   👉 **`http://localhost:8080`**

---

## 🛠️ Spesifikasi Lingkungan Pengembangan
* **Framework:** Flutter 3.47.4 (Channel stable)
* **Language:** Dart 3.13.3
* **Tools:** Visual Studio Code, Git, Google Chrome
