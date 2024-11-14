# Bananize Mobile App

Bananize is a fun and interactive Flutter-based quiz game that challenges users with math questions. Players must solve each question within a limited time, scoring points for correct answers, and leveling up as they progress. This project includes combo mechanics for consecutive correct answers, a score tracker, a life counter, and more. The game fetches questions from an external API, making each round unique.

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Timer-Based Gameplay:** Answer each question within a limited time.
- **Combo Mechanic:** Score bonus points with consecutive correct answers.
- **Level Progression:** Level up based on your total score.
- **API Integration:** Fetches unique questions from an external API.
- **Game Over Mechanic:** Game ends when you lose all lives, with an option to restart.
- **Play/Pause Timer:** Allows the user to pause and resume the game.

## Screenshots

<!-- Add screenshots of the app here -->

| Home Screen              | Gameplay Screen                  |
| ------------------------ | -------------------------------- |
| ![Home](images/home.png) | ![Gameplay](images/gameplay.png) |

## Technologies Used

- **Flutter**: Framework for building natively compiled mobile applications.
- **Firebase**: Backend services including authentication and real-time database.
- **HTTP**: Fetch data from an API using the `http` package.

## Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase Project](https://firebase.google.com/) (for storing usernames and passwords)
- Android Studio or Xcode for emulating Android/iOS devices

### Steps

1. Clone the repository:
   ````
   git clone https://github.com/username/bananize_mobile_app.git
   cd bananize_mobile_app
   ````
2. Install dependencies:
   `flutter pub get`
3. Set up Firebase:
   - Create a Firebase project.
   - Enable Authentication and Firestore Database in Firebase Console.
   - Download the google-services.json (for Android) or GoogleService-Info.plist (for iOS)files and place them in their respective folders in your project.
4. Run the app on an emulator or connected device:
   `flutter run`

### Usage

- Open the app and start the quiz game.
- Each question comes with a timer; submit answers before time runs out.
- Check your score, lives, and combo status on the gameplay screen.
- Try to reach the highest level by maintaining high accuracy.

## Folder Structure

`bananize_mobile_app/
│
├── lib/
│ ├── main.dart # Entry point of the app
│ ├── screens/ # App screens
│ │ ├── home_screen.dart
│ │ └── gameplay_screen.dart
│ ├── widgets/ # Reusable UI components
│ │ └── heart_icon.dart
│ ├── services/ # API and Firebase services
│ │ ├── api_service.dart
│ │ └── firebase_service.dart
│ └── models/ # Data models
│ └── question_model.dart
│
├── assets/ # Images and other assets
│
├── pubspec.yaml # Dependencies
│
└── README.md`

## Contributing

Contributions are welcome! Here’s how you can help:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes and push to your branch.
4. Create a pull request with a detailed description of your changes.

## License

This project is licensed under the MIT License.

### Note:

- Replace `https://github.com/thecodemonster1/bananize_mobile_app.git` with your repository's URL.
- Add actual images to the `Screenshots` section, if available, or add placeholder image links.
- Update Firebase integration details as needed, depending on the data you’re storing.
