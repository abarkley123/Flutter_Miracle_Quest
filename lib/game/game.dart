import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'currency.dart';
import 'dart:async';
import '../main.dart';

class MyGame extends BaseGame {

  final prefs;
  int counter = 0;
  MyApp _widget;
  Followers f;
  Energy e;
  Map<String, MainCurrency> _mainCurrencies = new Map();
  CurrencyHandler ch = new CurrencyHandler();

  MyGame(this.prefs) {
    e = new Energy();
    f = new Followers();
    _mainCurrencies["Energy"] = e;
    _mainCurrencies["Followers"] = f;
    loadData();
  }

  get widget {
    return this._widget;
  }

  set widget(wid) {
    this._widget = wid;
  }

  @override
  void update(double t) {
    e.incrementPassive(f: f);
    f.incrementPassive(f: e);
  }

  get mainCurrencies {
    return this._mainCurrencies;
  }

  saveData() {
    prefs.setDouble('Energy', e.amount);
    prefs.setDouble('Followers', f.amount);
    prefs.setDouble("EnergyPassive", e.passive);
    prefs.setDouble("FollowersPassive", f.passive);
  }

  saveEnergyPurchase(int value1, int value2, int value3, int value4) {
    prefs.setInt("Energy0Amount", value1);
    prefs.setInt("Energy1Amount", value2);
    prefs.setInt("Energy2Amount", value3);
    prefs.setInt("Energy3Amount", value4);
  }

  saveFollowerPurchase(int value1, int value2, int value3, int value4) {
    prefs.setInt("Follower0Amount", value1);
    prefs.setInt("Follower1Amount", value2);
    prefs.setInt("Follower2Amount", value3);
    prefs.setInt("Follower3Amount", value4);
  }

  loadData() {
    e.amount = prefs.getDouble("Energy") ?? 0;
    f.amount = prefs.getDouble("Followers") ?? 0;
    e.passive = prefs.getDouble("EnergyPassive") ?? 0;
    f.passive = prefs.getDouble("FollowersPassive") ?? 0;
  }
}

