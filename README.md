<a id="top"></a>

# Bookstack

<img width="521" height="182" alt="image" src="https://github.com/user-attachments/assets/7e9837c4-51f6-4dd3-b8c6-519d435497bb" />


## Anggota Kelompok

| No. | Nama | NIM |
|---|---|---|
| 1 | Safira Ayu Damayanti | M0403241010 |
| 2 | Asty Athetha Loethan | M0403241089 |
| 3 | Isyana Ajeng Khairani | M0403241096 |
| 4 | Deswita Diandra | M0403241127 |
| 5 | Adzkia Muftia Rahman | M0403241153 |

---

## Sekilas Tentang

[`^ kembali ke atas ^`](#top)

BookStack merupakan aplikasi dokumentasi berbasis web yang dapat digunakan untuk menyimpan, menyusun, dan mengelola informasi secara terstruktur. Konten di BookStack disusun menggunakan hierarki buku (*books*), bab (*chapters*), dan halaman (*pages*).

Dalam proyek ini, BookStack di-deploy pada Virtual Private Server (VPS) agar aplikasi dapat diakses melalui internet menggunakan domain sendiri.

Aplikasi dijalankan pada Ubuntu Server 24.04 dengan Apache sebagai web server, MySQL sebagai database, serta PHP sebagai lingkungan runtime aplikasi. Domain diarahkan ke alamat IP publik VPS dan diamankan menggunakan sertifikat HTTPS dari Let's Encrypt.

**Aplikasi:** https://kelompoksatu.cloud

---

## Instalasi

[`^ kembali ke atas ^`](#top)

#### Kebutuhan Sistem

Sistem yang digunakan dalam proyek ini meliputi:

- VPS dari Rumahweb.
- Ubuntu Server 24.04 LTS.
- Akses SSH dan hak akses administrator.
- Apache sebagai web server.
- PHP untuk menjalankan aplikasi BookStack.
- MySQL sebagai database.
- Domain yang diarahkan ke IP VPS.
- Koneksi internet untuk proses instalasi dan akses aplikasi.

#### Proses Instalasi

1. **Login ke VPS menggunakan SSH.**

   Hubungkan ke server menggunakan terminal:

   ```bash
   ssh root@202.10.Kebutuhan Sistem
   ```
   
   Sesuaikan username jika server menggunakan akun selain `root`.

2. **Perbarui daftar paket sistem.**

   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

3. **Unduh installer BookStack untuk Ubuntu 24.04.**

   ```bash
   wget https://codeberg.org/bookstack/devops/raw/branch/main/scripts/installation-ubuntu-24.04.sh
   ```

4. **Jalankan installer.**

   ```bash
   chmod +x installation-ubuntu-24.04.sh
   sudo ./installation-ubuntu-24.04.sh 202.10.40.194
   ```

   Installer tersebut digunakan untuk membantu proses instalasi BookStack beserta konfigurasi yang diperlukan. Pastikan membaca instruksi installer sebelum menjalankannya.

5. **Arahkan domain ke IP VPS.**

   Pada pengaturan DNS domain, tambahkan record berikut:

   | Type | Name | Value           |
   | ---- | ---- | --------------- |
   | A    | `@`  | `202.10.40.194` |

   Pastikan domain sudah mengarah ke IP VPS sebelum melanjutkan konfigurasi HTTPS.

6. **Konfigurasi URL aplikasi.**

   Buka file konfigurasi BookStack:

   ```bash
   sudo nano /var/www/bookstack/.env
   ```

   Pastikan nilai `APP_URL` sesuai dengan domain yang digunakan:

   ```env
   APP_URL=https://kelompoksatu.cloud
   ```

   Simpan perubahan, kemudian bersihkan cache konfigurasi:

   ```bash
   cd /var/www/bookstack
   sudo php artisan config:clear
   ```

  
---

# Konfigurasi

[`^ kembali ke atas ^`](#top)

Setelah instalasi selesai, BookStack dapat dikonfigurasi melalui halaman aplikasi maupun file konfigurasi pada server.

- **Konfigurasi aplikasi:** pengguna dapat mengelola buku, chapter, halaman dokumentasi, serta pengaturan yang tersedia sesuai hak akses akun.
- **Konfigurasi URL:** alamat aplikasi ditentukan melalui variabel `APP_URL` dalam file `.env`.
- **Konfigurasi database:** BookStack menggunakan database untuk menyimpan informasi aplikasi. Kredensial database harus dijaga kerahasiaannya dan tidak boleh dicantumkan dalam dokumentasi publik.
- **Pengaturan pengguna:** administrator dapat mengelola akun dan hak akses agar dokumentasi dapat dikelola sesuai kebutuhan.

---

# Maintenance

[`^ kembali ke atas ^`](#top)

Maintenance dilakukan untuk menjaga ketersediaan aplikasi, keamanan server, dan integritas data.

1. **Memeriksa status web server.**

   ```bash
   sudo systemctl status apache2
   ```

2. **Memeriksa pembaruan paket.**

   ```bash
   sudo apt update
   apt list --upgradable
   ```

3. **Melakukan backup.**

   Backup perlu mencakup database MySQL dan file BookStack yang diperlukan, termasuk konfigurasi serta file unggahan. Simpan salinan backup di lokasi terpisah dari VPS dan uji proses pemulihannya secara berkala.

4. **Menjaga keamanan server.**

   Gunakan kata sandi yang kuat, batasi akses SSH, lakukan pembaruan keamanan secara berkala, dan jangan membagikan file `.env` atau kredensial database.

Langkah-langkah di atas merupakan prosedur pemeliharaan. Backup otomatis tidak dianggap aktif sebelum mekanisme pencadangan benar-benar dikonfigurasi dan diuji.

---

# Otomatisasi

[`^ kembali ke atas ^`](#top)

Proses instalasi aplikasi dapat dibantu menggunakan **shell script**, yaitu file berisi kumpulan perintah yang dijalankan secara berurutan melalui terminal.

Pada proyek ini, file `setup.sh` disediakan untuk membantu mengotomatisasi proses setup BookStack pada VPS Ubuntu Server 24.04.

File tersebut dapat dilihat melalui repository:

[setup.sh — BookStack](https://github.com/mawcha/Bookstack/blob/main/setup.sh)

Sebelum menjalankan script, pastikan VPS memenuhi kebutuhan sistem dan periksa isi script untuk memahami tindakan yang akan dilakukan.

Contoh cara menjalankan script pada VPS baru, apabila file sudah tersedia di server:

```bash
chmod +x setup.sh
sudo ./setup.sh kelompoksatu.cloud 202.10.40.194
```
---

## Cara Pemakaian

[`^ kembali ke atas ^`](#top)

### Login ke BookStack

Buka URL BookStack melalui browser, kemudian masukkan username dan password akun yang telah diberikan oleh administrator.

<img width="1600" height="849" alt="WhatsApp Image 2026-10-20 at 3 50 35 PM" src="https://github.com/user-attachments/assets/b853e9fb-e12a-4110-b2da-b5b08783dce5" />


### Tampilan Setelah Login

Setelah berhasil login, pengguna akan diarahkan ke halaman utama BookStack. Pada halaman ini, pengguna dapat melihat dokumentasi yang tersedia serta mengakses fitur untuk membuat dan mengelola konten, sesuai dengan hak akses akun.

<img width="1861" height="967" alt="image" src="https://github.com/user-attachments/assets/60d02c77-cb19-419d-9230-0fc910c9e1f9" />

### Membuat Book

Book digunakan sebagai wadah utama untuk mengelompokkan dokumentasi berdasarkan topik tertentu. Misalnya, pengguna dapat membuat satu Book untuk dokumentasi praktikum, panduan aplikasi, atau materi perkuliahan.

Langkah-langkah:
1. Buka halaman utama BookStack.
2. Pilih menu atau tombol untuk membuat Book baru.
3. Masukkan nama Book dan informasi pendukung jika diperlukan.
4. Simpan Book yang telah dibuat.

<img width="1920" height="1080" alt="Tulis isi dokumentasi (2)" src="https://github.com/user-attachments/assets/0282e65a-c44d-4b48-abc6-eb4c7765e186" />

### Membuat Chapter

Chapter digunakan untuk membagi isi Book menjadi beberapa bagian berdasarkan subtopik agar dokumentasi lebih terstruktur.

Langkah-langkah:
1. Buka Book yang ingin dikelola.
2. Pilih opsi untuk menambahkan Chapter.
3. Masukkan nama Chapter.
4. Simpan Chapter.

<img width="1920" height="1080" alt="Tulis isi dokumentasi" src="https://github.com/user-attachments/assets/fe446c28-4f17-421d-ba94-4894b6b80187" />

### Membuat Page Baru

Page merupakan tempat untuk menulis isi dokumentasi secara lebih rinci. Page dapat berisi teks, gambar, tabel, tautan, dan elemen pendukung lainnya.

Langkah-langkah:
1. Buka Book dan Chapter yang sesuai.
2. Pilih opsi untuk membuat Page baru.
3. Masukkan judul Page.
4. Tulis isi dokumentasi menggunakan editor yang tersedia.
5. Simpan atau terbitkan Page sesuai opsi yang ditampilkan.

<img width="1920" height="1080" alt="Tulis isi dokumentasi (1)" src="https://github.com/user-attachments/assets/0c56be68-89c3-41ed-ab61-39efc5c8ea74" />

---

## Pembahasan

[`^ kembali ke atas ^`](#)

**1. Kelebihan**

1. Antarmuka yang intuitif: Tampilan yang sederhana membantu pengguna membuat dan membaca dokumentasi tanpa harus memahami sintaks wiki yang kompleks.

2. Struktur dokumentasi terorganisir: Konten disusun dalam hierarki Shelf, Book, Chapter, dan Page sehingga informasi lebih mudah dikelompokkan dan dinavigasi.

3. Editor yang mudah digunakan: Mendukung editor visual dan Markdown untuk mempermudah pembuatan serta pengeditan konten.

4. Pengelolaan hak akses: Menyediakan pengaturan peran dan izin pengguna untuk membantu mengontrol akses terhadap konten.

5. Open-source dan dapat di-host sendiri: BookStack dapat digunakan tanpa biaya lisensi aplikasi dan diinstal pada server atau Virtual Machine (VM) milik sendiri.

**2. Kekurangan**

1. Struktur konten relatif kaku: Pengorganisasian konten mengikuti hierarki buku dan halaman sehingga kurang fleksibel untuk beberapa jenis dokumentasi.

2. Kustomisasi lanjutan terbatas: Kebutuhan yang sangat spesifik mungkin memerlukan konfigurasi tambahan atau pengembangan di luar fitur bawaan.

3. Memerlukan pemeliharaan server: Instalasi mandiri membutuhkan pengelolaan pembaruan, pencadangan data (backup), keamanan, dan konfigurasi server.

4. Bergantung pada server: Akses melalui jaringan dan performanya dipengaruhi oleh VM serta resources yang tersedia.

5. Bukan aplikasi manajemen proyek: BookStack berfokus pada dokumentasi dan pengelolaan pengetahuan, bukan pada pengelolaan tugas, jadwal, atau pelacakan progres proyek.

**3. Perbandingan dengan Aplikasi Serupa**

| No. | Aspek | BookStack | Wiki.js | MediaWiki |
|---|---|---|---|---|
| 1 | Fungsi Utama | Dokumentasi dan knowledge base terstruktur | Wiki modern dan dokumentasi fleksibel | Wiki dan ensiklopedia |
| 2 | Struktur Konten | Shelf, Book, Chapter, Page | Halaman wiki fleksibel | Halaman, kategori, namespace, template |
| 3 | Antarmuka | Sederhana dan intuitif | Modern dan fleksibel | Fungsional dan dapat dikustomisasi |
| 4 | Editor Konten | Visual editor dan Markdown | Visual editor dan Markdown | Wikitext dan VisualEditor |
| 5 | Kustomisasi | Cukup untuk dokumentasi umum | Tema, modul, dan integrasi | Ekstensi dan template |
| 6 | Kelebihan Utama | Struktur jelas dan mudah dipahami | Fleksibel dan modern | Matang dan kaya fitur |
| 7 | Kekurangan Utama | Struktur relatif kaku | Konfigurasi dapat lebih kompleks | Kustomisasi dapat lebih kompleks |
| 8 | Contoh Penggunaan | SOP, panduan praktikum, dokumentasi proyek | Dokumentasi teknis dan produk | Ensiklopedia dan wiki komunitas |

---

## Referensi

[`^ kembali ke atas ^`](#top)

- [BookStack — Website Resmi](https://www.bookstackapp.com/)
- [BookStack — Dokumentasi Resmi](https://www.bookstackapp.com/docs/)
- [BookStack — Repositori Sumber](https://github.com/BookStackApp/BookStack)
- [BookStack DevOps Scripts](https://codeberg.org/bookstack/devops)
- [Ubuntu Server Documentation](https://documentation.ubuntu.com/server/)

  
