# Kelompok 9 - Resep makanan Syaben
Aplikasi resep makanan yang dirancang untuk membantu pengguna menemukan,mempelajari, dan mengelola resep masakan secara mudah dan interaktif.

Tugas Besar: Dasar Pemrograman Perangkat Bergerak (DPPB)  
Universitas: Telkom University  
Semester: 3

---

## Team Members

| Nama | NIM | Role / Fitur Tanggung Jawab |
|------|-----|-----------------------------|
| Revan Syaikal Labib | 607012400009 | Rekomendasi Resep, Video Tutorial, Planner, Kelola Planner |
| Benrydes Manulang | 607012400021| Pencarian Resep, Hasil Pencarian, Detail Resep, Kelola Resep |
| Syahrul Mubarrok | 607012400037 | Login, Registrasi, Home, Kelola User/Autentikasi |

---

## Features Overview

### 1. Revan Syaikal Labib (607012400009)
Scope: Recipe Recommendation & Planner System

- Rekomendasi Resep:
Menampilkan rekomendasi berdasarkan kategori, popularitas, atau bahan tertentu menggunakan ListView dan card widget.

-Video Tutorial:
Halaman pemutar video resep lengkap dengan kontrol play/pause, serta alert jika terjadi error pemutaran.

-Planner (Jadwal Masak):
Form pemilihan hari masak dengan date picker, penyimpanan jadwal secara lokal, dan validasi input.

-Kelola Planner:
Menampilkan daftar jadwal masak, fitur edit, dan hapus jadwal menggunakan AlertDialog konfirmasi.
### 2. Benrydes Manulang (607012400021)

Scope: Recipe Search & Management

-Pencarian Resep:
Search bar real-time filtering berdasarkan nama resep, bahan, atau kategori.

-Hasil Pencarian:
Menampilkan hasil dalam GridView, lengkap dengan dialog jika hasil tidak ditemukan.

-Detail Resep:
Halaman detail berisi gambar, bahan, langkah memasak, waktu masak, serta tombol aksi seperti tambah ke planner.

-Kelola Resep (CRUD):
Fitur tambah resep, edit resep, lihat semua resep, dan hapus resep dengan dialog konfirmasi
### 3. Syahrul Mubarrok (607012400037)

Scope: Authentication & Home System

-Login:
Autentikasi menggunakan API (POST), validasi input, alert login gagal/berhasil, dan navigasi ke Home.

-Registrasi:
Form pendaftaran, validasi email & password, dan penyimpanan akun ke session lokal.

-Home:
Tampilan utama berisi kategori, rekomendasi, dan navigasi utama menggunakan BottomNavigationBar.

-Kelola User / Autentikasi:
Menyimpan status login, fitur logout dengan alert konfirmasi, serta proteksi halaman jika user belum login

---

## Project Summary

| Metric | Count |
|--------|-------|
| Total Screens | 10+ screens |
| Total Alerts | 5 types (Error, Success, Confirm, Input, Info) |
| Data Source | Local Session + JSON Data |
| State Management | Provider (MultiProvider) |
| Navigation | Push, PushReplacement, Pop, BottomNavBar |

---

## Tech Stack

-Framework: Flutter 3.0+
-Language: Dart
-State Management: Provider
-Utilities:
 -SharedPreferences
 -Intl (Formatting)
 -Google Fonts
---

## Installation & Setup

### Prerequisites
Pastikan sudah terinstall:
- Flutter SDK
- VS Code / Android Studio

### Installation Steps

1.Clone repository
git clone https://github.com/username/resep-makanan-syaben.git

2. Masuk folder project
cd resep-makanan-syaben

3.Install dependencies
flutter pub get

4.Run aplikasi
flutter run
---

## Testing Credentials

Pada fitur autentikasi, pengguna dapat membuat akun baru langsung melalui halaman Registrasi. Data akan disimpan secara lokal sebagai simulasi login.
---

## Features Checklist (Syarat Teknis)

- [x] Widget & Layout: Column, Row, Stack, GridView, ListView
- [x] Alert/Dialog: Login gagal, hapus resep, hapus planner, input invalid
- [x] Akses API External: Planner, User Session, Favorite
- [x] HTTP Methods: Login, Register, Tambah/Edit Resep
- [x] ListView Data API: Push, Replacement, Bottom Nav

---

## License

Alevale Mahakarya - Dasar Pemrograman Perangkat Bergerak  
Telkom University © 2025

---

## Contact

Kelompok - Alevale App

| Anggota | NIM |
|---------|-----|
| Revan Syaikal Labib | 607012400009 |
| Benrydes Manulang | 607012400021 |
| Syahrul Mubarrok | 607012400037 |

Repository: https://github.com/syahrulmubarrok29/resep-makanan-syaben.git  
Last Updated: 11 Desember 2025  
Version: 1.0.0

---

## Acknowledgments

- Dosen Pengampu: [Lukmanul Hakim Firdaus]
- Mata Kuliah: Dasar Pemrograman Perangkat Bergerak
- Institusi: Telkom University
- Semester: 3 / Tahun Akademik 2025/2026
