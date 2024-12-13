# Flutter Video Call App

## 📱 Project Overview

A Flutter-based video and call application that enables users to communicate through real-time video and voice calls. The app is built with clean architecture and modern Flutter development practices.

## ✨ Features

- User Authentication (Sign up / Login)
- Real-time Video Calls
- Real-time Voice Calls
- User Profile Management
- Responsive UI Design

## 🖼 Screenshots

<p float="left">
  <img src="https://github.com/user-attachments/assets/9be3b754-ce8d-48a6-b98d-50fca78a8c3b" width="200" />
  <img src="https://github.com/user-attachments/assets/80600473-840c-4992-9769-1b5df81d3c6a" width="200" />
  <img src="https://github.com/user-attachments/assets/1f048afa-0bc3-47a3-a939-a646a73ae8f1" width="200" />
</p>
<p float="left">
 <img src="https://github.com/user-attachments/assets/c0db2876-26ab-49ab-b4ae-87791adb9749" width="200" />
  <img src="https://github.com/user-attachments/assets/bf3fc207-c7a4-414f-b58c-9b9a02e0905e" width="200" />
  <img src="https://github.com/user-attachments/assets/5045f4e6-b70a-4995-88b1-106c471d74b9" width="200" />
</p>

## 🛠 Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: BLoC
- **Backend**:
    - Firebase Authentication
    - Firebase Firestore
- **Call SDK**: ZegoCloud
- **Architecture**: Clean Architecture

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio or VS Code
- Firebase Account
- ZegoCloud Account

### Installation

1. Clone the repository
```bash
git clone https://github.com/AhmadAbbas8/video-call-chat-app.git
```

2. Navigate to the project directory
```bash
cd your-repo-name
```

3. Install dependencies
```bash
flutter pub get
```

4. Configure Firebase
- Create a Firebase project
- Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
- Update Firebase configurations

5. Configure ZegoCloud
- Obtain App ID and App Sign
- Update SDK configurations

6. Run the app
```bash
flutter run
```

## 📂 Project Structure

```
lib/
│
├── core/
│   ├── error/
│   └── usecases/
│
├── features/
│   ├── authentication/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── video_call/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📋 TODO

- [ ] Add more unit tests
- [ ] Implement group call functionality
- [ ] Add end-to-end encryption
- [ ] Improve error handling


## 📞 Contact

Ahmad Abbas - ahmadabbass822@gmail.com
