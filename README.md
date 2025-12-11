# Kelompok 9 - Resep makanan Syaben
Aplikasi resep makanan yang dirancang untuk membantu pengguna menemukan,mempelajari, dan mengelola resep masakan secara mudah dan interaktif.

*Tugas Besar:* Dasar Pemrograman Perangkat Bergerak (DPPB)  
*Universitas:* Telkom University  
*Semester:* 3

---

## Team Members

| Nama | NIM | Role / Fitur Tanggung Jawab |
|------|-----|-----------------------------|
| *Revan Syaikal Labib* | 607012400009 | Rekomendasi Resep, Video Tutorial, Planner, Kelola Planner |
| *Benrydes Manulang* | 607012400021| Pencarian Resep, Hasil Pencarian, Detail Resep, Kelola Resep |
| *Syahrul Mubarrok* | 607012400037 | Login, Registrasi, Home, Kelola User/Autentikasi |

---

## Features Overview

### 1. Revan Syaikal Labib (607012400009)
*Scope: Product Discovery & Authentication*
- *Login:* Otentikasi user menggunakan API Reqres.in (POST) dengan validasi alert dialog.
- *Katalog Produk:* Menampilkan list produk dari FakeStoreAPI (GET) dengan GridView, Search Bar, dan Filter Kategori (ListView).
- *Detail Produk:* Halaman informasi detail produk (Gambar, Harga, Deskripsi).
- *Wishlist:* Fitur menyimpan produk favorit (Session based).

### 2. Hanna Tri Yuniawati (607012400074)
*Scope: Transaction Flow & User Profile*
- *Profile:* Halaman informasi akun pengguna, Edit Data Diri, dan Navigasi.
- *Tambah ke Keranjang:* Logika memasukkan item dari detail produk ke cart.
- *Kelola Keranjang:* Halaman keranjang dengan fitur Select All, Hapus Item (Alert), dan Update Quantity.
- *Checkout:* Form pengiriman, pemilihan metode pembayaran, dan ringkasan belanja (API POST Simulation).

### 3. Sannatthariq Annizemi Achmed Deedat (607012400087)
*Scope: Payment & Logistics*
- *Forgot Password:* Halaman UI untuk reset password.
- *Pembayaran:* Simulasi gateway pembayaran dengan validasi dan Feedback Dialog Sukses.
- *Lihat Status Pesanan:* Halaman status pesanan aktif (Sedang Dikemas / Dikirim).
- *Lacak Pengiriman:* Visualisasi Timeline perjalanan paket dari gudang ke pembeli.

### 4. Abdul Fikri Husaini (607012400104)
*Scope: User Engagement*
- *Register:* Pendaftaran akun baru dengan penyimpanan session lokal.
- *Lihat Riwayat Pesanan:* Filter history pesanan yang telah selesai.
- *Review Produk:* Fitur rating bintang dan ulasan (muncul setelah barang diterima).
- *Hubungi Admin / CS:* Halaman bantuan dengan direct link ke WhatsApp/Email.

---

## Project Summary

| Metric | Count |
|--------|-------|
| *Total Screens* | 12+ screens |
| *Total Alerts* | 5 types (Error, Success, Confirm, Input, Info) |
| *Data Source* | 3 Public APIs (FakeStore, Reqres, JsonPlaceholder) |
| *State Management* | Provider (MultiProvider) |
| *Navigation* | Push, PushReplacement, Pop, BottomNavBar |

---

## Tech Stack

- *Framework:* Flutter 3.0+
- *Language:* Dart
- *State Management:* Provider
- *Networking:* HTTP Package
- *External APIs:*
  - fakestoreapi.com (Products & Categories)
  - reqres.in (Auth)
  - jsonplaceholder.typicode.com (Order Simulation)
- *Utilities:* Intl (Currency Formatting), Url Launcher, Google Fonts

---

## Installation & Setup

### Prerequisites
Pastikan sudah terinstall:
- Flutter SDK
- VS Code / Android Studio

### Installation Steps

1. Clone repository
   git clone https://github.com/username/alevale-ecommerce.git

2. Masuk ke folder project
   cd alevale-ecommerce

3. Install dependencies
   flutter pub get

4. Run application
   flutter run

---

## Testing Credentials

Untuk pengujian fitur Login (jika menggunakan API Reqres):
Anda bisa melakukan Register akun baru di dalam aplikasi untuk simulasi full flow.

---

## Features Checklist (Syarat Teknis)

- [x] *Widget & Layout:* Menerapkan Column, Row, Stack, GridView, ListView, dan BottomNavigationBar.
- [x] *Alert/Dialog:* Menerapkan AlertDialog pada Login Gagal, Hapus Keranjang, Checkout Sukses, dan Input Review.
- [x] *Akses API External:* Menggunakan 3 API publik berbeda (FakeStore, Reqres, JsonPlaceholder).
- [x] *HTTP Methods:* Mencakup GET (Produk/Kategori) dan POST (Login/Checkout).
- [x] *ListView Data API:* Kategori produk ditampilkan menggunakan ListView horizontal.

---

## License

Alevale Mahakarya - Dasar Pemrograman Perangkat Bergerak  
Telkom University © 2025

---

## Contact

*Kelompok - Alevale App*

| Anggota | NIM |
|---------|-----|
| Ludfiana Putri Damirahadi | 607012400091 |
| Hanna Tri Yuniawati | 607012400074 |
| Sannatthariq Annizemi Achmed Deedat | 607012400087 |
| Abdul Fikri Husaini | 607012400104 |

*Repository:* https://github.com/fix141/alevale-mahakarya  
*Last Updated:* 11 Desember 2025  
*Version:* 1.0.0

---

## Acknowledgments

- Dosen Pengampu: [Lukmanul Hakim Firdaus]
- Mata Kuliah: Dasar Pemrograman Perangkat Bergerak
- Institusi: Telkom University
- Semester: 3 / Tahun Akademik 2025/2026
