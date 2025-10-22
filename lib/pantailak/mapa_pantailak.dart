import 'package:flutter/material.dart';
import '../widgetak/egoera_barra.dart';
import '../widgetak/entrega_dialogoak.dart';
import '../widgetak/bulego_dialogoak.dart';
import '../modeloak/ibilgailua.dart';
import '../utilidades/konstanteak.dart';
import '../utilidades/hiztegia.dart';

class MapaPantaila extends StatefulWidget {
  @override
  _MapaPantailaState createState() => _MapaPantailaState();
}

class _MapaPantailaState extends State<MapaPantaila> {
  late JokoEgoera jokoEgoera;

  @override
  void initState() {
    super.initState();
    jokoEgoera = JokoEgoera(
      dirua: 350.0,
      bateria: 100.0,
      unekoIbilgailua: Konstanteak.eskuragarriIbilgailuak[0],
      jabeIbilgailuak: [Konstanteak.eskuragarriIbilgailuak[0]],
    );
  }

  void _kokalekuaSakatu(String kokalekua) {
    if (kokalekua.startsWith('Etxea')) {
    EntregaDialogoak.erakutsiEntregaDialogoa(context, kokalekua, ()=> _hasiEntrega(kokalekua),
    );
    } else if (kokalekua == 'Bulego nagusia') {
      BulegoDialogoak.erakutsiBulegoAukerak(
        context,
        _erosiIbilgailuBerria,
        _erosiBateriaBerria,
        _kargatuIbilgailua,
      );
    } else if (kokalekua == Hiztegia.denda) {
      _erakutsiDenda();
    }
  }

  void _hasiEntrega(String etxea) {
    // Entrega logika hemen
  }

  void _erosiIbilgailuBerria(Ibilgailua ibilgailua) {
    if (jokoEgoera.dirua >= ibilgailua.prezioa) {
      setState(() {
        jokoEgoera.dirua -= ibilgailua.prezioa;
        jokoEgoera.jabeIbilgailuak.add(ibilgailua);
        jokoEgoera.unekoIbilgailua = ibilgailua;
      });
    }
  }

  void _erosiBateriaBerria() {
    if (jokoEgoera.dirua >= 300) {
      setState(() {
        jokoEgoera.dirua -= 300;
        jokoEgoera.bateria = 100.0;
      });
    }
  }

  void _kargatuIbilgailua() {
    setState(() {
      jokoEgoera.bateria = 100.0;
    });
  }

  void _erakutsiDenda() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🛒 ${Hiztegia.denda}'),
        content: Text('Laster: hobekuntzak eta osagarriak'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Hiztegia.itxi),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Hiztegia.izenburua),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // Mapa fondo
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green[50]!, Colors.blue[50]!],
              ),
            ),
          ),

          // Egoera barra
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: EgoeraBarra(
              dirua: jokoEgoera.dirua,
              bateria: jokoEgoera.bateria,
              unekoIbilgailua: jokoEgoera.unekoIbilgailua,
            ),
          ),

          // Kokalekuak
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
                    color: sarrera.key == Hiztegia.bulegoa ? Colors.blue :
                    sarrera.key == Hiztegia.denda ? Colors.orange : Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Center(
                    child: Text(
                      sarrera.key == Hiztegia.bulegoa ? '🏢' :
                      sarrera.key == Hiztegia.denda ? '🛒' : '🏠',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}