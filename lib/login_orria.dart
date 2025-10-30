import 'package:flutter/material.dart';
import 'pantaila_hasi.dart';
import 'database_helper.dart';

class LoginOrria extends StatefulWidget {
  @override
  _LoginOrriaState createState() => _LoginOrriaState();
}

class _LoginOrriaState extends State<LoginOrria> {
  final _erabiltzaileController = TextEditingController();
  final _pasahitzController = TextEditingController();
  bool _ezkutatuPasahitza = true;
  bool _kargatzen = false;
  String _errorea = '';
  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _eginLogin() async {
    if (_erabiltzaileController.text.isEmpty) {
      setState(() {
        _errorea = 'Mesedez, idatzi zure izena';
      });
      return;
    }

    setState(() {
      _kargatzen = true;
      _errorea = '';
    });

    await Future.delayed(Duration(milliseconds: 1000));

    // Erabiltzailea datu-basean gorde (puntuak 0 izanik)
    await _dbHelper.saveErabiltzailea(_erabiltzaileController.text, 0);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PantailaHasi(
          erabiltzaileIzena: _erabiltzaileController.text,
        ),
      ),
    );
  }

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
                SizedBox(height: 60),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green[100]!, width: 2),
                  ),
                  child: Icon(
                    Icons.sports_esports,
                    size: 50,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'ONGI ETORRI',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[800],
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sartu zure izena hasi jolasteko',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 40),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: TextField(
                    controller: _erabiltzaileController,
                    decoration: InputDecoration(
                      labelText: 'Zure izena',
                      prefixIcon: Icon(Icons.person, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                if (_errorea.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[100]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorea,
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _kargatzen ? null : _eginLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: _kargatzen
                        ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : Text(
                      'SARTU',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[100]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oharra:',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Zure puntuak gordeko dira zure izenarekin.\nZure izena bakarrik behar duzu sartzeko.',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _erabiltzaileController.dispose();
    _pasahitzController.dispose();
    super.dispose();
  }
}