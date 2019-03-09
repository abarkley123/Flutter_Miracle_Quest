import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'currency.dart';
import 'dart:async';
import '../main.dart';

class MyGame extends BaseGame {

  int counter = 0;
  MyApp _widget;
  Followers f;
  Energy e;
  Map<String, MainCurrency> _mainCurrencies = new Map();
  CurrencyHandler ch = new CurrencyHandler();

  MyGame() {
    e = new Energy();
    f = new Followers();
    _mainCurrencies["Energy"] = e;
    _mainCurrencies["Followers"] = f;
  }

  get widget {
    return this._widget;
  }

  set widget(wid) {
    this._widget = wid;
  }

  @override
  void update(double t) {

  }

  get mainCurrencies {
    return this._mainCurrencies;
  }
}

