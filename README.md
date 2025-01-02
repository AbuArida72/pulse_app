# PULSE

PULSE is a Flutter-based application designed to streamline drug management and user interaction. This project is integrated with Firebase for backend services, making it a robust solution for managing drugs, orders, and user profiles.

## Features

Drug Management: Display, search, and filter drugs with advanced query capabilities.

Cart & Checkout: Seamless cart management with real-time updates.

Order Tracking: Track orders with detailed statuses, including pending, partial, and approved.

User Profiles: Manage user details and preferences.

Payment Integration: Add and manage payment methods securely.

Responsive UI: Supports multiple platforms including Android, iOS, web, and desktop.

Firebase Integration: Real-time database and authentication.

##Installation

Prerequisites

Install Flutter: Flutter Installation Guide

Set up Firebase project: Firebase Setup Guide

Install Dart SDK

Steps

Clone the repository:

git clone https://github.com/AbuArida72/pulse_app.git

Navigate to the project directory:

cd pulse_app

##Install dependencies:

flutter pub get

Configure Firebase:

Add google-services.json to the android/app directory.

Add GoogleService-Info.plist to the ios/Runner directory.

Run the app:

flutter run

Directory Structure

PULSE/
├── lib/                  # Application logic
│   ├── screens/          # UI screens
│   ├── helpers/          # Utility classes and constants
│   ├── widgets/          # Reusable components
│   └── main.dart         # Entry point
├── assets/               # Static assets
├── android/              # Android-specific code
├── ios/                  # iOS-specific code
├── web/                  # Web-specific code
├── pubspec.yaml          # Project configuration and dependencies
├── firebase.json         # Firebase configuration
└── README.md             # Project documentation

Dependencies

Key dependencies used in this project:

firebase_auth: Firebase authentication

cloud_firestore: Firebase Firestore integration

flutter_bloc: State management

provider: Dependency injection and state management

Refer to pubspec.yaml for the complete list.

Documentation

For detailed documentation, please refer to the PULSE Documentation.

Screenshots

Include screenshots or GIFs of the app in action to make the README visually appealing.

Contribution

Fork the repository.

Create a new branch for your feature:

git checkout -b feature-name

Commit your changes:

git commit -m "Add feature-name"

Push the branch:

git push origin feature-name

Open a pull request.

License

This project is licensed under the MIT License. See LICENSE for details.

For any queries or feedback, feel free to contact the repository owner.
