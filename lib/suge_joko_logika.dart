// suge_joko_logika.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum Norabidea { GORA, BEHERA, EZKERRA, ESKUMA }

class SugeJokoLogika {
  final Function() onJokoaEguneratu;
  final int abiadura;

  late List<Offset> sugeGorputza;
  late Offset sugeBurua;
  late Offset janaria;
  late Norabidea norabidea;
  late Norabidea hurrengoNorabidea; // GEHITU: Hurrengo norabidea bufferra
  late Timer denbora;
  late bool jokoaBukatuta;
  int puntuak = 0;

  final int zutabeKopurua = 10;
  final int errenkadaKopurua = 15;

  SugeJokoLogika({
    required this.onJokoaEguneratu,
    this.abiadura = 200,
  }) {
    hasiJokoa();
  }

  void hasiJokoa() {
    sugeBurua = Offset((zutabeKopurua ~/ 2).toDouble(), (errenkadaKopurua ~/ 2).toDouble());
    sugeGorputza = [sugeBurua];
    norabidea = Norabidea.ESKUMA;
    hurrengoNorabidea = Norabidea.ESKUMA; // GEHITU: Hurrengo norabidea hasieratu
    jokoaBukatuta = false;
    puntuak = 0;
    sortuJanaria();

    denbora = Timer.periodic(Duration(milliseconds: abiadura), (timer) {
      if (!jokoaBukatuta) {
        // GEHITU: Hurrengo norabidea aplikatu
        norabidea = hurrengoNorabidea;
        mugituSugea();
        onJokoaEguneratu();
      } else {
        timer.cancel();
      }
    });
  }

  void mugituSugea() {
    Offset buruBerria;

    switch (norabidea) {
      case Norabidea.GORA:
        buruBerria = Offset(sugeBurua.dx, sugeBurua.dy - 1);
        break;
      case Norabidea.BEHERA:
        buruBerria = Offset(sugeBurua.dx, sugeBurua.dy + 1);
        break;
      case Norabidea.EZKERRA:
        buruBerria = Offset(sugeBurua.dx - 1, sugeBurua.dy);
        break;
      case Norabidea.ESKUMA:
        buruBerria = Offset(sugeBurua.dx + 1, sugeBurua.dy);
        break;
    }

    // Mugako kontrola
    if (buruBerria.dx < 0 ||
        buruBerria.dx >= zutabeKopurua ||
        buruBerria.dy < 0 ||
        buruBerria.dy >= errenkadaKopurua ||
        sugeGorputza.contains(buruBerria)) {
      jokoaBukatuta = true;
      return;
    }

    sugeGorputza.insert(0, buruBerria);
    sugeBurua = buruBerria;

    // Janaria jaten du
    if (sugeBurua == janaria) {
      puntuak += 10;
      sortuJanaria();
    } else {
      sugeGorputza.removeLast();
    }
  }

  void sortuJanaria() {
    final ausazko = Random();

    do {
      janaria = Offset(
        ausazko.nextInt(zutabeKopurua).toDouble(),
        ausazko.nextInt(errenkadaKopurua).toDouble(),
      );
    } while (sugeGorputza.contains(janaria));
  }

  void aldatuNorabidea(Norabidea norabideBerria) {
    // Ezin da kontrako norabidera aldatu
    if ((norabidea == Norabidea.GORA && norabideBerria == Norabidea.BEHERA) ||
        (norabidea == Norabidea.BEHERA && norabideBerria == Norabidea.GORA) ||
        (norabidea == Norabidea.EZKERRA && norabideBerria == Norabidea.ESKUMA) ||
        (norabidea == Norabidea.ESKUMA && norabideBerria == Norabidea.EZKERRA)) {
      return;
    }

    // GEHITU: Hurrengo norabidea gorde (bufferra)
    hurrengoNorabidea = norabideBerria;
  }

  void dispose() {
    denbora.cancel();
  }
}