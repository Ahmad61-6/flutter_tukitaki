# 🚗 Do Tech – Automotive Marketplace App

**Do Tech** is a responsive Flutter application built for an automotive parts marketplace, vehicle services, and roadside assistance.

The project follows **Clean Architecture principles** with scalable state management and optimized UI performance.

---

# 🛠️ Prerequisites & Environment

Make sure your development environment meets the following requirements:

## ✅ Required Versions

- **Flutter SDK:** >= 3.19.0 (latest stable recommended)
- **Dart SDK:** >= 3.3.0
- **Java:** 17 (Required for Android build)
- **Android compileSdk:** 34

---

# 📦 Core Dependencies

- `get: ^4.6.6` → State management, dependency injection & routing
- `shimmer: ^3.0.0` → Skeleton loading effects
- **Firebase BoM:** 34.9.0
- **Google Play Services Auth:** 21.5.1

---

# 🚀 Setup & Run Instructions

## 1️⃣ Clone the Repository

```bash
git clone <your-repository-url>
cd do_tech
```

## 2️⃣ Install Dependencies

```bash
flutter pub get
```
3️⃣ Run the App

Make sure an emulator is running or a physical device is connected.

flutter run
## 📦 Build Release APK

To build a release APK:

flutter build apk

Make sure:

A valid .jks keystore is generated

key.properties is configured inside the android/ directory

## 🔐 Test Credentials (Mock Backend)

The project currently uses an in-memory mock database for authentication and data simulation.

##🔑 Login Credentials

You can log in using:

Email: test@example.com

Username: testuser
Password: password123

You can use either email or username in the first field.

## 📝 Signup Behavior

You can register with any email, username, and password.

The app will log you in successfully.

The session will persist during runtime.

⚠️ Important

The mock database exists only in memory (RAM).
If you completely close the app, newly registered users will be erased.
Only the default hardcoded test user remains.

🧠 Important Technical Decisions
## 1️⃣ State Management – GetX

We use GetX for:

State management

Dependency injection

Route management

Controllers handle business logic while UI remains clean and lightweight.

Lazy initialization ensures controllers are only created when needed.

## 2️⃣ Seamless Tab Navigation – IndexedStack

Bottom navigation uses IndexedStack.

Why?

Preserves scroll position

Prevents unnecessary rebuilds

Avoids repeated API calls

Keeps tab state alive

## 3️⃣ Premium Loading Experience – Shimmer

Instead of traditional loaders, the app uses shimmer skeletons.

Benefits:

Better perceived performance

More polished UI experience

Layout-consistent loading states

## 4️⃣ Fully Responsive UI

Custom responsive extensions:
```text
.w   → width scaling  
.h   → height scaling  
.sp  → font scaling  
.r   → radius scaling  
```
Ensures consistent design across all device sizes.

## 5️⃣ Clean Separation of Concerns

AuthController → Manages persistent session state

Feature Controllers → Handle screen-specific logic

This prevents business logic from mixing with UI state.

📂 Project Structure Overview
```text
lib/
├── core/
├── features/
├── main.dart
```

core/ → Common utilities, themes, constants

features/ → Modular feature-based architecture

main.dart → Entry point

## 📌 Summary

✔ Clean Architecture
✔ GetX State Management
✔ Responsive UI
✔ IndexedStack Navigation
✔ Shimmer Loading
✔ Mock Backend Ready
✔ Scalable & Production-Ready Structure