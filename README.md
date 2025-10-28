# Cocus Notes

Cocus Notes is a cross-platform note-taking application (Web, Android, iOS) built with Flutter.
The project was developed as a technical challenge, demonstrating a robust architecture, **Clean
Architecture** principles, and a custom **Design System** for a consistent and modern user
experience.

## ✨ Main Features

* **Complete Note Management:** Create, edit, view, and delete notes with Markdown formatting
  support.
* **Advanced Organization:** Link notes together to create a connected knowledge base.
* **Search and Sorting:** Easily find notes with full-text search and sort the list by title or
  date.
* **Attachment Support:** Add images to your notes (with thumbnail support).
* **PDF Export:** Export any note to a PDF file with a single click.
* **Multi-language:** Supports Portuguese and English, with easy expansion to other languages.
* **Responsive Design:** Interface optimized for large screens (web/desktop) and small screens (
  mobile).
* **Local Persistence:** All notes are saved locally using Hive for fast and secure offline access.

## 🏛️ Architecture and Project Structure

The project follows **Clean Architecture** principles, separating the code into three main layers to
ensure decoupling, testability, and maintainability:

* **Domain:** Contains pure business logic (entities and use cases), without dependencies on
  external frameworks.
* **Data:** Implements data access logic (repositories and data sources), responsible for
  communicating with the local database (Hive) and future APIs.
* **Presentation (UI):** Responsible for displaying the user interface, built with Flutter and using
  the **Provider** state management pattern.

### Design System (DS)

The project includes a custom **Design System** (`/shared/design_system`) that centralizes all
visual definitions, such as:

* **Colors (`DSColors`)**
* **Typography (`DSTypography`)**
* **Spacing (`DSSpacing`)**
* **Sizes (`DSSizes`)**

This ensures visual consistency throughout the entire application and makes future theme changes
easier.

## 🛠️ Technologies and Dependencies

The `pubspec.yaml` file reveals the main technologies used:

* **Framework:** [Flutter](https://flutter.dev/)
* **State Management:** [Provider](https://pub.dev/packages/provider)
* **Navigation:** [go_router](https://pub.dev/packages/go_router) for declarative, URL-based
  navigation.
* **Backend & Cloud (Firebase):**

    * `firebase_core`: General configuration.
    * `firebase_auth`: User authentication.
    * `cloud_firestore`: NoSQL database for note synchronization.
    * `firebase_storage`: Attachment (image) storage.
* **Local Database:** [Hive](https://pub.dev/packages/hive) for performant data persistence.
* **Internationalization (i18n):
  ** [flutter_localization](https://pub.dev/packages/flutter_localization) and `intl` for
  multi-language support.
* **Markdown and PDF:** [markdown_widget](https://pub.dev/packages/markdown_widget) for rendering
  and [pdf](https://pub.dev/packages/pdf) for exporting.
* **Utilities:** `uuid` for ID generation, `path_provider` for file system access, among others.

For the development environment, the following tools were used:

* **Linting:** `flutter_lints` and `very_good_analysis` to ensure code quality and consistency.
* **Code Generation:** `build_runner` and `hive_generator`.

## 🚀 How to Run the Project

**Prerequisites:**

* Have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (version `^3.9.2`
  or higher).
* Use a code editor such as VS Code or Android Studio.

**Steps:**

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
   dart run build_runner build --delete-conflicting-outputs
   flutter gen-l10n
   ```
