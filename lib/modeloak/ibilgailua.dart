class Ibilgailua {
  final String izena;
  final String emotikonoa;
  final double prezioa;
  final double abiadura;
  final double bateriaEdukiera;

  Ibilgailua({
    required this.izena,
    required this.emotikonoa,
    required this.prezioa,
    required this.abiadura,
    required this.bateriaEdukiera,
  });
}

class JokoEgoera {
  double dirua;
  double bateria;
  Ibilgailua unekoIbilgailua;
  List<Ibilgailua> jabeIbilgailuak;

  JokoEgoera({
    required this.dirua,
    required this.bateria,
    required this.unekoIbilgailua,
    required this.jabeIbilgailuak,
  });
}