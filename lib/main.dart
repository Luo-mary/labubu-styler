import 'package:flutter/material.dart';
import 'screens/image_gallery_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const LabubuStylerApp());
}

class LabubuStylerApp extends StatelessWidget {
  const LabubuStylerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labubu Styler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF69B4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ImageGalleryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}