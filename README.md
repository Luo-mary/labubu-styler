# Labubu Styler - AI-Powered Character Styling App

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![OpenAI](https://img.shields.io/badge/OpenAI-412991?style=for-the-badge&logo=openai&logoColor=white)](https://openai.com)

A Flutter application that transforms Labubu character images with AI-generated styles using OpenAI's powerful image generation technology.

## 🎨 Features

- **AI-Powered Styling**: Transform Labubu characters with natural language style descriptions
- **Character Gallery**: Pre-loaded collection of adorable Labubu characters
- **Natural Language Input**: Describe styles in plain text (e.g., "cyberpunk with neon lights")
- **Cross-Platform**: Runs on iOS, Android, Web, macOS, Windows, and Linux
- **Offline Character Selection**: Browse and select characters without internet
- **High-Quality Output**: Generate stunning AI-styled images
- **Save & Share**: Download styled images to your device

## 📸 Screenshots

*Coming soon*

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.9.0-235.0.dev)
- Dart SDK (>=3.9.0)
- OpenAI API key
- Platform-specific requirements:
  - **iOS**: Xcode 14.0+, iOS 12.0+
  - **Android**: Android Studio, SDK 21+
  - **macOS**: macOS 10.14+
  - **Web**: Chrome, Safari, or Firefox

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/labubu_styler_app.git
   cd labubu_styler_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure OpenAI API**
   
   Update the API key in `lib/services/openai_service.dart`:
   ```dart
   static const String _apiKey = 'YOUR_OPENAI_API_KEY';
   ```

4. **Run the app**
   ```bash
   # iOS Simulator
   flutter run -d iPhone
   
   # Android Emulator
   flutter run -d android
   
   # Chrome
   flutter run -d chrome
   
   # macOS
   flutter run -d macos
   ```

## 📁 Project Structure

```
labubu_styler/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── config/
│   │   └── app_config.dart          # App configuration
│   ├── models/
│   │   ├── labubu_image.dart        # Labubu image model
│   │   ├── labubu_style.dart        # Style attributes model
│   │   ├── user.dart                # User model
│   │   └── credit_package.dart      # Credit package model
│   ├── screens/
│   │   ├── image_gallery_screen.dart # Character selection
│   │   └── styling_screen.dart       # Style input & generation
│   ├── services/
│   │   └── openai_service.dart       # OpenAI API integration
│   └── widgets/
│       ├── labubu_avatar.dart        # Character display widget
│       ├── ai_generated_image.dart   # AI result display
│       └── styled_labubu_view.dart   # Styled image viewer
├── assets/
│   └── labubu_images/                # Pre-loaded characters
├── ios/                              # iOS specific files
├── android/                          # Android specific files
├── web/                              # Web specific files
├── macos/                            # macOS specific files
├── windows/                          # Windows specific files
└── linux/                            # Linux specific files
```

## 🔧 Configuration

### API Configuration

Create a `lib/config/app_config.dart` file:

```dart
class AppConfig {
  static const String openAiApiKey = 'YOUR_API_KEY';
  // Add other configuration as needed
}
```

### Adding New Characters

1. Add images to `assets/labubu_images/`
2. Update `pubspec.yaml` to include new assets
3. Add entries in `ImageGalleryScreen._initializeImages()`

## 🎯 Usage

1. **Select a Character**: Browse the gallery and tap on a Labubu character
2. **Describe the Style**: Enter a natural language description (e.g., "steampunk with gears and bronze")
3. **Generate**: Tap the generate button to create your styled image
4. **Save**: Download the result to your device

### Style Examples

- "Cyberpunk with neon lights and futuristic elements"
- "Watercolor painting with soft pastels"
- "Vintage 1950s poster art style"
- "Japanese anime style with cherry blossoms"
- "Gothic dark fantasy with purple smoke"

## 🛠️ Development

### Running Tests

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test
```

### Code Quality

```bash
# Run static analysis
flutter analyze

# Format code
dart format .
```

### Building for Production

```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
flutter build appbundle --release

# Web
flutter build web --release

# macOS
flutter build macos --release

# Windows
flutter build windows --release

# Linux
flutter build linux --release
```

## 📝 API Reference

### OpenAI Service

The app uses OpenAI's gpt-image-1 API for image generation:

- **Model**: Uses latest image generation model
- **Style Parsing**: Extracts color, mood, theme, and accessories from user input
- **Image Format**: Returns base64-encoded images

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Commit Convention

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Test additions or changes
- `chore:` Build process or auxiliary tool changes

## 🐛 Troubleshooting

### Common Issues

**Build Failures**
```bash
flutter clean
flutter pub get
cd ios && pod install  # For iOS
```

**API Errors**
- Verify your OpenAI API key is valid
- Check your API quota and billing
- Ensure internet connectivity

**Image Loading Issues**
- Verify assets are properly declared in `pubspec.yaml`
- Run `flutter clean` and rebuild

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev) - The UI framework
- [OpenAI](https://openai.com) - AI image generation
- [Dart](https://dart.dev) - The programming language
- Labubu character creators

## 📧 Support

For support and questions:
- Open an issue on GitHub
- Contact: luojiahuizi86@gmail.com

---

Made with ❤️ by Jiahuizi Luo