import 'package:flame/game.dart';
import 'currency.dart';
import '../main.dart';
import 'upgrade.dart';

class MyGame extends BaseGame {

  final prefs;
  int counter = 0;
  MyApp _widget;
  Followers followers;
  Energy energy;
  //this should be delegated to a subclass
  Map<String, MainCurrency> _mainCurrencies = new Map();
  Map<String, Upgrade> _upgrades = new Map();
  CurrencyHandler ch = new CurrencyHandler();
  UpgradeHandler upgradeHandler = new UpgradeHandler();

  MyGame(this.prefs) {
    energy = new Energy();
    followers = new Followers();
    _mainCurrencies["Energy"] = energy;
    _mainCurrencies["Followers"] = followers;
    _upgrades["Click"] = new ClickUpgrade(10.0, 0, 2.0);
    _upgrades["Tick"] = new ClickUpgrade(40.0, 0, 1.1);
    _upgrades["Critical"] = new ClickUpgrade(100.0, 0, 1.05);
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
    energy.incrementPassive(f: followers);
    followers.incrementPassive();
  }

  get mainCurrencies {
    return this._mainCurrencies;
  }

  get upgrades {
    return this._upgrades;
  }

  saveData() {
    prefs.setDouble('Energy', energy.amount);
    prefs.setDouble('Followers', followers.amount);
    prefs.setDouble("EnergyPassive", energy.passive);
    prefs.setDouble("FollowersPassive", followers.passive);
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
    energy.amount = prefs.getDouble("Energy") ?? 0;
    followers.amount = prefs.getDouble("Followers") ?? 0;
    energy.passive = prefs.getDouble("EnergyPassive") ?? 0;
    followers.passive = prefs.getDouble("FollowersPassive") ?? 0;
  }

  deleteSave() async {
    await prefs.clear();
    _mainCurrencies.forEach((key, value) => value.reset());
  }
}

