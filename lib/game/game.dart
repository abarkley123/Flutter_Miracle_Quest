import 'package:flame/game.dart';
import 'currency.dart';
import '../main.dart';
import 'upgrade.dart';
import '../purchase/purchase_logic.dart';

class MyGame extends BaseGame {
  final prefs;
  int counter = 0;
  MyApp _widget;
  Followers followers;
  Energy energy;
  //this should be delegated to a helper class
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
    _upgrades["Tick"] = new TickUpgrade(40.0, 0, 1.1);
    _upgrades["Critical"] = new CriticalUpgrade(100.0, 0, 1.05);
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
    followers.incrementPassive();
    energy.incrementPassive(f: followers);
  }

  get mainCurrencies {
    return this._mainCurrencies;
  }

  get upgrades {
    return this._upgrades;
  }

  //too much duplication -> make a saver class or create function inside each object to handle save()
  saveData() {
    prefs.setDouble('Energy', energy.amount);
    prefs.setDouble('Followers', followers.amount);
    prefs.setDouble("EnergyPassive", energy.passive);
    prefs.setDouble("FollowersPassive", followers.passive);
  }

  savePurchase(List<CurrencyModel> purchases, String type) {
    for (int i = 0; i < purchases.length; i++) {
      prefs.setInt(type + i.toString() + "Amount", purchases[i].amount);
    }
  }

  loadData() {
    energy.amount = prefs.getDouble("Energy") ?? 0;
    followers.amount = prefs.getDouble("Followers") ?? 0;
    energy.passive = prefs.getDouble("EnergyPassive") ?? 0;
    followers.passive = prefs.getDouble("FollowersPassive") ?? 0;
    loadActive();
    loadClickUpgrades();
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
  }

  void doMiracle(MyGame game, {bool isCritical}) {
    if (game.mainCurrencies["Followers"].amount <= 0.0) {
    } else {
      game.ch.click(game.mainCurrencies["Energy"],
          f: game.mainCurrencies["Followers"], critical: isCritical);
    }
  }

  void doAscension(MyGame game, {bool isCritical}) {
    game.ch.click(game.mainCurrencies["Followers"], critical: isCritical);
  }

  List<CurrencyModel> followerPurchases = [
  CurrencyModel(1, 0, 1, "Articles ", "1"),
  CurrencyModel(4, 0, 5, "Loudspeaker", "2"),
  CurrencyModel(40, 0, 20, "Apostles", "3"),
  CurrencyModel(350, 0, 100, "Communion", "4"),
];

List<UpgradeModel> followerUpgrades = [
  UpgradeModel(100, 0, 1.5, "New Writer ", "Articles published are higher quality.",
      "Followers"),
  UpgradeModel(2000, 0, 1.5, "Bigger Amp", "Your speaker is heard by more people.",
      "Followers"),
  UpgradeModel(30000, 0, 1.5, "Divine Robes", "The apostles now emanate mystic energy.",
      "Followers"),
  UpgradeModel(750000, 0, 1.5, "Fine Chianti", "Spread the reach of communion.",
      "Followers"),
];

List<CurrencyModel> energyPurchases = [
  CurrencyModel(1, 0, 1, "Newspaper", "1"),
  CurrencyModel(10, 0, 5, "Intern", "2"),
  CurrencyModel(50, 0, 20, "Shrine", "3"),
  CurrencyModel(500, 0, 100, "Temple", "4"),
];

List<UpgradeModel> purchaseUpgrades = [
  UpgradeModel(100, 0, 1.5, "Laminated pages ", "Make your Newspaper more premium.",
      "Energy"),
  UpgradeModel(2500, 0, 1.5, "Brazilian Coffee", "Improve your Intern's productivity.", "Energy"),
  UpgradeModel(50000, 0, 1.5, "Gilded Furniture",
      "Allow your followers more luxury.", "Energy"),
  UpgradeModel(1000000, 0, 1.5, "Holy Scripture",
      "Your word is spread more easily.", "Energy"),
];
}
