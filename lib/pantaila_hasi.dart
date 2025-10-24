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
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo eta izenburua
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[200]!, width: 2),
                  ),
                  child: Icon(
                    Icons.sports_esports,
                    size: 50,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'SUGE JOKOA',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[800],
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Aukeratu zure sugea eta hasi jolasten',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 40),

                // Suge mota aukeraketa
                _atalBurua('SUGE MOTA'),
                SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: sugeMotak.length,
                  itemBuilder: (context, index) {
                    final sugeMota = sugeMotak[index];
                    return _sugeMotaTxartela(sugeMota);
                  },
                ),
                SizedBox(height: 32),

                // Zailtasun aukeraketa
                _atalBurua('ZAILTASUNA'),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: zailtasunak.asMap().entries.map((entry) {
                    final index = entry.key;
                    final zailtasuna = entry.value;
                    return _zailtasunBotoia(zailtasuna, index);
                  }).toList(),
                ),
                SizedBox(height: 40),

                // Hasi jokoa botoia
                Container(
                  width: double.infinity,
                  height: 56,
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
                        borderRadius: BorderRadius.circular(12),
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
                SizedBox(height: 20),
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
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
          letterSpacing: 1.2,
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
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: aukeratuta ? sugeMota.buruKolorea : Colors.grey[300]!,
            width: aukeratuta ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: sugeMota.buruKolorea.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  sugeMota.ikonoa,
                  color: sugeMota.buruKolorea,
                  size: 24,
                ),
              ),
              SizedBox(height: 12),
              Text(
                sugeMota.izena,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                sugeMota.deskribapena,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: aukeratuta ? (kolorea ?? Color(0xFF4CAF50)) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: aukeratuta ? (kolorea ?? Color(0xFF4CAF50)) : Colors.grey[300]!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
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
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            Text(
              zailtasuna['deskribapena'],
              style: TextStyle(
                color: aukeratuta ? Colors.white.withOpacity(0.8) : Colors.grey[600],
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}