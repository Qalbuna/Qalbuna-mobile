# Qalbuna Design System

Dokumen ini menjelaskan design system yang digunakan dalam aplikasi Qalbuna Mobile. Design system ini dirancang untuk memberikan pengalaman pengguna yang konsisten dan aksesibel.

## Color System

Design system Qalbuna menggunakan pendekatan sistematis untuk warna dengan variasi shade yang konsisten untuk setiap kategori warna. Setiap warna memiliki 9-12 variasi shade (dari 25-950) yang memungkinkan fleksibilitas dalam desain UI.

### Warna Utama

#### Primary Colors (Blue)
Warna utama aplikasi yang digunakan untuk elemen-elemen penting seperti tombol utama, header, dan elemen interaktif lainnya.

```dart
static const Color v1Primary25 = Color(0xFFE1E2FC); // AAA 17:82
static const Color v1Primary50 = Color(0xFFDADBFC); // AAA 16:77
static const Color v1Primary100 = Color(0xFFCDCEFB); // AAA 15:15
static const Color v1Primary200 = Color(0xFFB3B4F8); // AAA 12:37
static const Color v1Primary300 = Color(0xFF989AF6); // AAA 9:98
static const Color v1Primary400 = Color(0xFF7E80F3); // AAA 8:07
static const Color v1Primary500 = Color(0xFF6366F1); // AAA 6:49
static const Color v1Primary600 = Color(0xFF292DEC); // AAA 4:72
static const Color v1Primary700 = Color(0xFF1215C5); // AAA 6:06
static const Color v1Primary800 = Color(0xFF0C0F8B); // AAA 10:17
static const Color v1Primary900 = Color(0xFF070951); // AAA 13:11
static const Color v1Primary950 = Color(0xFF050634); // AAA 17:07
```

#### Neutral Colors (BlueGray)
Warna netral digunakan untuk teks, background, dan elemen UI yang membutuhkan nuansa netral.

```dart
static const Color v1Neutral25 = Color(0xFFF5F7FA); // AAA 21:00
static const Color v1Neutral50 = Color(0xFFEFF4FB); // AAA 19:48
static const Color v1Neutral100 = Color(0xFFE3EAF4); // AAA 17:47
// ... dan seterusnya
```

### Warna Semantik

#### Error Colors (Red)
Digunakan untuk pesan error, peringatan kritis, dan indikasi kesalahan.

```dart
static const Color v1Error25 = Color(0xFFFEF3F2); // AAA 19:47
static const Color v1Error50 = Color(0xFFFEE4E2); // AAA 18:47
// ... dan seterusnya
```

#### Warning Colors (Amber)
Digunakan untuk peringatan dan notifikasi yang memerlukan perhatian pengguna.

```dart
static const Color v1Warning25 = Color(0xFFFFFAEB); // AAA 19:47
static const Color v1Warning50 = Color(0xFFFEF5D3); // AAA 18:47
// ... dan seterusnya
```

#### Success Colors (Green)
Digunakan untuk konfirmasi, aksi berhasil, dan indikasi positif lainnya.

```dart
static const Color v1Success25 = Color(0xFFECFDF3); // AAA 19:47
static const Color v1Success50 = Color(0xFFDCFAE6); // AAA 18:47
// ... dan seterusnya
```

#### Info Colors (Blue)
Digunakan untuk informasi, petunjuk, dan elemen UI informatif lainnya.

```dart
static const Color v1Info25 = Color(0xFFE3F5FE); // AAA 19:39
static const Color v1Info50 = Color(0xFFD3EEFE); // AAA 18:48
// ... dan seterusnya
```

### Extended Color Palette

Design system juga menyediakan palette warna tambahan untuk kebutuhan desain yang lebih spesifik:

- **Purple**: Untuk elemen yang memerlukan nuansa kreatif dan inovatif
- **Pink**: Untuk elemen yang memerlukan nuansa energik dan playful
- **Teal**: Untuk elemen yang memerlukan nuansa profesional dan tenang
- **Gray, Slate, Zinc, Cool Gray**: Variasi warna abu-abu untuk kebutuhan desain yang berbeda
- **Indigo, Violet, Fuchsia**: Variasi warna ungu untuk kebutuhan desain yang berbeda
- **Rose, Orange, Brown**: Warna hangat untuk elemen yang memerlukan nuansa kehangatan
- **Lime, Emerald**: Variasi warna hijau untuk kebutuhan desain yang berbeda
- **Cyan, Sky**: Variasi warna biru untuk kebutuhan desain yang berbeda

### Aksesibilitas Warna

Setiap warna dalam design system dilengkapi dengan rating aksesibilitas (AAA) yang menunjukkan rasio kontras sesuai dengan standar WCAG (Web Content Accessibility Guidelines). Format komentar "AAA X:XX" menunjukkan rating aksesibilitas dan rasio kontras.

### Theme Roles

Design system mendefinisikan peran warna untuk tema terang (Light) dan gelap (Dark):

```dart
// Light Theme Roles
static const Color v1LightBackground = Color(0xFFF5F7FA); // AAA 21:00
static const Color v1LightError = Color(0xFFD92D20); // AAA 5:47
static const Color v1LightPrimary = Color(0xFF2E90FA); // AAA 6:49
static const Color v1LightSecondary = Color(0xFF7B97FC); // AAA 9:98
static const Color v1LightSuccess = Color(0xFF17B26A); // AAA 5:47
static const Color v1LightSurface = Color(0xFFEFF4FB); // AAA 19:48
static const Color v1LightWarning = Color(0xFFF79009); // AAA 5:47

// Dark Theme Roles
static const Color v1DarkBackground = Color(0xFF0A1F3A); // AAA 17:14
static const Color v1DarkError = Color(0xFFF04438); // AAA 7:47
static const Color v1DarkPrimary = Color(0xFF0B74EC); // AAA 4:72
static const Color v1DarkSecondary = Color(0xFF53A4FB); // AAA 8:07
static const Color v1DarkSuccess = Color(0xFF47CD89); // AAA 7:47
static const Color v1DarkSurface = Color(0xFF102A4C); // AAA 14:14
static const Color v1DarkWarning = Color(0xFFF8B73E); // AAA 7:47
```

## Typography

Design system menggunakan font family 'Inter' dengan berbagai variasi gaya untuk memenuhi kebutuhan hierarki teks.

### Heading Styles

```dart
// H1 Styles
static const TextStyle h1Bold = TextStyle(
  fontFamily: fontFamily,
  fontSize: 36,
  fontWeight: FontWeight.bold,
  height: 46/36, // line-height in Flutter is specified as a multiplier
);

static const TextStyle h1SemiBold = TextStyle(
  fontFamily: fontFamily,
  fontSize: 36,
  fontWeight: FontWeight.w600, // SemiBold
  height: 1.0, // Auto
);

// ... dan seterusnya untuk H2, H3, H4, H5
```

### Body Styles

Design system menyediakan gaya teks untuk konten body dengan variasi ukuran (Large, Medium, Small) dan weight (Regular, Medium, SemiBold, Bold).

## Theme Implementation

Design system diimplementasikan dalam aplikasi melalui kelas `AppTheme` yang mendefinisikan tema terang dan gelap:

```dart
// Light Theme
static ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.v1Primary500,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    // Headline styles
    displayLarge: AppTypography.h1Bold,
    displayMedium: AppTypography.h2Bold,
    // ... dan seterusnya
  ),
  colorScheme: ColorScheme.light(
    primary: AppColors.v1Primary500,
    error: AppColors.v1Error500,
    onPrimary: Colors.white,
  ),
);

// Dark Theme
static ThemeData darkTheme = ThemeData(
  // ... konfigurasi untuk tema gelap
);
```

## Penggunaan Design System

Untuk menggunakan design system dalam aplikasi:

1. **Warna**: Gunakan konstanta dari kelas `AppColors`, misalnya `AppColors.v1Primary500`
2. **Tipografi**: Gunakan konstanta dari kelas `AppTypography`, misalnya `AppTypography.h1Bold`
3. **Tema**: Terapkan tema menggunakan `MaterialApp(theme: AppTheme.lightTheme)`

## Konvensi Penamaan

Design system menggunakan konvensi penamaan yang konsisten:

- Prefix `v1` untuk menandai versi design system
- Nama warna diikuti dengan nilai shade (25-950)
- Nama tipografi menunjukkan ukuran dan weight (h1Bold, mRegular, dll.)

## Panduan Pengembangan

Saat mengembangkan komponen UI baru:

1. Selalu gunakan warna dan tipografi dari design system
2. Jangan mendefinisikan warna atau gaya teks secara inline
3. Pastikan komponen memenuhi standar aksesibilitas
4. Ikuti konvensi penamaan yang konsisten

## Evolusi Design System

Design system akan terus berkembang seiring dengan kebutuhan aplikasi. Perubahan pada design system harus didokumentasikan dengan baik dan diimplementasikan secara konsisten di seluruh aplikasi.