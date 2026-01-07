 Inventory Management System

    A high-fidelity Inventory Management Application built with Flutter and Firebase. 
    This project featuring seamless Cloud Firestore integration and optimized user experience (UX) patterns.
     Features

 Real-time Dashboard: Live synchronization with Firebase Firestore to track total product counts and inventory value.

  UX/UI: 
        
        Sliver Animations: Smooth collapsing headers and stretching scroll effects.

        Glassmorphism: Modern UI elements with subtle depth and transparency.

        Organic Palette: A custom-designed Sage Green and Lavender theme for a professional feel.

   Full CRUD Operations:

        Create: Dynamic product registration with form validation.

        Read: Interactive inventory list view.

        Update: Streamlined product editing via a dedicated detail view.

        Delete: Ergonomic Modal Bottom Sheet for safe data removal.

    Secure Authentication: Admin login powered by Firebase Authentication.

 Tech Stack

    Framework: Flutter

    Language: Dart

    Backend: Google Firebase

        Cloud Firestore (NoSQL Database)

        Firebase Auth

    Design Tooling: Custom AppTheme engine.

Project Structure


    lib/
    ├── main.dart                 # Application entry point & Theme initialization
    ├── Theme/
    │   └── appTheme.dart         # Centralized design system (Colors, Typography, Buttons)
    ├── Services/
    │   └── DBOperation/
    │       └── crud_operation.dart # Firebase Firestore logic & Queries
    ├── model/
    │   └── product.model.dart    # Product data entity class
    ├── Screens/
    │   ├── home_screen.dart      # Dashboard with stats and quick actions
    │   ├── view_product.dart     # Scrollable list of all inventory items
    │   ├── add_product.dart      # Form-based product entry with SliverHeader
    │   ├── product_detail.dart   # View/Update/Delete product management
    │   └── login_screen.dart     # Authentication interface
    └── Widgets/
        └── app_drawer.dart       # Custom navigation drawer with profile header

Design Philosophy

    The project follows the "Alabaster & Sage" design language:

    Background: #FAF9F6 (Off-white) to reduce eye fatigue.

    Primary Action: #7F8260 (Sage Green) for a professional, stable feel.

    Secondary/Accent: #BBA1C9 (Dusty Lavender) to highlight interactive elements.

    Corner Radius: Standardized 12px-14px for a modern, approachable software feel.

Setup & Installation

    Clone the repository:
    Bash 
    git clone https://github.com/your-username/your-repo-name.git

Install dependencies:
Bash

    flutter pub get

Firebase Configuration:

    Create a project on the Firebase Console.

    Add an Android/iOS app.

    Download google-services.json (for Android) or GoogleService-Info.plist (for iOS) and place them in the respective directories.

Run the app:
Bash

    flutter run

 Demonstration

    Video Demo: https://drive.google.com/file/d/1jQW1ojxFKq6xF2GxZFn6WgcToGHHNSP6/view?usp=sharing
