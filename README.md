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

### ASSIGNMENT 7: Reflective Question

1. Explain what a widget tree is in Flutter and how parent-child relationships work between widgets.

Widget tree adalah struktur berbentuk pohon dari semua widget di aplikasi. Setiap widget kecuali root punya satu parent yang membungkusnya. Widget bisa punya child (satu, lewat child:) atau beberapa children (lewat children: [...]).

2. List all the widgets you used in this project and explain each of their functions.

MyApp (StatelessWidget) - Widget root aplikasi. Fungsinya membangun MaterialApp dan menjadi titik awal seluruh aplikasi.
MaterialApp - Membungkus aplikasi dengan Material Design: mengatur judul, tema (ThemeData), dan halaman awal (home).
ThemeData - Mendefinisikan tema global aplikasi, seperti skema warna (colorScheme) dan pengaturan useMaterial3.
MyHomePage (StatelessWidget) - Halaman utama aplikasi. Fungsinya menyusun tampilan halaman: app bar, kartu info, sapaan, dan grid tombol.
Scaffold - Kerangka dasar halaman Material. Fungsinya menyediakan struktur appBar dan body.
AppBar - Bilah judul di bagian atas halaman. Fungsinya menampilkan judul aplikasi dengan warna latar dari tema.
Padding - Memberi jarak (ruang kosong) di sekitar widget anak agar tampilan tidak menempel ke tepi.
Column - Menyusun widget anak secara vertikal (atas ke bawah), misalnya info card, teks sapaan, dan grid.
Row - Menyusun widget anak secara horizontal. Fungsinya menampilkan tiga InfoCard berdampingan.
Center - Memposisikan widget anak di tengah, misalnya teks sapaan dan isi kartu.
SizedBox - Memberi ukuran atau jarak tetap antar widget (spasi vertikal/horizontal).
Text - Menampilkan teks, seperti judul, NPM, nama, kelas, dan nama tombol.
TextStyle - Mengatur gaya teks: ukuran, ketebalan, dan warna font.
GridView.count - Menampilkan widget dalam bentuk grid dengan jumlah kolom tetap. Fungsinya menampilkan deretan tombol aksi (ItemCard).
InfoCard (StatelessWidget) - Widget kustom untuk menampilkan satu kartu informasi (judul dan isi), lebar kartu diatur dengan MediaQuery.
Card - Widget Material berbentuk kartu dengan bayangan dan sudut membulat. Fungsinya membungkus konten InfoCard.
Container - Kotak serbaguna untuk mengatur ukuran, padding, dan dekorasi pada anaknya.
ItemCard (StatelessWidget) - Widget kustom untuk satu tombol aksi di grid. Fungsinya menampilkan ikon dan nama, serta merespons saat ditekan.
Material - Menyediakan permukaan Material dengan warna latar berbeda untuk tiap tombol, sekaligus tempat efek ripple muncul.
InkWell - Mendeteksi sentuhan (tap) dan memberi efek ripple. Fungsinya memicu aksi saat tombol ditekan.
Icon - Menampilkan ikon pada tiap tombol aksi.
SnackBar - Pesan singkat di bagian bawah layar. Fungsinya menampilkan "Kamu telah menekan tombol ..." lewat ScaffoldMessenger saat tombol ditekan.

3. What is the purpose of the MaterialApp widget? Explain why this widget is commonly used as the root widget in Flutter applications.

Widget ini menyiapkan hal-hal yang dibutuhkan hampir semua halaman:

- Tema lewat theme. Di proyekmu: ColorScheme.fromSeed(seedColor: Colors.indigo, ...). Itu sebabnya AppBar bisa memakai Theme.of(context).colorScheme.primary (baris 28).
- Halaman awal lewat home: MyHomePage().
- Navigator untuk berpindah halaman (nanti dipakai saat tombol View Projects membuka halaman baru).
- Judul aplikasi lewat title.
- Infrastruktur Material Design: ScaffoldMessenger (tanpa ini ScaffoldMessenger.of(context) di baris 132 akan error), arah teks, dan media query (dipakai MediaQuery.of(context) di baris 95).

Karena semua itu dibutuhkan di seluruh aplikasi, MaterialApp ditaruh paling atas supaya semua widget di bawahnya bisa mengaksesnya.

4. Explain the difference between StatelessWidget and StatefulWidget. When should you choose StatelessWidget, and when is StatefulWidget necessary?

StatelessWidget adalah widget yang bersifat statis. Artinya setelah widget ini dibangun, tampilannya tidak bisa berubah sendiri, meskipun ada perubahan data, tombol di klik atau variabel di dalamnya dimodifikasi. Stateless Widget digunakan ketika tampilan widget hanya bergantung pada konfigurasi awal dan tidak akan pernah berubah

StatefulWidget adalah widget yang dinamis. Widget ini bisa melacak perubahan data dan memperbarui tampilannya secara otomatis di layar setiap kali ada interaksi/perubahan data. Widget ini digunakan ketika UI perlu meresponse aksi user.


5. What is BuildContext and why is it crucial in Flutter? How is it used inside the build method?

BuildContext adalah sebuah objek yang merepresentasikan lokasi sebuah widget di dalam struktur widget tree (pohon widget). Setiap widget memiliki BuildContextnya sendiri, yang bertindak sebagai penghubung antara widget tersebut dengan posisi hierarkinya di aplikasi.

6. Explain the concept of hot reload in Flutter and how it differs from hot restart. When can you not rely on hot reload and must instead perform a hot restart or full restart?

Hot Reload: Memuat ulang file kode sumber yang baru saja diubah ke dalam Dart Virtual Machine yang sedang berjalan. Keunggulannya adalah mempertahankan state aplikasi saat ini.
Hot Restart: Menghapus state aplikasi yang sedang berjalan dan memulai ulang aplikasi dari fungsi main(). Aplikasi akan kembali ke kondisi awal, tetapi proses kompilasi native tidak diulang dari awal sehingga tetap relatif cepat.

Hot reload terkadang tidak dapat mendeteksi perubahan struktur tertentu atau gagal memperbarui state dengan benar. Sehingga hot restart atau full restart perlu dilakukan.



