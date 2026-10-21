# Bookstack

## Daftar Isi

1. [Anggota Kelompok](#1-anggota-kelompok)
2. [Deskripsi Proyek](#2-deskripsi-proyek)
3. [Teknologi yang Digunakan](#3-teknologi-yang-digunakan)
4. [Arsitektur Sistem](#4-arsitektur-sistem)
5. [Informasi Deployment](#5-informasi-deployment)
6. [Persiapan VPS](#6-persiapan-vps)
7. [Instalasi BookStack](#7-instalasi-bookstack)
8. [Cara Penggunaan BookStack](#8-cara-penggunaan-bookstack)
9. [Cara Mengakses BookStack](#8-cara-mengakses-bookstack)
10. [Keamanan dan Pemeliharaan](#9-keamanan-dan-pemeliharaan)
11. [Dokumentasi dan Referensi](#10-dokumentasi-dan-referensi)

---

## 1. Anggota Kelompok

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

---

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

---

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

---

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

---

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
---

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

---

## 8. Cara Penggunaan BookStack

### 8.1 Login ke BookStack

Buka URL BookStack melalui browser, kemudian masukkan username dan password akun yang telah diberikan oleh administrator.

<img width="1600" height="849" alt="WhatsApp Image 2026-10-20 at 3 50 35 PM" src="https://github.com/user-attachments/assets/b853e9fb-e12a-4110-b2da-b5b08783dce5" />


### 8.2 Tampilan Setelah Login

Setelah berhasil login, pengguna akan diarahkan ke halaman utama BookStack. Pada halaman ini, pengguna dapat melihat dokumentasi yang tersedia serta mengakses fitur untuk membuat dan mengelola konten, sesuai dengan hak akses akun.

<img width="1861" height="967" alt="image" src="https://github.com/user-attachments/assets/60d02c77-cb19-419d-9230-0fc910c9e1f9" />

### 8.3 Membuat Book

Book digunakan sebagai wadah utama untuk mengelompokkan dokumentasi berdasarkan topik tertentu. Misalnya, pengguna dapat membuat satu Book untuk dokumentasi praktikum, panduan aplikasi, atau materi perkuliahan.

Langkah-langkah:
1. Buka halaman utama BookStack.
2. Pilih menu atau tombol untuk membuat Book baru.
3. Masukkan nama Book dan informasi pendukung jika diperlukan.
4. Simpan Book yang telah dibuat.

<img width="1920" height="1080" alt="Tulis isi dokumentasi (2)" src="https://github.com/user-attachments/assets/0282e65a-c44d-4b48-abc6-eb4c7765e186" />


### 8.4 Membuat Chapter

Chapter digunakan untuk membagi isi Book menjadi beberapa bagian berdasarkan subtopik agar dokumentasi lebih terstruktur.

Langkah-langkah:
1. Buka Book yang ingin dikelola.
2. Pilih opsi untuk menambahkan Chapter.
3. Masukkan nama Chapter.
4. Simpan Chapter.

<img width="1920" height="1080" alt="Tulis isi dokumentasi" src="https://github.com/user-attachments/assets/fe446c28-4f17-421d-ba94-4894b6b80187" />

### 8.5 Membuat Page Baru

Page merupakan tempat untuk menulis isi dokumentasi secara lebih rinci. Page dapat berisi teks, gambar, tabel, tautan, dan elemen pendukung lainnya.

Langkah-langkah:
1. Buka Book dan Chapter yang sesuai.
2. Pilih opsi untuk membuat Page baru.
3. Masukkan judul Page.
4. Tulis isi dokumentasi menggunakan editor yang tersedia.
5. Simpan atau terbitkan Page sesuai opsi yang ditampilkan.

<img width="1920" height="1080" alt="Tulis isi dokumentasi (1)" src="https://github.com/user-attachments/assets/0c56be68-89c3-41ed-ab61-39efc5c8ea74" />

---

## 9. Cara Mengakses BookStack

1. Buka https://kelompoksatu.cloud.
2. Masukkan email atau username dan password akun yang telah dikonfigurasi.
3. Setelah berhasil masuk, pengguna dapat mengakses konten sesuai izin akun.
4. Untuk membuat dokumentasi, gunakan struktur Books, Chapters, dan Pages.

---

## 10. Keamanan dan Pemeliharaan

Hal-hal yang perlu diperhatikan setelah deployment:

- Perbarui Ubuntu dan komponen aplikasi secara berkala.
- Gunakan password administrator yang kuat.
- Batasi akses SSH dan akses root sesuai kebutuhan.
- Pastikan hanya port layanan yang diperlukan yang terbuka ke internet.
- Buat backup database dan data BookStack secara berkala.
- Simpan kredensial dan file rahasia di luar repository.
- Pantau masa berlaku sertifikat dan pastikan auto-renew berjalan.
- Jangan mengubah konfigurasi Apache, database, atau aplikasi tanpa backup apabila perubahan berisiko mengganggu layanan.

---

## 11. Dokumentasi dan Referensi

- [BookStack — Website Resmi](https://www.bookstackapp.com/)
- [BookStack — Dokumentasi Resmi](https://www.bookstackapp.com/docs/)
- [BookStack — Repositori Sumber](https://github.com/BookStackApp/BookStack)
- [BookStack DevOps Scripts](https://codeberg.org/bookstack/devops)
- [Ubuntu Server Documentation](https://documentation.ubuntu.com/server/)
