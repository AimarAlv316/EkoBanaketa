import 'ibilgailua.dart';

class JokoEgoera {
  double dirua;
  double bateria;
  Ibilgailua unekoIbilgailua;
  List<Ibilgailua> jabeIbilgailuak;
  List<Entrega> entregaAktiboak;
  List<Ibilgailua> kargatzenIbilgailuak;

  JokoEgoera({
    required this.dirua,
    required this.bateria,
    required this.unekoIbilgailua,
    required this.jabeIbilgailuak,
    this.entregaAktiboak = const [],
    this.kargatzenIbilgailuak = const [],
  });
}

class Entrega {
  final String helmuga;
  final double bateriaErabilita;
  final double irabaziak;
  final int denboraTotal;
  int denboraGelditzen;
  final DateTime hasieraData;

  Entrega({
    required this.helmuga,
    required this.bateriaErabilita,
    required this.irabaziak,
    required this.denboraTotal,
    required this.denboraGelditzen,
    required this.hasieraData,
  });
}