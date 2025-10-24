// widgets/kontrol_botoia.dart
import 'package:flutter/material.dart';

class KontrolBotoia extends StatelessWidget {
  final IconData ikonoa;
  final VoidCallback sakatuta;
  final Color kolorea;

  const KontrolBotoia({
    Key? key,
    required this.ikonoa,
    required this.sakatuta,
    this.kolorea = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sakatuta,
      child: Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: kolorea,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: kolorea.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          ikonoa,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}