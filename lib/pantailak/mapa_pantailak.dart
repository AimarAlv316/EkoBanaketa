import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../modeloak/ibilgailua.dart';
import '../modeloak/joko_egoera.dart';
import '../besteak/konstanteak.dart';

class MapaPantaila extends StatefulWidget {
  @override
  _MapaPantailaState createState() => _MapaPantailaState();
}

class _MapaPantailaState extends State<MapaPantaila> {
  late JokoEgoera jokoEgoera;
  late Timer denboraTimer;

  @override
  void initState() {
    super.initState();
    jokoEgoera = JokoEgoera(
      dirua: 350.0,
      bateria: 100.0,
      unekoIbilgailua: Konstanteak.eskuragarriIbilgailuak[0],
      jabeIbilgailuak: [Konstanteak.eskuragarriIbilgailuak[0]],
    );

    denboraTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    denboraTimer.cancel();
    super.dispose();
  }

  void _kokalekuaSakatu(String kokalekua) {
    print('CLICK EN: $kokalekua');

    if (kokalekua.startsWith('Etxea')) {
      _erakutsiEntregaDialogoa(kokalekua);
    } else if (kokalekua == 'Bulego Nagusia') {
      _erakutsiBulegoaDialogoa();
    } else if (kokalekua == 'Denda') {
      _erakutsiDendaDialogoa();
    }
  }

  void _erakutsiEntregaDialogoa(String etxea) {
    final distantzia = 1.0 + (Random().nextDouble() * 2.0);
    final bateriaErabilita = distantzia * 12.0;
    final irabaziak = distantzia * 40.0;
    final entregaDenbora = (distantzia * 30).round();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Banatu hemen? $etxea?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Distantzia: ${distantzia.toStringAsFixed(1)}km'),
            Text('Bateria behar da: ${bateriaErabilita.round()}%'),
            Text('Denbora: ${entregaDenbora}s'),
            Text('Irabaziko duzu: ${irabaziak.round()}€'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Utzi'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _hasiEntrega(etxea, bateriaErabilita, irabaziak, entregaDenbora);
            },
            child: Text('Onartu'),
          ),
        ],
      ),
    );
  }

  void _hasiEntrega(String etxea, double bateriaErabilita, double irabaziak, int denbora) {
    print('ENTREGA INICIADA: $etxea');

    setState(() {
      jokoEgoera.bateria -= bateriaErabilita;
      jokoEgoera.dirua += irabaziak;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Entrega hasita: $etxea')),
    );
  }

  void _erakutsiBulegoaDialogoa() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🏢 Bulego Nagusia'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.electric_car),
              title: Text('Erosi Ibilgailu Berria'),
              onTap: () {
                Navigator.pop(context);
                _erosiIbilgailuBerria();
              },
            ),
            ListTile(
              leading: Icon(Icons.battery_charging_full),
              title: Text('Erosi Bateria Berria (300€)'),
              onTap: () {
                Navigator.pop(context);
                _erosiBateriaBerria();
              },
            ),
            ListTile(
              leading: Icon(Icons.ev_station),
              title: Text('Kargatu Ibilgailua'),
              onTap: () {
                Navigator.pop(context);
                _kargatuIbilgailua();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _erosiIbilgailuBerria() {
    setState(() {
      jokoEgoera.dirua -= 200;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ibilgailu berria erosita!')),
    );
  }

  void _erosiBateriaBerria() {
    if (jokoEgoera.dirua >= 300) {
      setState(() {
        jokoEgoera.dirua -= 300;
        jokoEgoera.bateria = 100.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bateria berria erosita!')),
      );
    }
  }

  void _kargatuIbilgailua() {
    setState(() {
      jokoEgoera.bateria = 100.0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ibilgailua kargatuta!')),
    );
  }

  void _erakutsiDendaDialogoa() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🛒 Denda'),
        content: Text('Laster: hobekuntzak eta osagarriak'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Itxi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eko Banaketa'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Barra de estado SIMPLE
          Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('💰 ${jokoEgoera.dirua.round()}€'),
                  Text('🔋 ${jokoEgoera.bateria.round()}%'),
                  Text('🛴 ${jokoEgoera.unekoIbilgailua.izena}'),
                ],
              ),
            ),
          ),

          // Mapa
          Expanded(
            child: Stack(
              children: [
                // Fondo del mapa
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.green[50]!, Colors.blue[50]!],
                    ),
                  ),
                ),

                // Ubicaciones
                ...Konstanteak.kokalekuPosizioak.entries.map((sarrera) {
                  return Positioned(
                    left: sarrera.value['x']! * MediaQuery.of(context).size.width - 25,
                    top: sarrera.value['y']! * MediaQuery.of(context).size.height - 25,
                    child: GestureDetector(
                      onTap: () => _kokalekuaSakatu(sarrera.key),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: sarrera.key == 'Bulego Nagusia' ? Colors.blue :
                          sarrera.key == 'Denda' ? Colors.orange : Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Center(
                          child: Text(
                            sarrera.key == 'Bulego Nagusia' ? '🏢' :
                            sarrera.key == 'Denda' ? '🛒' : '🏠',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}