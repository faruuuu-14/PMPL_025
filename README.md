# PMP Pertemuan 1 — Demo Sync vs Async (Flutter)

Template praktikum. Project ini dibuat di Linux, tapi **100% bisa jalan di Windows** tanpa penyesuaian khusus — yang penting Flutter SDK + Android SDK sudah terinstall.

> Yang kamu clone = template. Yang kamu kerjakan = hanya `lib/main.dart`.
> File solusi dosen (`lib/main_test.dart`) sengaja tidak ikut ke repo (masuk `.gitignore`).

## Yang kamu dapat vs yang kamu kerjakan

| File | Keterangan |
|---|---|
| `lib/main.dart` | **Template yang WAJIB kamu lengkapi.** Ada 3 bagian kosong: `_runSyncProcess`, `_runAsyncProcess`, `_generateStreamData`. |
| `lib/main_test.dart` | Solusi/contoh dosen. **Tidak ada di repo**, jadi jangan dicari setelah clone. |
| File lain (`android/`, `windows/`, `pubspec.yaml`, dll.) | **Jangan diubah/dihapus.** Sudah lintas-platform. |

## Prasyarat (dianggap sudah aman)

- Flutter SDK terinstall (`flutter --version` jalan di PowerShell/CMD)
- Android SDK + Android Studio terinstall
- Git terinstall
- Akun GitHub

Cek cepat di PowerShell:

```powershell
flutter --version
flutter doctor
git --version
```

Kalau `flutter doctor` ada tanda `!` atau `X` di bagian Android toolchain / lisensi, bereskan dulu (lihat Langkah 3).

## Langkah 1 — Clone repo template

Buka PowerShell, masuk ke folder kerja (misal `Documents`), lalu:

```powershell
git clone https://github.com/terserah/pmp_01.git
cd pmp_01
```

Catatan:

- Project dibuat di Linux — **tidak masalah**. Warning soal `LF will be replaced by CRLF` boleh diabaikan.
- Tidak perlu install Dart, Gradle, atau library manual. Semua ikut Flutter SDK + langkah `flutter pub get` di bawah.
- Folder `windows/`, `linux/`, `android/` memang sengaja ikut ke-clone. Jangan dihapus.

## Langkah 2 — Install dependency (wajib sekali tiap habis clone)

```powershell
flutter pub get
```

Perintah ini membaca `pubspec.yaml` + `pubspec.lock` dan mengunduh package (`cupertino_icons`, `flutter_lints`, dll.) ke folder `.dart_tool/` lokal. Tanpa ini project tidak bisa di-run.

## Langkah 3 — Bereskan lisensi Android (sekali saja)

```powershell
flutter doctor --android-licenses
# tekan y / Enter untuk semua lisensi sampai selesai
flutter doctor
```

Target akhir: bagian `Flutter`, `Windows Version`, `Android toolchain`, dan `Connected device` (atau `Chrome`) centang hijau. Bagian `Visual Studio` hanya wajib kalau mau run sebagai aplikasi Windows desktop — kalau cukup run di Chrome/HP Android, boleh diabaikan.

Cek device yang tersedia:

```powershell
flutter devices
```

## Langkah 4 — Jalankan template (pastikan jalan SEBELUM mengerjakan)

Pilih **salah satu** yang paling gampang:

```powershell
# Paling gampang, tanpa emulator:
flutter run -d chrome

# Atau sebagai aplikasi Windows:
flutter run -d windows

# Atau ke HP/emulator Android (buka dulu emulatornya di Android Studio / colok HP + USB debugging):
flutter run
```

Yang harus tampil: halaman **"Demo: Sync vs Async Flutter"** dengan spinner + 3 card (Sync merah, Async hijau, Stream biru). Tombolnya belum ngapa-ngapain — itu normal, karena memang tugasmu mengisinya.

Kalau error build pertama kali, coba:

```powershell
flutter clean
flutter pub get
flutter run -d chrome
```

## Langkah 5 — Kerjakan tugas

1. Buka folder project di VS Code / Android Studio.
2. Edit **hanya** `lib/main.dart`, lengkapi 3 fungsi yang masih kosong:
   - `_runSyncProcess()`
   - `_runAsyncProcess()`
   - `_generateStreamData()`
3. Ikuti instruksi dosen/asisten untuk isi tiap fungsi.
4. Simpan, lalu ulangi `flutter run -d chrome` untuk testing. Perhatikan spinner: tombol Sync harus bikin UI freeze, tombol Async harus tetap smooth.
5. Opsional cek kode rapi:

```powershell
flutter analyze
```

## Langkah 6 — Push ke repository masing-masing (wajib)

Jangan push ke repo template. Alurnya: clone template → putuskan remote → sambungkan ke repo pribadimu → push.

```powershell
# 1. Pastikan kamu di dalam folder project dan pekerjaanmu sudah disimpan
git status

# 2. Set identitas git (sekali saja per laptop)
git config --global user.name "Nama Kamu"
git config --global user.email "nim@student.ac.id"

# 3. Simpan pekerjaanmu
git add lib/main.dart
git commit -m "Selesaikan tugas sync async - NIM Kamu"

# 4. Buat repository BARU dan KOSONG di GitHub milikmu
#    (jangan centang Add README / .gitignore / license), misal: pmp_01_NIM

# 5. Putuskan sambungan ke repo template, sambungkan ke repo milikmu
git remote -v
git remote remove origin
git remote add origin https://github.com/USERNAME-KAMU/pmp_01_NIM.git

# 6. Push
git branch -M main
git push -u origin main
```

Tugas berikutnya cukup:

```powershell
git add lib/main.dart
git commit -m "Pesan perubahan"
git push
```

> Login GitHub via browser akan meminta otorisasi. Kalau diminta password di terminal dan gagal, pakai **Personal Access Token (classic)** sebagai password, atau login via `gh auth login` / Git Credential Manager.

## Langkah 7 — Kumpulkan

Kumpulkan **link repo GitHub milikmu** (misal `https://github.com/USERNAME-KAMU/pmp_01_NIM`) sesuai instruksi dosen. Pastikan repo **public** (atau private + dosen di-invite) dan commit terakhir berisi `lib/main.dart` yang sudah dilengkapi.

## Troubleshooting Windows

| Gejala | Solusi |
|---|---|
| `flutter` tidak dikenal | Tutup-buka ulang PowerShell setelah install Flutter; pastikan folder `flutter\bin` ada di PATH. |
| `Android license status unknown` | Jalankan `flutter doctor --android-licenses`, terima semua, ulangi `flutter doctor`. |
| `No connected devices` | Untuk Chrome: install Chrome. Untuk Android: buka Device Manager di Android Studio dan jalankan emulator, atau colok HP + aktifkan USB debugging. |
| Error Gradle / `Could not resolve` saat `flutter run` | `flutter clean` → `flutter pub get` → `flutter run` lagi. Pastikan internet tidak diblokir proxy kampus. |
| Path error / build gagal di OneDrive | Pindahkan clone ke path pendek tanpa spasi, misal `C:\src\pmp_01`, jangan di dalam OneDrive. |
| Prompt `LF will be replaced by CRLF` | Abaikan, normal untuk project Linux → Windows. |
| `flutter test` bilang tidak ada test | Normal. Folder `test/` memang dikosongkan di template. |
| Tidak bisa push (403 / authentication failed) | Repo pribadimu belum dibuat / URL remote salah (`git remote -v` untuk cek), atau perlu login ulang + PAT. |

## FAQ cepat

- **Perlu install ulang SDK/library versi Linux?** Tidak. Cukup `flutter pub get`. Versi Flutter yang dipakai dosen: Flutter `3.47.4` / Dart `3.13.3` — kalau versimu sedikit lebih baru umumnya tetap jalan, asal `flutter doctor` hijau.
- **Perlu `flutter create` ulang di Windows?** Tidak. Folder platform (`android/`, `windows/`, dll.) sudah ada.
- **Bolehkah edit file selain `lib/main.dart`?** Jangan, kecuali disuruh dosen. Biar nilai fokus ke logika sync/async/stream.
