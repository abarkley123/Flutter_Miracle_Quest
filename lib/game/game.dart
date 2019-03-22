import 'package:flame/game.dart';
import 'currency.dart';
import '../main.dart';
import 'upgrade.dart';
import '../purchase/purchase_logic.dart';
import 'data.dart';
import 'save.dart';
import 'dart:math';

class MyGame extends BaseGame {

  final prefs;
  int counter = 0;
  MyApp _widget;
  Followers followers = new Followers();
  Energy energy = new Energy();
  //this should be delegated to a helper class
  Map<String, MainCurrency> _mainCurrencies = new Map();
  Map<String, Upgrade> _upgrades = new Map();
  List<EnergyUpgrade> energyUpgrades = new List();
  List<FollowerUpgrade> followerUpgrades = new List();
  List<CurrencyModel> energyPurchases = new List();
  List<CurrencyModel> followerPurchases = new List();  
  CurrencyHandler ch = new CurrencyHandler();
  UpgradeHandler upgradeHandler = new UpgradeHandler();

  MyGame(this.prefs) {
    setupCurrencies();
    setupClickUpgrades();
    setupPurchaseUpgrades(energyUpgrades, followerUpgrades);
    setupPurchases(energyPurchases, followerPurchases);
    loadData();
  }

  void setupCurrencies() {
    _mainCurrencies["Energy"] = energy;
    _mainCurrencies["Followers"] = followers;
  }

  void setupClickUpgrades() {
    _upgrades["Click"] = new ClickUpgrade(10.0, 0, 2.0);
    _upgrades["Tick"] = new TickUpgrade(40.0, 0, 1.1);
    _upgrades["Critical"] = new CriticalUpgrade(100.0, 0, 1.05);
  }

  get widget {
    return this._widget;
  }

  set widget(wid) {
    this._widget = wid;
  }

  get mainCurrencies {
    return this._mainCurrencies;
  }

  get upgrades {
    return this._upgrades;
  }

  @override
  void update(double t) {
    followers.incrementPassive();
    energy.incrementPassive(f: followers);
  }

  //too much duplication -> make a saver class or create function inside each object to handle save()
  saveData() {
    prefs.setDouble('Energy', energy.amount);
    prefs.setDouble('Followers', followers.amount);
    prefs.setDouble("EnergyPassive", energy.passive);
    prefs.setDouble("FollowersPassive", followers.passive);
  }

  savePurchase(String type) {
    if (type.startsWith("E")) {
      savePurchaseFor("Energy", this.prefs, this.energyPurchases);
    } else {
      savePurchaseFor("Followers", this.prefs, this.followerPurchases);
    }
  }

  loadData() {
    energy.amount = prefs.getDouble("Energy") ?? 0;
    followers.amount = prefs.getDouble("Followers") ?? 0;
    energy.passive = prefs.getDouble("EnergyPassive") ?? 0;
    followers.passive = prefs.getDouble("FollowersPassive") ?? 0;
    loadActive();
    loadClickUpgrades();
    loadPurchaseUpgrades();
  }

  saveClickUpgrade(String type) {
    prefs.setDouble(type + 'cost', _upgrades[type].cost);
    prefs.setInt(type + 'amount', _upgrades[type].amount);
    prefs.setDouble(type + 'multiplier', _upgrades[type].multiplier);
  }

  loadClickUpgrades() {
    _upgrades.forEach((k, v) {
      v.cost = resolveDefaultValueFor(prefs.getDouble(k + 'cost'), v.cost);
      v.amount = resolveDefaultValue(prefs.getInt(k + 'amount'), v.amount);
      v.multiplier = resolveDefaultValueFor(
          prefs.getDouble(k + 'multiplier'), v.multiplier);
    });
  }

  savePurchaseUpgrades() {
    for (int i = 0; i < energyUpgrades.length; i++) {
      savePurchaseUpgrade("Energy", i, energyUpgrades[i]);
      savePurchaseUpgrade("Followers", i, followerUpgrades[i]);
    }
  }

  savePurchaseUpgrade(String type, int index, Upgrade upgrade) {
    prefs.setInt(type + "Upgrade" + index.toString() + "Amount", upgrade.amount);
    prefs.setDouble(type + "Upgrade" + index.toString() + "Multiplier", upgrade.multiplier);
  }

  loadPurchaseUpgrades() {
    for (int i = 0; i < energyUpgrades.length; i++) {
      loadPurchaseUpgrade("Energy", i, energyUpgrades[i]);
      loadPurchaseUpgrade("Followers", i, followerUpgrades[i]);
    } 
  }

  loadPurchaseUpgrade(String type, int index, Upgrade upgrade) {
    upgrade.reset();
    upgrade.amount = prefs.getInt(type + "Upgrade" + index.toString() + "Amount") ?? 0;
    upgrade.multiplier = prefs.getDouble(type + "Upgrade" + index.toString() + "Multiplier") ?? 1.0;
    upgrade.cost = upgrade.amount > 0 ? upgrade.cost * pow(5, upgrade.amount) : upgrade.cost;
  }

  saveActive() {
    prefs.setDouble("EnergyActive", energy.active);
    prefs.setDouble("FollowersActive", followers.active);
  }

  loadActive() {
    energy.active = prefs.getDouble("EnergyActive") ?? 1;
    followers.active = prefs.getDouble("FollowersActive") ?? 1;
  }

  int resolveDefaultValue(int value, int defaultValue) {
    if (value == null) return defaultValue;
    if (value <= defaultValue) {
      return defaultValue;
    }
    return value;
  }

  double resolveDefaultValueFor(double value, double defaultValue) {
    if (value == null) return defaultValue;
    if (value <= defaultValue) {
      return defaultValue;
    }
    return value;
  }

  deleteSave() async {
    await prefs.clear();
    _mainCurrencies.forEach((key, value) => value.reset());
    _upgrades.forEach((key, value) => value.reset());
    energyPurchases.forEach((purchase) => purchase.reset());
    followerPurchases.forEach((purchase) => purchase.reset());
    energyUpgrades.forEach((upgrade) => upgrade.reset());
    followerUpgrades.forEach((upgrade) => upgrade.reset());
  }

  void doMiracle({bool isCritical}) {
    if (this.mainCurrencies["Followers"].amount <= 0.0) {
    } else {
      this.ch.click(this.mainCurrencies["Energy"],
          f: this.mainCurrencies["Followers"], critical: isCritical);
    }
  }

  void doAscension({bool isCritical}) {
    this.ch.click(this.mainCurrencies["Followers"], critical: isCritical);
  }

  double getAdjustedValueFor(String type) {
    if (type.startsWith("E")) {
      if (this._mainCurrencies[type].passive > this._mainCurrencies["Followers"].passive) {
        return this._mainCurrencies["Followers"].passive;
      } else {
        return this._mainCurrencies[type].passive;
      }
    } else {
      return this._mainCurrencies[type].passive - this._mainCurrencies["Energy"].passive;
    }
  }
}
