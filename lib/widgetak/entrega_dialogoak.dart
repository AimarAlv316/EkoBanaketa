import 'dart:math';

import 'package:flutter/material.dart';
import '../utilidades/hiztegia.dart';
import '../utilidades/konstanteak.dart';

class EntregaDialogoak {
  static void erakutsiEntregaDialogoa(
      BuildContext context,
      String kokalekua,
      Function onEntregaOnartu,
      ) {
    final distantzia = 1.0 + (Random().nextDouble() * 2.0);
    final bateriaErabilita = distantzia * 12.0;
    final irabaziak = distantzia * 40.0;
    final entregaDenbora = (distantzia * 30).round();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${Hiztegia.banatu} $kokalekua?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${Hiztegia.distantzia}: ${distantzia.toStringAsFixed(1)}${HiztegiaTechnical.km}'),
            Text('${Hiztegia.bateriaBehar}: ${bateriaErabilita.round()}%'),
            Text('${Hiztegia.denbora}: ${entregaDenbora}${HiztegiaTechnical.segundo}'),
            Text('${Hiztegia.irabazi}: ${irabaziak.round()}€'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Hiztegia.utzi),
          ),
          TextButton(
            onPressed: () {
              onEntregaOnartu();
              Navigator.pop(context);
            },
            child: Text(Hiztegia.onartu),
          ),
        ],
      ),
    );
  }

  static void erakutsiEntregaProgresua(
      BuildContext context,
      String kokalekua,
      int denbora,
      ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('⌛ ${Hiztegia.banatzen}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${Hiztegia.helmuga}: $kokalekua'),
            Text('${Hiztegia.denbora.split(":")[0]} gelditzen: ${denbora}s'),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Hiztegia.jarraitu),
          ),
        ],
      ),
    );
  }
}