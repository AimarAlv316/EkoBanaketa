// joko_orria.dart
import 'package:flutter/material.dart';
import 'suge_joko_logika.dart';
import 'widgets/kontrol_botoia.dart';

class JokoOrria extends StatefulWidget {
  @override
  _JokoOrriaState createState() => _JokoOrriaState();
}

class _JokoOrriaState extends State<JokoOrria> {
  late SugeJokoLogika jokoLogika;

  @override
  void initState() {
    super.initState();
    jokoLogika = SugeJokoLogika(
      onJokoaEguneratu: () => setState(() {}),
    );
    jokoLogika.hasiJokoa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Snake Jokoa'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text('Puntuak: ${jokoLogika.puntuak}'),
          ),
        ],
      ),
      body: Column(
        children: [
          // ALDATUTA: Jolas eremua txikiagoa
          Container(
            height: MediaQuery.of(context).size.height * 0.6, // Altuera mugatu
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: jokoLogika.zutabeKopurua,
              ),
              itemCount: jokoLogika.zutabeKopurua * jokoLogika.errenkadaKopurua,
              itemBuilder: (context, index) {
                final x = index % jokoLogika.zutabeKopurua;
                final y = index ~/ jokoLogika.zutabeKopurua;
                final posizioa = Offset(x.toDouble(), y.toDouble());

                if (jokoLogika.sugeBurua == posizioa) {
                  return Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                } else if (jokoLogika.sugeGorputza.contains(posizioa)) {
                  return Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                } else if (jokoLogika.janaria == posizioa) {
                  return Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(1),
                    ),
                  );
                }
              },
            ),
          ),
          // ALDATUTA: Botoien atala egokitu
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Kontrolak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ezkerreko kontrolak
                      Column(
                        children: [
                          SizedBox(height: 20),
                          KontrolBotoia(
                            ikonoa: Icons.arrow_upward,
                            sakatuta: () => jokoLogika.aldatuNorabidea(Norabidea.GORA),
                          ),
                          Row(
                            children: [
                              KontrolBotoia(
                                ikonoa: Icons.arrow_left,
                                sakatuta: () => jokoLogika.aldatuNorabidea(Norabidea.EZKERRA),
                              ),
                              SizedBox(width: 50),
                              KontrolBotoia(
                                ikonoa: Icons.arrow_right,
                                sakatuta: () => jokoLogika.aldatuNorabidea(Norabidea.ESKUMA),
                              ),
                            ],
                          ),
                          KontrolBotoia(
                            ikonoa: Icons.arrow_downward,
                            sakatuta: () => jokoLogika.aldatuNorabidea(Norabidea.BEHERA),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      // Berrabiarazi botoia
                      ElevatedButton(
                        onPressed: jokoLogika.jokoaBukatuta ? () {
                          jokoLogika.hasiJokoa();
                          setState(() {});
                        } : null,
                        child: Text(jokoLogika.jokoaBukatuta ? 'Hasi Berriz' : 'Jolasten...'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    jokoLogika.dispose();
    super.dispose();
  }
}