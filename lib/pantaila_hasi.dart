import 'package:flutter/material.dart';
import 'joko_orria.dart';
import 'suge_mota.dart';
import 'login_orria.dart';

class PantailaHasi extends StatefulWidget {
  final String erabiltzaileIzena;

  const PantailaHasi({Key? key, required this.erabiltzaileIzena}) : super(key: key);

  @override
  _PantailaHasiState createState() => _PantailaHasiState();
}

class _PantailaHasiState extends State<PantailaHasi> {
  SugeMota? aukeratutakoSugeMota;
  int? aukeratutakoZailtasuna;
  int puntuakTotal = 0;

  final List<SugeMota> sugeMotak = [
    SugeMota(
      izena: 'Klasikoa',
      deskribapena: 'Suge tradizionala',
      buruKolorea: Color(0xFF4CAF50),
      gorputzKolorea: Color(0xFF8BC34A),
      ikonoa: Icons.eco,
    ),
    SugeMota(
      izena: 'Urrea',
      deskribapena: 'Suge distiratsua',
      buruKolorea: Color(0xFFFFC107),
      gorputzKolorea: Color(0xFFFFEB3B),
      ikonoa: Icons.workspace_premium,
    ),
    SugeMota(
      izena: 'Urdina',
      deskribapena: 'Suge urdina',
      buruKolorea: Color(0xFF2196F3),
      gorputzKolorea: Color(0xFF64B5F6),
      ikonoa: Icons.water_drop,
    ),
    SugeMota(
      izena: 'Morea',
      deskribapena: 'Suge morea',
      buruKolorea: Color(0xFF9C27B0),
      gorputzKolorea: Color(0xFFBA68C8),
      ikonoa: Icons.nightlight_round,
    ),
  ];

  final List<Map<String, dynamic>> zailtasunak = [
    {'izena': 'Erraza', 'balioa': 300, 'deskribapena': 'Geldiagoa', 'puntuak': 10},
    {'izena': 'Normala', 'balioa': 200, 'deskribapena': 'Erdikoa', 'puntuak': 15},
    {'izena': 'Zaila', 'balioa': 150, 'deskribapena': 'Azkarra', 'puntuak': 20},
  ];

  void _eginLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginOrria()),
    );
  }

  void _gehituPuntuak(int puntuak) {
    setState(() {
      puntuakTotal += puntuak;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.erabiltzaileIzena),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green[100]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.emoji_events, size: 16, color: Colors.green[700]),
                SizedBox(width: 4),
                Text(
                  'Puntuak: $puntuakTotal',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.grey[700]),
            onPressed: _eginLogout,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[200]!, width: 2),
                  ),
                  child: Icon(
                    Icons.sports_esports,
                    size: 40,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'SUGE JOKOA',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[800],
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Aukeratu zure sugea eta hasi jolasten',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 24),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'AUKERATU SUGE MOTA',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: sugeMotak.length,
                  itemBuilder: (context, index) {
                    final sugeMota = sugeMotak[index];
                    final bool aukeratuta = aukeratutakoSugeMota == sugeMota;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          aukeratutakoSugeMota = sugeMota;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: aukeratuta ? sugeMota.buruKolorea : Colors.grey[300]!,
                            width: aukeratuta ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: sugeMota.buruKolorea.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  sugeMota.ikonoa,
                                  color: sugeMota.buruKolorea,
                                  size: 16,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                sugeMota.izena,
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                sugeMota.deskribapena,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'AUKERATU ZAILTASUNA',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int index = 0; index < zailtasunak.length; index++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            aukeratutakoZailtasuna = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: aukeratutakoZailtasuna == index
                                ? (aukeratutakoSugeMota?.buruKolorea ?? Color(0xFF4CAF50))
                                : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: aukeratutakoZailtasuna == index
                                  ? (aukeratutakoSugeMota?.buruKolorea ?? Color(0xFF4CAF50))
                                  : Colors.grey[300]!,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                zailtasunak[index]['izena'],
                                style: TextStyle(
                                  color: aukeratutakoZailtasuna == index ? Colors.white : Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                zailtasunak[index]['deskribapena'],
                                style: TextStyle(
                                  color: aukeratutakoZailtasuna == index ? Colors.white.withOpacity(0.8) : Colors.grey[600],
                                  fontSize: 9,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '${zailtasunak[index]['puntuak']} puntu',
                                style: TextStyle(
                                  color: aukeratutakoZailtasuna == index ? Colors.white.withOpacity(0.9) : Colors.grey[700],
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: aukeratutakoSugeMota != null && aukeratutakoZailtasuna != null
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokoOrria(
                            sugeMota: aukeratutakoSugeMota!,
                            zailtasuna: zailtasunak[aukeratutakoZailtasuna!]['balioa'],
                            puntuakPerJanaria: zailtasunak[aukeratutakoZailtasuna!]['puntuak'],
                            onJokoaAmaitu: _gehituPuntuak,
                          ),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: aukeratutakoSugeMota?.buruKolorea ?? Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'HASI JOKOA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Jokoa hastean, erabili geziak edo WASD mugitzeko',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}