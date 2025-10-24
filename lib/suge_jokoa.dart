// suge_jokoa.dart
import 'package:flutter/material.dart';
import 'joko_orria.dart';

class SugeJokoa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produktu Bilketa',
      home: JokoOrria(),
    );
  }
}