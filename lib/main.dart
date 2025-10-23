import 'package:flutter/material.dart';
import 'pantailak/mapa_pantailak.dart';
import 'package:erronka/modeloak/entrega.dart';
import 'package:erronka/modeloak/ibilgailua.dart';
import 'package:erronka/main.dart';
import 'package:erronka/besteak/hiztegia.dart';
import '';

void main() {
  runApp(EkoBanaketaApp());
}

class EkoBanaketaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eko Banaketa',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MapaPantaila(),
    );
  }
}