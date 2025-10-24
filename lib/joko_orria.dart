// joko_orria.dart
import 'package:flutter/material.dart';
import 'suge_joko_logika.dart';
import 'widgets/kontrol_botoia.dart';
import 'suge_mota.dart';
import 'pantaila_hasi.dart';

class JokoOrria extends StatefulWidget {
  final SugeMota sugeMota;
  final int zailtasuna;

  const JokoOrria({
    Key? key,
    required this.sugeMota,
    required this.zailtasuna,
  }) : super(key: key);

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
      abiadura: widget.zailtasuna,
    );
    jokoLogika.hasiJokoa();
  }

  void _bueltatuHasierara() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PantailaHasi()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suge Jokoa',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(Icons.score, color: Colors.grey[700]),
                SizedBox(width: 8),
                Text(
                  '${jokoLogika.puntuak}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
          onPressed: _bueltatuHasierara,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Jolas eremua
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[50],
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
                    margin: EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                      color: widget.sugeMota.buruKolorea,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                } else if (jokoLogika.sugeGorputza.contains(posizioa)) {
                  return Container(
                    margin: EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                      color: widget.sugeMota.gorputzKolorea,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                } else if (jokoLogika.janaria == posizioa) {
                  return Container(
                    margin: EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.circle, color: Colors.white, size: 10),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(1),
                    ),
                  );
                }
              },
            ),
          ),

          // Kontrolak
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Kontrol botoiak
                      Column(
                        children: [
                          KontrolBotoia(
                            ikonoa: Icons.arrow_upward,
                            sakatuta: () => jokoLogika.aldatuNorabidea(Norabidea.GORA),
                            kolorea: widget.sugeMota.buruKolorea,
                          ),
                          Row(
                            children: [
                              KontrolBotoia(
                                ikonoa: Icons.arrow_left,
                                sakatuta: () => jokoLogika.aldatuNorabidea(Norabidea.EZKERRA),
                                kolorea: widget.sugeMota.buruKolorea,
                              ),
                              SizedBox(width: 50),
                              KontrolBotoia(
                                ikonoa: Icons.arrow_right,
                                sakatuta: () => jokoLogika.aldatuNorabidea(Norabidea.ESKUMA),
                                kolorea: widget.sugeMota.buruKolorea,
                              ),
                            ],
                          ),
                          KontrolBotoia(
                            ikonoa: Icons.arrow_downward,
                            sakatuta: () => jokoLogika.aldatuNorabidea(Norabidea.BEHERA),
                            kolorea: widget.sugeMota.buruKolorea,
                          ),
                        ],
                      ),

                      // Berrabiarazi botoia
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: jokoLogika.jokoaBukatuta ? () {
                              jokoLogika.hasiJokoa();
                              setState(() {});
                            } : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.sugeMota.buruKolorea,
                              foregroundColor: Colors.white,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                            ),
                            child: Icon(
                              jokoLogika.jokoaBukatuta ? Icons.refresh : Icons.play_arrow,
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            jokoLogika.jokoaBukatuta ? 'Hasi Berriz' : 'Jolasten',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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