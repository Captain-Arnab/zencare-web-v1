# Zencare

**Your one-stop solution for all home and lifestyle services.**

Zencare is a cross-platform Flutter application (Android, iOS, Web) that lets users discover, book, and pay for home and lifestyle services—from appliance repair and cleaning to salon and carpentry.

---

## Features

- **Home & services**
  - AC services
  - Refrigerator services
  - Washing machine services
  - Water purifier services
  - Chimney repair
  - Cleaning services
  - Pest control
  - Salon (men & women)
  - Carpenter services

- **User experience**
  - Responsive layout (mobile, tablet, desktop)
  - Hero section, how it works, partners, testimonials
  - About us & contact (with web-specific contact flow)

- **Account & booking**
  - Login & registration with OTP
  - Service booking flow
  - Shopping cart and checkout
  - Payment response handling

- **Legal & support**
  - Privacy policy
  - Refund policy
  - Terms and conditions

---

## Tech Stack

- **Framework:** Flutter (SDK `>=3.2.3 <4.0.0`)
- **State:** Provider
- **UI:** Material 3, Google Fonts (Archivo), custom Feather font
- **Key packages:** `carousel_slider`, `flutter_animate`, `flutter_svg`, `http`, `shared_preferences`, `url_launcher`, `app_links`, `webview_flutter`, `pin_code_text_field`, `intl`, `fluttertoast`

---

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel, SDK `>=3.2.3`)
- For Android: Android Studio / VS Code with Android SDK (e.g. compileSdk 36, Java 17)
- For iOS: Xcode (macOS only)
- For Web: Chrome (for `flutter run -d chrome`)

---

## Getting Started

### 1. Clone and enter the project

```bash
git clone <repository-url>
cd zencare
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

**Android:**

```bash
flutter run -d android
```

**iOS (macOS only):**

```bash
flutter run -d ios
```

**Web:**

```bash
flutter run -d chrome
```

**Release builds:**

```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios

# Web
flutter build web
```

---

## Project Structure

```
lib/
├── main.dart                 # App entry, theme, routes
├── common/
│   ├── appbar.dart          # Shared app bar
│   ├── footer.dart          # Shared footer
│   └── Toast.dart           # Toast helper
├── features/
│   ├── Home/
│   │   └── screens/         # home, hero_section, works, about_us, contact_us, etc.
│   ├── Services/
│   │   ├── screens/         # AC, Refrigerator, Cleaning, Salon, PestControl, etc.
│   │   └── widgets/         # Service grids, ServiceCard, Packages
│   ├── auth/                # login_page, login_otp_page, register_page, register_otp_dialog
│   ├── bookings/            # book_service
│   ├── checkout/            # shopping_cart, payment_response
│   ├── policies/            # privacy_policy, refund_policy, terms_and_conditions
│   └── controller.dart     # Cart state (e.g. CartData)
assets/                      # Images, icons, fonts (see pubspec.yaml)
android/                     # Android project
ios/                         # iOS project
```

---

## Configuration

- **App icon:** Configured in `pubspec.yaml` under `flutter_launcher_icons` (e.g. `assets/img/logos.jpg`).
- **Assets:** All asset paths are declared in `pubspec.yaml` under `flutter.assets`.
- **Theme:** Primary theme and typography are set in `main.dart` (Material 3, Archivo, seed color).

---

## Version

Current version: **1.0.0+1** (see `pubspec.yaml`).

---

## Documentation

- [Flutter documentation](https://docs.flutter.dev/)
- [Flutter cookbook](https://docs.flutter.dev/cookbook)
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
