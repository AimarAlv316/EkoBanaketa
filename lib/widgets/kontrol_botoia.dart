// widgets/kontrol_botoia.dart
import 'package:flutter/material.dart';

class KontrolBotoia extends StatelessWidget {
  final IconData ikonoa;
  final VoidCallback sakatuta;

  const KontrolBotoia({
    Key? key,
    required this.ikonoa,
    required this.sakatuta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sakatuta,
      child: Container(
        width: 50,  // ALDATUTA: Txikiagoa
        height: 50, // ALDATUTA: Txikiagoa
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          ikonoa,
          color: Colors.white,
          size: 24, // ALDATUTA: Txikiagoa
        ),
      ),
    );
  }
}