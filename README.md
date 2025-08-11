## Talim — Sistem Informasi Sekolah TK Al‑Alim

Aplikasi Flutter multi‑platform (Android, iOS, Web, Desktop) untuk membantu orang tua/wali memantau perkembangan anak di TK Al‑Alim secara digital. Hadir dengan tampilan modern, komponen UI reusable. Saat ini proyek bersifat frontend‑only (belum terhubung ke server/back‑end).

### Tujuan & Manfaat
- **Monitoring perkembangan anak**: Orang tua dapat melihat data diri, jurnal harian, presensi, nilai rapor, hingga pembayaran.
- **Komunikasi sekolah‑orang tua**: Melalui pengumuman, agenda sekolah, dan dokumentasi kegiatan.
- **Pengalaman pengguna yang ramah**: UI konsisten memakai `CustomColors` & `CustomText`, animasi Rive saat login, serta navigasi sederhana via bottom navbar.

## Fitur Utama
- **Login interaktif** dengan animasi Rive.
- **Dashboard Beranda**:
  - Header sekolah dengan logo dan menu notifikasi.
  - Daftar anak (mock API, mudah diganti ke API nyata) dalam bentuk kartu yang bisa diekspansi.
  - Aksi cepat per anak: Data Diri, Jurnal Harian, Presensi, Nilai Rapot, Pembayaran.
  - Seksi informasi: Agenda Sekolah, Pengumuman, dan slider Dokumentasi Kegiatan.
- **Navigasi bawah**: `Beranda` dan `Profil`.

## Arsitektur & Struktur Folder
- `lib/main.dart`: Entry point aplikasi.
- `lib/MainMenu/`
  - `NavbarMenu.dart`: Bottom navigation & pengelola halaman.
  - `BerandaPage.dart`: Halaman beranda/dashboard (agenda, pengumuman, dokumentasi, daftar anak).
  - File lain seperti `ProfilePage.dart` (halaman profil, jika tersedia).
- `lib/UserPages/`
  - `loginPages.dart`: Halaman login dengan animasi Rive.
- `lib/src/`
  - Komponen UI reusable: `child_card.dart`, `CustomText.dart`, `customColor.dart`, `pageTransition.dart`, dll.
- `lib/Models/`
  - `child_model.dart`: Model data anak.
- `lib/SendApi/`
  - `AnakAPI.dart`: Sumber data anak (mock, dapat diganti ke REST API di masa depan).
- `assets/`
  - `images/`, `fonts/`, `rive/`, dll. Digunakan oleh UI dan animasi.

## Alur Pengguna Singkat
1. Pengguna membuka aplikasi dan melakukan login.
2. Masuk ke `NavbarMenu` dengan tab `Beranda` (default) dan `Profil`.
3. Di `Beranda`, pengguna melihat header sekolah, daftar anak, serta agenda, pengumuman, dan dokumentasi.
4. Pada kartu anak, pengguna dapat mengekspansi untuk mengakses menu: Data Diri, Jurnal Harian, Presensi, Nilai, Pembayaran.

## Data Sementara (Frontend‑only)
Sumber data anak saat ini dimock di `lib/SendApi/AnakAPI.dart` agar UI bisa diuji tanpa backend:

```dart
class Anakapi {
  static Future<List<ChildModel>> getChildren() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ChildModel(id: 1, name: "Budi Pratama", className: "TK B1", nisn: "0078653930123"),
      ChildModel(id: 2, name: "Aisya Nur Hidayah", className: "TK A1", nisn: "0088653233443"),
    ];
  }
}
```

Jika ingin menghubungkan ke API nyata, ubah implementasi `getChildren()` untuk melakukan HTTP request ke endpoint Anda dan map JSON ke `ChildModel`. Contoh format JSON yang diharapkan:

```json
[
  {"id": 1, "name": "Budi Pratama", "className": "TK B1", "nisn": "0078653930123"},
  {"id": 2, "name": "Aisya Nur Hidayah", "className": "TK A1", "nisn": "0088653233443"}
]
```

## Persiapan Lingkungan
### Prasyarat
- Flutter SDK (disarankan: stable terbaru)
- Dart SDK (ikut paket Flutter)
- Android Studio/Xcode (untuk Android/iOS), browser untuk Web

Periksa versi:

```bash
flutter --version
```

### Instal Dependensi & Menjalankan Aplikasi
```bash
flutter pub get
flutter run -d chrome        # Web
flutter run -d emulator-5554 # Android contoh
```

Jika target Web menampilkan peringatan di `web/index.html` terkait `serviceWorkerVersion` atau `FlutterLoader.loadEntrypoint` yang deprecated, ikuti panduan resmi: `https://docs.flutter.dev/platform-integration/web/initialization`.

## Konfigurasi Aset & Font
Pastikan aset gambar, animasi Rive, dan font sudah terdaftar di `pubspec.yaml` pada bagian `assets:` dan `fonts:`. Contoh (ringkas):

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/rive/
  fonts:
    - family: SFPro
      fonts:
        - asset: assets/fonts/SF-Pro-Text-Regular.otf
        - asset: assets/fonts/SF-Pro-Text-Bold.otf
```

## Build Release (ringkas)
- Android: `flutter build apk` atau `flutter build appbundle`
- iOS: `flutter build ipa` (butuh Xcode & provisioning)
- Web: `flutter build web`

## Roadmap Singkat
- Mengganti mock API dengan endpoint backend nyata (Laravel/REST).
- Implementasi halaman detail: Data Diri, Jurnal Harian, Presensi, Nilai, Pembayaran.
- Menambahkan autentikasi JWT, manajemen state (mis. Provider/Riverpod), dan error handling terstruktur.

## Lisensi
Internal project (sesuaikan ketentuan lisensi jika akan dipublikasikan).
