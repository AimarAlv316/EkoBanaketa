import 'package:flutter/material.dart';
import '../utilidades/hiztegia.dart';
import '../utilidades/konstanteak.dart';
import '../modeloak/ibilgailua.dart';

class BulegoDialogoak {
  static void erakutsiBulegoAukerak(
      BuildContext context,
      Function onIbilgailuaErosi,
      Function onBateriaErosi,
      Function onKargatu,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🏢 ${Hiztegia.aukerak}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.electric_car),
              title: Text(Hiztegia.erosiIbilgailu),
              onTap: () {
                Navigator.pop(context);
                erakutsiIbilgailuKatalogoa(context, onIbilgailuaErosi);
              },
            ),
            ListTile(
              leading: Icon(Icons.battery_charging_full),
              title: Text('${Hiztegia.erosiBateria} (300€)'),
              onTap: () {
                onBateriaErosi();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.ev_station),
              title: Text(Hiztegia.kargatu),
              onTap: () {
                onKargatu();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Hiztegia.itxi),
          ),
        ],
      ),
    );
  }

  static void erakutsiIbilgailuKatalogoa(
      BuildContext context,
      Function onIbilgailuaErosi,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🛒 ${Hiztegia.katalogoa}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: Konstanteak.eskuragarriIbilgailuak.map((ibilgailua) {
            return ListTile(
              title: Text('${ibilgailua.emotikonoa} ${ibilgailua.izena}'),
              subtitle: Text('${ibilgailua.prezioa.round()}€'),
              onTap: () {
                onIbilgailuaErosi(ibilgailua);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}