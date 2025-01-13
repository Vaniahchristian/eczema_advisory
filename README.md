# Eczema Advisory App

A Flutter-based mobile application designed to help users manage and monitor their eczema condition, connect with healthcare providers, and receive personalized treatment recommendations.

## Features

### 🔐 Authentication
- Simple email/password login interface
- User registration functionality
- Secure session management

### 🏠 Dashboard
- Quick access to key features
- Recent activity tracking
- Personalized recommendations
- Treatment reminders

### 📸 Diagnosis
- Photo-based eczema analysis
- Camera integration for new photos
- Gallery access for existing photos
- Diagnosis history tracking
- Severity assessment
- Location tracking of affected areas
- Treatment recommendations

### 💬 Doctor Communication
- Real-time chat interface
- File and photo sharing
- Appointment scheduling
- Video call support (planned)
- Message history

### 👤 Profile Management
- Personal information
- Medical history
- Treatment preferences
- Privacy settings

## Project Structure

```
lib/
├── main.dart              # App entry point and navigation setup
├── screens/              # All app screens
│   ├── auth/            # Authentication screens
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/            # Main dashboard
│   │   └── home_screen.dart
│   ├── diagnosis/       # Eczema diagnosis features
│   │   └── diagnosis_screen.dart
│   ├── chat/           # Doctor communication
│   │   └── chat_screen.dart
│   └── profile/        # User profile
│       └── profile_screen.dart
└── widgets/            # Reusable UI components
    ├── custom_button.dart
    └── custom_text_field.dart
```

## Technical Details

### UI Components
- Material Design 3 implementation
- Custom widgets for consistency
- Responsive layouts
- Cross-platform compatibility
- Accessibility features

### State Management
- Local state using `setState`
- Future implementation planned:
  - Provider for app-wide state
  - Secure storage for user data
  - Real-time updates for chat

### Navigation
- Bottom navigation bar
- Push/pop navigation stack
- Named routes for key screens
- Deep linking support (planned)

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or VS Code
- iOS/Android emulator or physical device

### Installation
1. Clone the repository:
```bash
git clone https://github.com/yourusername/eczema_advisory.git
```

2. Navigate to the project directory:
```bash
cd eczema_advisory
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

### Development Setup
1. Enable Flutter web support (optional):
```bash
flutter config --enable-web
```

2. Check setup status:
```bash
flutter doctor
```

## Current Status
- UI/UX implementation complete
- Using dummy data for demonstration
- Core navigation implemented
- Basic features functional

## Planned Features
- [ ] Backend integration
- [ ] Real authentication system
- [ ] Image processing AI for diagnosis
- [ ] Real-time chat implementation
- [ ] Appointment scheduling system
- [ ] Push notifications
- [ ] Offline support
- [ ] Data synchronization
- [ ] Analytics dashboard
- [ ] Export medical records

## Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments
- Flutter team for the amazing framework
- Material Design team for UI guidelines
- Contributors and testers

## Contact
Your Name - [@yourusername](https://twitter.com/yourusername)
Project Link: [https://github.com/yourusername/eczema_advisory](https://github.com/yourusername/eczema_advisory)
