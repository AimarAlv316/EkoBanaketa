import 'package:flutter/material.dart';
import '../utilidades/hiztegia.dart';

class KokalekuWidget extends StatelessWidget {
  final String izena;
  final String emotikonoa;
  final Color kolorea;
  final VoidCallback onTap;

  const KokalekuWidget({
    Key? key,
    required this.izena,
    required this.emotikonoa,
    required this.kolorea,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.5, // Posizioa kalkulatu beharko da
      top: 0.5,   // Posizioa kalkulatu beharko da
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: kolorea,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Center(
            child: Text(
              emotikonoa,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}