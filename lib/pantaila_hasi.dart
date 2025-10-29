// pantaila_hasi.dart
import 'package:flutter/material.dart';
import 'joko_orria.dart';
import 'suge_mota.dart';

class PantailaHasi extends StatefulWidget {
  @override
  _PantailaHasiState createState() => _PantailaHasiState();
}

class _PantailaHasiState extends State<PantailaHasi> {
  SugeMota? aukeratutakoSugeMota;
  int? aukeratutakoZailtasuna;

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

  // ALDATUTA: Puntuak gehitu zailtasun bakoitzean
  final List<Map<String, dynamic>> zailtasunak = [
    {'izena': 'Erraza', 'balioa': 300, 'deskribapena': 'Geldiagoa', 'puntuak': 10},
    {'izena': 'Normala', 'balioa': 200, 'deskribapena': 'Erdikoa', 'puntuak': 15},
    {'izena': 'Zaila', 'balioa': 150, 'deskribapena': 'Azkarra', 'puntuak': 20},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo eta izenburua
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

                // Suge mota aukeraketa
                _atalBurua('SUGE MOTA'),
                SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: sugeMotak.length,
                  itemBuilder: (context, index) {
                    final sugeMota = sugeMotak[index];
                    return _sugeMotaTxartela(sugeMota);
                  },
                ),
                SizedBox(height: 20),

                // Zailtasun aukeraketa
                _atalBurua('ZAILTASUNA'),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: zailtasunak.asMap().entries.map((entry) {
                    final index = entry.key;
                    final zailtasuna = entry.value;
                    return _zailtasunBotoia(zailtasuna, index);
                  }).toList(),
                ),
                SizedBox(height: 24),

                // Hasi jokoa botoia
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: aukeratutakoSugeMota != null && aukeratutakoZailtasuna != null
                        ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokoOrria(
                            sugeMota: aukeratutakoSugeMota!,
                            zailtasuna: zailtasunak[aukeratutakoZailtasuna!]['balioa'],
                            puntuakPerJanaria: zailtasunak[aukeratutakoZailtasuna!]['puntuak'], // GEHITU
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
                // Teklatuko argibideak
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

  Widget _atalBurua(String izenburua) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        izenburua,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _sugeMotaTxartela(SugeMota sugeMota) {
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
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: aukeratuta ? sugeMota.buruKolorea : Colors.grey[300]!,
            width: aukeratuta ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: sugeMota.buruKolorea.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  sugeMota.ikonoa,
                  color: sugeMota.buruKolorea,
                  size: 20,
                ),
              ),
              SizedBox(height: 8),
              Text(
                sugeMota.izena,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 2),
              Text(
                sugeMota.deskribapena,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _zailtasunBotoia(Map<String, dynamic> zailtasuna, int index) {
    final bool aukeratuta = aukeratutakoZailtasuna == index;
    final Color? kolorea = aukeratutakoSugeMota?.buruKolorea;

    return GestureDetector(
      onTap: () {
        setState(() {
          aukeratutakoZailtasuna = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: aukeratuta ? (kolorea ?? Color(0xFF4CAF50)) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: aukeratuta ? (kolorea ?? Color(0xFF4CAF50)) : Colors.grey[300]!,
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
              zailtasuna['izena'],
              style: TextStyle(
                color: aukeratuta ? Colors.white : Colors.grey[800],
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 2),
            Text(
              zailtasuna['deskribapena'],
              style: TextStyle(
                color: aukeratuta ? Colors.white.withOpacity(0.8) : Colors.grey[600],
                fontSize: 9,
              ),
            ),
            // GEHITU: Puntuak erakusteko
            SizedBox(height: 2),
            Text(
              '${zailtasuna['puntuak']} puntu',
              style: TextStyle(
                color: aukeratuta ? Colors.white.withOpacity(0.9) : Colors.grey[700],
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}