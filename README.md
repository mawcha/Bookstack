# Bookstack

Dokumentasi proyek mata kuliah **Komunikasi Data dan Jaringan Komputer (KDJK)** untuk instalasi, konfigurasi, dan deployment BookStack pada VPS agar dapat diakses melalui internet.

## Daftar Isi

1. [Deskripsi Proyek](#1-deskripsi-proyek)
2. [Tujuan](#2-tujuan)
3. [Teknologi yang Digunakan](#3-teknologi-yang-digunakan)
4. [Arsitektur Sistem](#4-arsitektur-sistem)
5. [Informasi Deployment](#5-informasi-deployment)
6. [Persiapan VPS](#6-persiapan-vps)
7. [Instalasi BookStack](#7-instalasi-bookstack)
8. [Konfigurasi Domain](#8-konfigurasi-domain)
9. [Konfigurasi HTTPS](#9-konfigurasi-https)
10. [Pengujian](#10-pengujian)
11. [Cara Mengakses BookStack](#11-cara-mengakses-bookstack)
12. [Troubleshooting](#12-troubleshooting)
13. [Keamanan dan Pemeliharaan](#13-keamanan-dan-pemeliharaan)
14. [Dokumentasi dan Referensi](#14-dokumentasi-dan-referensi)
15. [Anggota Kelompok](#15-anggota-kelompok)

---

## 1. Deskripsi Proyek

BookStack merupakan aplikasi dokumentasi berbasis web yang dapat digunakan untuk menyimpan, menyusun, dan mengelola informasi secara terstruktur. Konten di BookStack disusun menggunakan hierarki buku (*books*), bab (*chapters*), dan halaman (*pages*).

Dalam proyek ini, BookStack di-deploy pada Virtual Private Server (VPS) agar aplikasi dapat diakses melalui internet menggunakan domain sendiri.

Aplikasi dijalankan pada Ubuntu Server 24.04 dengan Apache sebagai web server, MySQL sebagai database, serta PHP sebagai lingkungan runtime aplikasi. Domain diarahkan ke alamat IP publik VPS dan diamankan menggunakan sertifikat HTTPS dari Let's Encrypt.

**Aplikasi:** https://kelompoksatu.cloud

## 2. Tujuan

Tujuan pelaksanaan proyek ini adalah:

- Memahami penggunaan VPS untuk menjalankan aplikasi berbasis web.
- Memahami proses instalasi dan konfigurasi aplikasi self-hosted.
- Memahami hubungan antara domain, DNS, IP publik, dan web server.
- Menerapkan layanan HTTPS menggunakan sertifikat SSL/TLS.
- Menyediakan aplikasi dokumentasi yang dapat diakses melalui internet.

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
| HTTPS | Let's Encrypt |
| Pengelola sertifikat | Certbot |

> **Catatan:** Jangan mencantumkan password root, password database, private key, isi file `.env`, atau kredensial akun pada repository publik.

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

**Penting:** Skrip instalasi bukan pengganti konfigurasi keamanan server. Pastikan sistem, akses administrator, firewall, dan pembaruan keamanan tetap dikelola dengan baik.

## 8. Konfigurasi Domain

Domain `kelompoksatu.cloud` diarahkan ke VPS melalui DNS.

### 8.1 Membuat DNS A Record

Pada pengelolaan DNS domain, buat record berikut:

| Field | Nilai |
|---|---|
| Type | `A` |
| Host | Domain utama (`@`, sesuai format panel DNS) |
| TTL | `14400` |
| Destination | `202.10.40.194` |

A Record menghubungkan domain utama dengan alamat IPv4 publik VPS.

### 8.2 Memeriksa resolusi DNS

Jalankan perintah:

```bash
getent ahostsv4 kelompoksatu.cloud
```

Hasil yang diharapkan memuat alamat:

```text
202.10.40.194
```

DNS memerlukan waktu untuk menyebar setelah perubahan dilakukan. Durasi propagasi dapat berbeda-beda.

## 9. Konfigurasi HTTPS

HTTPS digunakan untuk mengenkripsi komunikasi antara browser pengguna dan server.

### 9.1 Memasang Certbot

Pada server yang digunakan dalam proyek ini, Certbot dipasang melalui Snap:

```bash
apt update
apt install snapd -y
snap install certbot --classic
```

### 9.2 Memperoleh sertifikat dan mengonfigurasi Apache

```bash
certbot --apache -d kelompoksatu.cloud
```

Ikuti instruksi interaktif Certbot. Gunakan alamat email yang aktif dan pilih pengalihan HTTP ke HTTPS apabila opsi tersebut tersedia dan sesuai dengan kebutuhan deployment.

### 9.3 Memperbarui URL aplikasi

Konfigurasi URL utama BookStack berada di:

```text
/var/www/bookstack/.env
```

Buka file menggunakan editor:

```bash
nano /var/www/bookstack/.env
```

Pastikan nilai `APP_URL` menggunakan domain HTTPS:

```dotenv
APP_URL=https://kelompoksatu.cloud
```

Simpan file, kemudian bersihkan cache konfigurasi:

```bash
cd /var/www/bookstack
php artisan config:clear
```

### 9.4 Memeriksa sertifikat

Jalankan:

```bash
certbot certificates
```

Sertifikat yang aktif seharusnya mencantumkan `kelompoksatu.cloud` dan tanggal kedaluwarsanya.

### 9.5 Memeriksa perpanjangan otomatis

Periksa timer Certbot:

```bash
systemctl list-timers --all | grep -i certbot
```

Uji proses perpanjangan tanpa mengganti sertifikat yang aktif:

```bash
certbot renew --dry-run
```

Pengujian dianggap berhasil apabila Certbot melaporkan bahwa simulasi perpanjangan sukses.

## 10. Pengujian

Pengujian dilakukan untuk memastikan setiap komponen utama berfungsi.

### 10.1 Pengujian DNS

```bash
getent ahostsv4 kelompoksatu.cloud
```

Hasil harus mengarah ke IP publik VPS.

### 10.2 Pengujian Apache

```bash
systemctl is-active apache2
```

Hasil yang diharapkan:

```text
active
```

### 10.3 Pengujian HTTPS

```bash
curl -Iv https://kelompoksatu.cloud
```

Periksa apakah:

- Koneksi ke port 443 berhasil.
- Sertifikat diterima dan valid.
- Nama domain cocok dengan sertifikat.
- Respons HTTP berasal dari aplikasi yang benar.

Respons `302 Found` yang mengarahkan pengguna ke `/login` merupakan respons pengalihan yang normal apabila halaman awal BookStack mengarahkan pengunjung ke halaman login.

Contoh lokasi pengalihan yang diharapkan:

```text
Location: https://kelompoksatu.cloud/login
```

### 10.4 Pengujian melalui browser

Buka:

**https://kelompoksatu.cloud**

Pastikan halaman login tampil tanpa peringatan sertifikat dan pengguna yang berwenang dapat masuk ke aplikasi.

### 10.5 Hasil pengujian

| Pengujian | Hasil |
|---|---|
| DNS mengarah ke VPS | Berhasil |
| Apache aktif | Berhasil |
| Sertifikat HTTPS valid | Berhasil |
| URL aplikasi menggunakan HTTPS | Berhasil |
| Simulasi perpanjangan sertifikat | Berhasil |
| Akses halaman login melalui browser | Berhasil |

## 11. Cara Mengakses BookStack

1. Buka https://kelompoksatu.cloud.
2. Masukkan email atau username dan password akun yang telah dikonfigurasi.
3. Setelah berhasil masuk, pengguna dapat mengakses konten sesuai izin akun.
4. Untuk membuat dokumentasi, gunakan struktur Books, Chapters, dan Pages.

Kredensial administrator tidak dicantumkan dalam README ini. Gunakan akun yang telah diamankan dan jangan membagikan password melalui repository publik.

## 12. Troubleshooting

### Domain tidak dapat diakses

Periksa DNS:

```bash
getent ahostsv4 kelompoksatu.cloud
```

Pastikan hasilnya mengarah ke IP VPS yang benar. Jika DNS baru diubah, tunggu propagasi dan periksa kembali.

### Apache tidak berjalan

```bash
systemctl status apache2
apache2ctl -S
```

Periksa konfigurasi virtual host dan log Apache sebelum melakukan perubahan.

### Browser menampilkan peringatan HTTPS

Periksa sertifikat:

```bash
certbot certificates
```

Kemudian uji koneksi:

```bash
curl -Iv https://kelompoksatu.cloud
```

Periksa nama domain, masa berlaku sertifikat, dan virtual host HTTPS Apache.

### BookStack mengarah ke IP atau HTTP

Periksa konfigurasi:

```bash
grep '^APP_URL=' /var/www/bookstack/.env
```

Nilai yang diharapkan:

```dotenv
APP_URL=https://kelompoksatu.cloud
```

Jika konfigurasi diperbarui, bersihkan cache:

```bash
cd /var/www/bookstack
php artisan config:clear
```

### Sertifikat gagal diperpanjang

Jalankan:

```bash
certbot renew --dry-run
```

Periksa pesan kesalahan, resolusi DNS, akses HTTP/HTTPS dari internet, dan status timer Certbot.

## 13. Keamanan dan Pemeliharaan

Hal-hal yang perlu diperhatikan setelah deployment:

- Perbarui Ubuntu dan komponen aplikasi secara berkala.
- Gunakan password administrator yang kuat.
- Batasi akses SSH dan akses root sesuai kebutuhan.
- Pastikan hanya port layanan yang diperlukan yang terbuka ke internet.
- Buat backup database dan data BookStack secara berkala.
- Simpan kredensial dan file rahasia di luar repository.
- Pantau masa berlaku sertifikat dan pastikan auto-renew berjalan.
- Jangan mengubah konfigurasi Apache, database, atau aplikasi tanpa backup apabila perubahan berisiko mengganggu layanan.

## 14. Dokumentasi dan Referensi

- [BookStack — Website Resmi](https://www.bookstackapp.com/)
- [BookStack — Dokumentasi Resmi](https://www.bookstackapp.com/docs/)
- [BookStack — Repositori Sumber](https://github.com/BookStackApp/BookStack)
- [BookStack DevOps Scripts](https://codeberg.org/bookstack/devops)
- [Let's Encrypt](https://letsencrypt.org/)
- [Certbot](https://certbot.eff.org/)
- [Apache HTTP Server Documentation](https://httpd.apache.org/docs/)
- [Ubuntu Server Documentation](https://documentation.ubuntu.com/server/)

## 15. Anggota Kelompok

| No. | Nama | NIM |
|---|---|---|
| 1 | Safira Ayu Damayanti | M0403241010 |
| 2 | Asty Athetha Loethan | M0403241089 |
| 3 | Isyana Ajeng Khairani | M0403241096 |
| 4 | Deswita Diandra | M0403241127 |
| 5 | Adzkia Muftia Rahman | M0403241153 |

---

**Mata Kuliah:** Komunikasi Data dan Jaringan Komputer (KDJK)  
**Platform:** BookStack  
**Deployment:** Rumahweb VPS — Ubuntu Server 24.04  
**Domain:** https://kelompoksatu.cloud
