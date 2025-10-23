import '../modeloak/ibilgailua.dart';

class Konstanteak {
  static final List<Ibilgailua> eskuragarriIbilgailuak = [
    Ibilgailua(
      izena: 'Patinete Oinarrizkoa',
      emotikonoa: '🛴',
      prezioa: 200,
      abiadura: 1.0,
      bateriaEdukiera: 80,
    ),
  ];

  static final Map<String, Map<String, double>> kokalekuPosizioak = {
    'Bulego Nagusia': {'x': 0.5, 'y': 0.5},
    'Denda': {'x': 0.6, 'y': 0.5},
    'Etxea 1': {'x': 0.2, 'y': 0.3},
    'Etxea 2': {'x': 0.8, 'y': 0.3},
    'Etxea 3': {'x': 0.3, 'y': 0.7},
    'Etxea 4': {'x': 0.7, 'y': 0.7},
    'Etxea 5': {'x': 0.1, 'y': 0.5},
    'Etxea 6': {'x': 0.9, 'y': 0.5},
  };
}