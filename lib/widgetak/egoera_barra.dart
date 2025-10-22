import 'package:flutter/material.dart';
import '../modeloak/ibilgailua.dart';
import '../utilidades/hiztegia.dart';

class EgoeraBarra extends StatelessWidget {
  final double dirua;
  final double bateria;
  final Ibilgailua unekoIbilgailua;

  const EgoeraBarra({
    Key? key,
    required this.dirua,
    required this.bateria,
    required this.unekoIbilgailua,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('💰 ${dirua.round()}€',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('🔋 ${bateria.round()}%',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${unekoIbilgailua.emotikonoa} ${unekoIbilgailua.izena}',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}