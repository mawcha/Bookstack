# Bookstack

Dokumentasi proyek mata kuliah **Komunikasi Data dan Jaringan Komputer (KDJK)** untuk instalasi, konfigurasi, dan deployment BookStack pada VPS agar dapat diakses melalui internet.

## Daftar Isi

1. [Anggota Kelompok](#1-anggota-kelompok)
2. [Deskripsi Proyek](#2-deskripsi-proyek)
3. [Teknologi yang Digunakan](#3-teknologi-yang-digunakan)
4. [Arsitektur Sistem](#4-arsitektur-sistem)
5. [Informasi Deployment](#5-informasi-deployment)
6. [Persiapan VPS](#6-persiapan-vps)
7. [Instalasi BookStack](#7-instalasi-bookstack)
8. [Cara Mengakses BookStack](#8-cara-mengakses-bookstack)
9. [Keamanan dan Pemeliharaan](#9-keamanan-dan-pemeliharaan)
10. [Dokumentasi dan Referensi](#10-dokumentasi-dan-referensi)

---

## 15. Anggota Kelompok

| No. | Nama | NIM |
|---|---|---|
| 1 | Safira Ayu Damayanti | M0403241010 |
| 2 | Asty Athetha Loethan | M0403241089 |
| 3 | Isyana Ajeng Khairani | M0403241096 |
| 4 | Deswita Diandra | M0403241127 |
| 5 | Adzkia Muftia Rahman | M0403241153 |

---

## 2. Deskripsi Proyek

BookStack merupakan aplikasi dokumentasi berbasis web yang dapat digunakan untuk menyimpan, menyusun, dan mengelola informasi secara terstruktur. Konten di BookStack disusun menggunakan hierarki buku (*books*), bab (*chapters*), dan halaman (*pages*).

Dalam proyek ini, BookStack di-deploy pada Virtual Private Server (VPS) agar aplikasi dapat diakses melalui internet menggunakan domain sendiri.

Aplikasi dijalankan pada Ubuntu Server 24.04 dengan Apache sebagai web server, MySQL sebagai database, serta PHP sebagai lingkungan runtime aplikasi. Domain diarahkan ke alamat IP publik VPS dan diamankan menggunakan sertifikat HTTPS dari Let's Encrypt.

**Aplikasi:** https://kelompoksatu.cloud

## 3. Teknologi yang Digunakan

| Teknologi | Fungsi |
|---|---|
| Rumahweb VPS | Menyediakan server untuk deployment aplikasi |
| Ubuntu Server 24.04 | Sistem operasi server |
| Apache HTTP Server | Menerima dan melayani permintaan HTTP/HTTPS |
| MySQL | Menyimpan data aplikasi |
| PHP | Menjalankan aplikasi BookStack |
| BookStack | Aplikasi dokumentasi berbasis web |
| DNS | Mengarahkan domain ke IP publik VPS |
| Let's Encrypt | Menyediakan sertifikat TLS untuk HTTPS |
| Certbot | Membantu memperoleh dan memperpanjang sertifikat |
| GitHub | Menyimpan dokumentasi proyek |

## 4. Arsitektur Sistem

Alur akses aplikasi:

```text
Pengguna
   |
   | HTTPS
   v
kelompoksatu.cloud
   |
   | DNS A Record
   v
IP Publik VPS
   |
   v
Apache Web Server
   |
   v
BookStack (PHP)
   |
   v
MySQL Database
```

Penjelasan:

1. Pengguna membuka domain melalui browser.
2. DNS menerjemahkan domain menjadi alamat IP publik VPS.
3. Apache menerima koneksi HTTP atau HTTPS.
4. Apache meneruskan permintaan ke aplikasi BookStack.
5. BookStack memproses permintaan dan berinteraksi dengan database MySQL jika diperlukan.
6. Hasil pemrosesan dikirim kembali kepada pengguna melalui browser.

## 5. Informasi Deployment

| Komponen | Konfigurasi |
|---|---|
| Provider VPS | Rumahweb |
| Sistem operasi | Ubuntu Server 24.04 |
| Domain | `kelompoksatu.cloud` |
| IP publik IPv4 | `202.10.40.194` |
| Web server | Apache |
| Database | MySQL |
| Aplikasi | BookStack |

## 6. Persiapan VPS

### 6.1 Mengakses VPS

VPS dapat diakses melalui SSH menggunakan terminal. Pada Windows PowerShell, jalankan:

```bash
ssh root@202.10.40.194
```

Masukkan password root ketika diminta. Untuk penggunaan jangka panjang, disarankan menggunakan SSH key dan membatasi akses root secara langsung setelah akses alternatif yang aman tersedia.

### 6.2 Memperbarui sistem

Setelah berhasil masuk ke server, perbarui daftar paket dan paket yang terpasang:

```bash
apt update
apt upgrade -y
```

### 6.3 Memeriksa layanan

Status Apache dapat diperiksa dengan:

```bash
systemctl is-active apache2
```

Jika Apache berjalan dengan normal, perintah akan menghasilkan:

```text
active
```

Perintah pemeriksaan layanan lain:

```bash
systemctl status ssh
systemctl status apache2
```

## 7. Instalasi BookStack

Instalasi dilakukan menggunakan skrip instalasi Ubuntu 24.04 dari repositori pengelola BookStack.

### 7.1 Mengunduh skrip instalasi

```bash
wget https://codeberg.org/bookstack/devops/raw/branch/main/scripts/installation-ubuntu-24.04.sh
```

### 7.2 Memberikan izin eksekusi

```bash
chmod +x installation-ubuntu-24.04.sh
```

### 7.3 Menjalankan instalasi

Jalankan skrip dengan domain atau alamat yang digunakan untuk mengakses aplikasi:

```bash
./installation-ubuntu-24.04.sh 202.10.40.194
```

Skrip instalasi mengatur komponen yang dibutuhkan BookStack, termasuk Apache, MySQL, PHP, dependensi aplikasi, dan konfigurasi web server.

## 8. Cara Mengakses BookStack

1. Buka https://kelompoksatu.cloud.
2. Masukkan email atau username dan password akun yang telah dikonfigurasi.
3. Setelah berhasil masuk, pengguna dapat mengakses konten sesuai izin akun.
4. Untuk membuat dokumentasi, gunakan struktur Books, Chapters, dan Pages.

Kredensial administrator tidak dicantumkan dalam README ini. Gunakan akun yang telah diamankan dan jangan membagikan password melalui repository publik.

## 9. Keamanan dan Pemeliharaan

Hal-hal yang perlu diperhatikan setelah deployment:

- Perbarui Ubuntu dan komponen aplikasi secara berkala.
- Gunakan password administrator yang kuat.
- Batasi akses SSH dan akses root sesuai kebutuhan.
- Pastikan hanya port layanan yang diperlukan yang terbuka ke internet.
- Buat backup database dan data BookStack secara berkala.
- Simpan kredensial dan file rahasia di luar repository.
- Pantau masa berlaku sertifikat dan pastikan auto-renew berjalan.
- Jangan mengubah konfigurasi Apache, database, atau aplikasi tanpa backup apabila perubahan berisiko mengganggu layanan.

## 10. Dokumentasi dan Referensi

- [BookStack — Website Resmi](https://www.bookstackapp.com/)
- [BookStack — Dokumentasi Resmi](https://www.bookstackapp.com/docs/)
- [BookStack — Repositori Sumber](https://github.com/BookStackApp/BookStack)
- [BookStack DevOps Scripts](https://codeberg.org/bookstack/devops)
- [Ubuntu Server Documentation](https://documentation.ubuntu.com/server/)

**Mata Kuliah:** Komunikasi Data dan Jaringan Komputer (KDJK)  
**Platform:** BookStack  
**Deployment:** Rumahweb VPS — Ubuntu Server 24.04  
**Domain:** https://kelompoksatu.cloud
