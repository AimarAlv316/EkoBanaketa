// main.dart
import 'package:flutter/material.dart';
import 'pantaila_hasi.dart';

void main() {
  runApp(SugeJokoaApp());
}

class SugeJokoaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Snake Jokoa',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          foregroundColor: Colors.grey[800],
        ),
      ),
      home: PantailaHasi(),
    );
  }
}