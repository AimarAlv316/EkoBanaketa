import 'package:flutter/material.dart';
import 'login_orria.dart';

void main() {
  runApp(SugeJokoaApp());
}

class SugeJokoaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suge Jokoa',
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
      home: LoginOrria(),
    );
  }
}