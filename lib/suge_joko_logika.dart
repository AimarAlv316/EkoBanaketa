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
  late Timer denbora;
  late bool jokoaBukatuta;
  int puntuak = 0;

  final int zutabeKopurua = 10;
  final int errenkadaKopurua = 15;

  SugeJokoLogika({
    required this.onJokoaEguneratu,
    this.abiadura = 200, // Default abiadura
  }) {
    hasiJokoa();
  }

  void hasiJokoa() {
    sugeBurua = Offset((zutabeKopurua ~/ 2).toDouble(), (errenkadaKopurua ~/ 2).toDouble());
    sugeGorputza = [sugeBurua];
    norabidea = Norabidea.ESKUMA;
    jokoaBukatuta = false;
    puntuak = 0;
    sortuJanaria();

    denbora = Timer.periodic(Duration(milliseconds: abiadura), (timer) {
      if (!jokoaBukatuta) {
        mugituSugea();
        onJokoaEguneratu();
      } else {
        timer.cancel();
      }
    });
  }

  // Gainerako kodea berdina...
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

    norabidea = norabideBerria;
  }

  void dispose() {
    denbora.cancel();
  }
}