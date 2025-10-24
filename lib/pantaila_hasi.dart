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

  final List<Map<String, dynamic>> zailtasunak = [
    {'izena': 'Erraza', 'balioa': 300, 'deskribapena': 'Geldiagoa'},
    {'izena': 'Normala', 'balioa': 200, 'deskribapena': 'Erdikoa'},
    {'izena': 'Zaila', 'balioa': 150, 'deskribapena': 'Azkarra'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0), // TXIKITUTA: 24tik 16ra
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo eta izenburua - TXIKITUTA
                SizedBox(height: 20), // TXIKITUTA: 40tik 20ra
                Container(
                  padding: EdgeInsets.all(16), // TXIKITUTA: 20tik 16ra
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[200]!, width: 2),
                  ),
                  child: Icon(
                    Icons.sports_esports,
                    size: 40, // TXIKITUTA: 50etik 40ra
                    color: Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(height: 16), // TXIKITUTA: 24tik 16ra
                Text(
                  'SUGE JOKOA',
                  style: TextStyle(
                    fontSize: 28, // TXIKITUTA: 32tik 28ra
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[800],
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 4), // TXIKITUTA: 8tik 4ra
                Text(
                  'Aukeratu zure sugea eta hasi jolasten',
                  style: TextStyle(
                    fontSize: 12, // TXIKITUTA: 14etik 12ra
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 24), // TXIKITUTA: 40etik 24ra

                // Suge mota aukeraketa
                _atalBurua('SUGE MOTA'),
                SizedBox(height: 12), // TXIKITUTA: 16tik 12ra
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8, // TXIKITUTA: 12tik 8ra
                    mainAxisSpacing: 8, // TXIKITUTA: 12tik 8ra
                    childAspectRatio: 1.0, // TXIKITUTA: 1.1etik 1.0ra
                  ),
                  itemCount: sugeMotak.length,
                  itemBuilder: (context, index) {
                    final sugeMota = sugeMotak[index];
                    return _sugeMotaTxartela(sugeMota);
                  },
                ),
                SizedBox(height: 20), // TXIKITUTA: 32tik 20ra

                // Zailtasun aukeraketa
                _atalBurua('ZAILTASUNA'),
                SizedBox(height: 12), // TXIKITUTA: 16tik 12ra
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: zailtasunak.asMap().entries.map((entry) {
                    final index = entry.key;
                    final zailtasuna = entry.value;
                    return _zailtasunBotoia(zailtasuna, index);
                  }).toList(),
                ),
                SizedBox(height: 24), // TXIKITUTA: 40etik 24ra

                // Hasi jokoa botoia - GARRANTITSUA: Botoia ikusteko
                Container(
                  width: double.infinity,
                  height: 50, // TXIKITUTA: 56tik 50ra
                  child: ElevatedButton(
                    onPressed: aukeratutakoSugeMota != null && aukeratutakoZailtasuna != null
                        ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokoOrria(
                            sugeMota: aukeratutakoSugeMota!,
                            zailtasuna: zailtasunak[aukeratutakoZailtasuna!]['balioa'],
                          ),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: aukeratutakoSugeMota?.buruKolorea ?? Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // TXIKITUTA: 12tik 10era
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
                SizedBox(height: 10), // TXIKITUTA: 20tik 10era
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
          fontSize: 13, // TXIKITUTA: 14etik 13ra
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
          letterSpacing: 1.0, // TXIKITUTA: 1.2tik 1.0ra
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
          borderRadius: BorderRadius.circular(10), // TXIKITUTA: 12tik 10era
          border: Border.all(
            color: aukeratuta ? sugeMota.buruKolorea : Colors.grey[300]!,
            width: aukeratuta ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6, // TXIKITUTA: 8tik 6ra
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12), // TXIKITUTA: 16tik 12ra
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(6), // TXIKITUTA: 8tik 6ra
                decoration: BoxDecoration(
                  color: sugeMota.buruKolorea.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  sugeMota.ikonoa,
                  color: sugeMota.buruKolorea,
                  size: 20, // TXIKITUTA: 24tik 20ra
                ),
              ),
              SizedBox(height: 8), // TXIKITUTA: 12tik 8ra
              Text(
                sugeMota.izena,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 13, // TXIKITUTA: 14etik 13ra
                ),
              ),
              SizedBox(height: 2), // TXIKITUTA: 4tik 2ra
              Text(
                sugeMota.deskribapena,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 10, // TXIKITUTA: 11etik 10era
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
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // TXIKITUTA
        decoration: BoxDecoration(
          color: aukeratuta ? (kolorea ?? Color(0xFF4CAF50)) : Colors.white,
          borderRadius: BorderRadius.circular(6), // TXIKITUTA: 8tik 6ra
          border: Border.all(
            color: aukeratuta ? (kolorea ?? Color(0xFF4CAF50)) : Colors.grey[300]!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3, // TXIKITUTA: 4tik 3ra
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
                fontSize: 11, // TXIKITUTA: 12tik 11ra
              ),
            ),
            SizedBox(height: 2), // TXIKITUTA: 4tik 2ra
            Text(
              zailtasuna['deskribapena'],
              style: TextStyle(
                color: aukeratuta ? Colors.white.withOpacity(0.8) : Colors.grey[600],
                fontSize: 9, // TXIKITUTA: 10etik 9ra
              ),
            ),
          ],
        ),
      ),
    );
  }
}