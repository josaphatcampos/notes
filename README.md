# 🗒️ Cocus Notes

**Cocus Notes** is a cross-platform note-taking application (**Web**, **Android**, **iOS**) built
with **Flutter**.
The project was developed as a **technical challenge**, demonstrating a **production-ready**
codebase with:

* ✅ **Clean Architecture**
* 🎨 **Custom Design System**
* 🧩 **Modular structure**
* 🧪 **Comprehensive automated testing**

This ensures a scalable, maintainable, and consistent user experience across all platforms.

---

## ✨ Main Features

* **Complete Note Management:** Create, edit, view, and delete notes with Markdown formatting
  support.
* **Advanced Organization:** Link notes together to build a connected knowledge base.
* **Search and Sorting:** Quickly find notes with full-text search and sort by title or date.
* **Attachment Support:** Add images or files to your notes with thumbnail previews.
* **PDF Export:** Export any note to a PDF file with a single click.
* **Multi-language:** Supports **Portuguese** 🇵🇹 and **English** 🇺🇸, easily extendable to other
  languages.
* **Responsive Design:** Optimized layouts for **web/desktop** and **mobile** screens.
* **Local Persistence:** Notes are securely stored offline using **Hive**.

---

## 🏛️ Architecture and Project Structure

The project strictly follows **Clean Architecture**, organizing the code into three layers for clear
separation of concerns:

### 🧠 Domain Layer

*Contains pure business logic.*
Includes:

* **Entities** (`Note`, `NoteAttachment`)
* **Use Cases** (`AddNote`, `DeleteNote`, `LinkNote`, `SyncNotes`, etc.)

### 💾 Data Layer

*Implements data access and persistence.*
Responsible for communicating with:

* **Local storage:** Hive
* **Cloud APIs (Firebase):** Firestore, Storage, Auth

### 🎨 Presentation Layer

*Handles UI and user interaction.*

* Built with **Flutter**
* Uses the **Provider** state management pattern
* Implements a modular and responsive design

---

## 🎨 Design System (DS)

A fully custom **Design System** located in `/shared/design_system`, defining:

* **Colors** → `DSColors`
* **Typography** → `DSTypography`
* **Spacing** → `DSSpacing`
* **Sizes** → `DSSizes`
* **Reusable components** → `DSButton`, `DSChip`, `DSIconButton`, `DSDialog`, etc.

This guarantees a consistent visual identity and makes theming or future rebranding effortless.

---

## 🧪 Testing

Cocus Notes includes a **complete suite of unit tests** covering all use cases:

| Layer        | Coverage                                                                                         |
|--------------|--------------------------------------------------------------------------------------------------|
| Domain       | ✅ Entities & Use Cases (`AddNote`, `UpdateNote`, `DeleteNote`, `SearchNotes`, `SyncNotes`, etc.) |
| Data         | ✅ Repository mocks and behavior verification                                                     |
| Presentation | ⚙️ Ready for widget/integration tests                                                            |

Tests are written with:

* [`flutter_test`](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
* [`mockito`](https://pub.dev/packages/mockito) for mocking dependencies
* [`build_runner`](https://pub.dev/packages/build_runner) for mock generation

**Run all tests:**

```bash
flutter test
```

**Regenerate mocks:**

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🛠️ Technologies and Dependencies

Main technologies used (see `pubspec.yaml`):

* **Framework:** [Flutter](https://flutter.dev/)
* **State Management:** [Provider](https://pub.dev/packages/provider)
* **Navigation:** [go_router](https://pub.dev/packages/go_router)
* **Database:** [Hive](https://pub.dev/packages/hive)
* **Cloud (Firebase):**

    * `firebase_core`
    * `firebase_auth`
    * `cloud_firestore`
    * `firebase_storage`
* **Internationalization (i18n):
  ** [flutter_localizations](https://pub.dev/packages/flutter_localizations), `intl`
* **Markdown & PDF:
  ** [markdown_widget](https://pub.dev/packages/markdown_widget), [pdf](https://pub.dev/packages/pdf)
* **Linting & Analysis:** `flutter_lints`, `very_good_analysis`
* **Code Generation:** `build_runner`, `hive_generator`

---

## 🚀 How to Run the Project

### **Prerequisites**

* [Flutter SDK](https://flutter.dev/docs/get-started/install) `^3.9.2` or higher
* A compatible IDE (VS Code / Android Studio)

### **Steps**

1. **Clone the repository:**

   ```bash
   git clone https://github.com/josaphat-campos/cocus.git
   cd cocus
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run code generation and localization:**

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   flutter gen-l10n
   ```

4. **Run the app:**

   ```bash
   flutter run -d chrome
   ```

5. **Build for Web (release):**

   ```bash
   flutter build web
   ```

---

## 🧱 Project Highlights

* **Clean Architecture** for maintainable, testable code
* **Design System** ensuring UI consistency
* **Full unit test coverage** across use cases
* **Firebase-ready** for syncing and cloud storage
* **Localization-ready** (`en` / `pt`)
* **Responsive Web-first design**

---

## 🧑‍💻 Author

**Josaphat Campos (Jo Campos)**
📍 Flutter / Mobile Developer
🎸 Heavy Metal Guitarist & Creative Technologist
🔗 [github.com/josaphat-campos](https://github.com/josaphat-campos)
