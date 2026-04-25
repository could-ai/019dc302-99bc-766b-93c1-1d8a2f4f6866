import 'package:flutter/material.dart';
import 'screens/main_layout.dart';

void main() {
  runApp(const SmartStudyApp());
}

class SmartStudyApp extends StatelessWidget {
  const SmartStudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Study',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
          primary: Colors.teal,
          secondary: Colors.lightBlue,
          background: const Color(0xFFF4F7F6), // Calm light gray/blue background
          surface: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Default clean font
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const MainLayout(),
    );
  }
}
