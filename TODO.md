# TODO Tugas: Flutter Portfolio (Lanjutan Tutorial 08)

Centang `[x]` setiap langkah yang sudah selesai. Kerjakan **berurutan** dari atas ke bawah.

> Istilah singkat
> - **Widget**: semua yang tampil di layar Flutter (teks, kartu, halaman).
> - **StatelessWidget**: widget yang tampilannya tidak berubah. Dipakai untuk halaman menu ini.
> - **SnackBar**: pesan kecil yang muncul di bawah layar.

---

## 0. Persiapan
- [ ] Buka terminal di folder proyek ini.
- [ ] Jalankan `flutter run`. Pastikan aplikasi Tutorial 08 masih bisa jalan.
- [ ] Siapkan datamu: **NPM**, **Nama lengkap**, **Kelas PBP** (contoh: PBP A).

## 1. Pisahkan halaman utama ke `lib/menu.dart`
Tujuan: `main.dart` hanya untuk memulai aplikasi. Halaman menu ada di file sendiri.

- [ ] Buat file baru `lib/menu.dart`.
- [ ] Pindahkan class `MyHomePage` dari `lib/main.dart` ke `lib/menu.dart`.
- [ ] Di bagian atas `lib/menu.dart`, tambahkan `import 'package:flutter/material.dart';`.
- [ ] Di bagian atas `lib/main.dart`, tambahkan `import 'package:myportofolio_mobile/menu.dart';`.
  Nama setelah `package:` harus sama dengan `name:` di `pubspec.yaml`.
- [ ] Di `main.dart`, hapus kode sisa yang tidak dipakai, misalnya counter.
- [ ] Jalankan ulang aplikasi. Harus tetap tampil tanpa error.
- [ ] Commit: `git add . && git commit -m "Pisahkan MyHomePage ke menu.dart"`

## 2. Ubah `MyHomePage` menjadi StatelessWidget
- [ ] Ubah `extends StatefulWidget` menjadi `extends StatelessWidget`.
- [ ] Hapus class `_MyHomePageState`. Pindahkan isi `build()` langsung ke dalam `MyHomePage`.
- [ ] Hapus variabel dan fungsi yang memakai `setState` (misalnya counter).
- [ ] Gunakan `const MyHomePage({super.key});` sebagai constructor.
- [ ] Commit: `git commit -am "Ubah MyHomePage menjadi StatelessWidget"`

## 3. Tampilkan 3 InfoCard (data dirimu sendiri)
- [ ] Di `menu.dart`, buat class `InfoCard` (StatelessWidget) dengan dua field: `title` dan `content`.
- [ ] Isi `build()`-nya dengan `Card` yang berisi `Column` berisi 2 widget `Text` (judul tebal dan isi).
- [ ] Di `MyHomePage`, taruh 3 `InfoCard` dalam satu `Row`:
  - [ ] `InfoCard(title: 'NPM', content: '<NPM-mu>')`
  - [ ] `InfoCard(title: 'Name', content: '<Nama lengkapmu>')`
  - [ ] `InfoCard(title: 'Class', content: '<Kelas PBP-mu>')`
- [ ] Pastikan **bukan** data sample Burhan.
- [ ] Commit: `git commit -am "Tambah InfoCard dengan identitas pemilik"`

## 4. Buat 3 tombol aksi (ItemCard) dengan warna berbeda
- [ ] Buat class `ItemHomepage` (data tombol) dengan field `name`, `icon`, `color`.
- [ ] Buat list berisi 3 item. Warna harus **berbeda dan kontras**:

  | Tombol | Icon | Warna |
  |---|---|---|
  | View Portfolio | `Icons.work` | `Colors.blue` |
  | Add Project | `Icons.add` | `Colors.green` |
  | Logout | `Icons.logout` | `Colors.red` |

- [ ] Buat widget `ItemCard` (StatelessWidget) yang menerima satu `ItemHomepage`.
- [ ] Susun `ItemCard` seperti ini:
  `Material(color: item.color)` lalu `InkWell(onTap: ...)` lalu `Column` berisi `Icon` dan `Text`.
- [ ] Tampilkan ketiganya memakai `GridView.count(crossAxisCount: 3, shrinkWrap: true, children: ...)`.
- [ ] Commit: `git commit -am "Tambah ItemCard dengan warna berbeda"`

## 5. Tampilkan SnackBar saat tombol ditekan
- [ ] Di `onTap` milik `InkWell`, isi dengan kode ini:

```dart
onTap: () {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text("You pressed the ${item.name} button!")),
    );
},
```

- [ ] Jalankan aplikasi. Tekan tiap tombol dan cek pesannya sesuai nama tombol.
- [ ] Commit: `git commit -am "Tambah SnackBar pada ItemCard"`

## 6. Cek kualitas kode
- [ ] Jalankan `flutter analyze` di root proyek.
- [ ] Perbaiki semua warning dan error sampai muncul **`No issues found!`**.
  Penyebab umum:
  - Lupa `const` pada constructor atau widget.
  - Import yang tidak dipakai.
  - `withOpacity` sudah deprecated, ganti dengan `withValues(alpha: ...)`.
- [ ] Commit: `git commit -am "Perbaiki hasil flutter analyze"`

## 7. Push ke GitHub
- [ ] Cek repo: `git remote -v`. Harus repo publik yang sama dengan Tutorial 08.
- [ ] Jalankan `git push origin main`.
- [ ] Buka halaman repo di GitHub. Pastikan semua commit muncul dan repo berstatus **Public**.
- [ ] Pastikan repo ini terpisah dari repo Django.

---

## Checklist akhir (sesuai soal)
- [ ] `menu.dart` ada di `lib/`, terpisah dari `main.dart`
- [ ] `MyHomePage` adalah StatelessWidget
- [ ] 3 InfoCard: NPM, Nama, Kelas (data sendiri)
- [ ] Minimal 3 ItemCard dengan icon dan teks
- [ ] Warna tiap ItemCard berbeda
- [ ] SnackBar muncul dengan pesan sesuai nama tombol
- [ ] `flutter analyze` hasilnya "No issues found!"
- [ ] Commit dilakukan bertahap dan sudah di-push
