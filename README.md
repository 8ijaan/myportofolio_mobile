Nama: Ihsan Rafi Ahmad
NPM: 2506611326
Kelas: PBP F


# MyPortfolio Mobile

Aplikasi Flutter sederhana untuk portofolio (Tutorial 08 dan lanjutannya).

## Prasyarat

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart SDK `^3.13.7`, sudah termasuk di Flutter)
- [Git](https://git-scm.com/)
- Salah satu target untuk menjalankan aplikasi:
  - Android Studio dengan emulator Android, atau perangkat Android dengan USB debugging
  - Xcode dengan iOS Simulator (khusus macOS)
  - Google Chrome (untuk menjalankan versi web)
- Editor: VS Code atau Android Studio dengan plugin Flutter dan Dart

## Cara menjalankan di lokal

1. Clone repository:

   ```bash
   git clone https://github.com/8ijaan/myportofolio_mobile.git
   cd myportofolio_mobile
   ```

2. Pastikan Flutter terpasang dengan benar:

   ```bash
   flutter doctor
   ```

   Perbaiki semua tanda silang (✗) yang muncul sebelum lanjut.

3. Install dependency:

   ```bash
   flutter pub get
   ```

4. Lihat perangkat yang tersedia:

   ```bash
   flutter devices
   ```

5. Jalankan aplikasi:

   ```bash
   flutter run                # pilih perangkat secara interaktif
   flutter run -d chrome      # jalankan di browser
   flutter run -d <device-id> # jalankan di perangkat tertentu
   ```

   Saat aplikasi berjalan, tekan `r` untuk hot reload dan `R` untuk hot restart.

## Cek kualitas kode

```bash
flutter analyze
```

Hasil yang diharapkan: `No issues found!`

## Struktur utama

- `lib/main.dart`: titik masuk aplikasi (`MyApp`)
- `lib/menu.dart`: halaman utama (`MyHomePage`, `InfoCard`, `ItemCard`)

## Masalah umum

- `flutter: command not found`: tambahkan folder `flutter/bin` ke `PATH`, lalu buka terminal baru.
- Error dependency: jalankan `flutter clean` lalu `flutter pub get`.
- Emulator tidak terdeteksi: jalankan `flutter doctor` dan pastikan emulator sudah menyala.

