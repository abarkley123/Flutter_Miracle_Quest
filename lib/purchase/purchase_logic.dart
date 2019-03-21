import '../game/game.dart';
import 'package:flutter/material.dart';

class Category {
  const Category({this.name, this.icon, this.index});
  final String name;
  final IconData icon;
  final int index;
}

const List<Category> categories = <Category>[
  Category(name: 'Energy', icon: Icons.flash_on, index: 1),
  Category(name: 'Followers', icon: Icons.person, index: 2),
];

class CurrencyModel {
  double _cost;
  int _amount;
  double _baseProd;
  final String title;
  final String description;

  CurrencyModel(
      this._cost, this._amount, this._baseProd, this.title, this.description);

get cost {
    return this._cost;
  }    

  set cost(double cost) {
    this._cost = cost;
  }  

  get baseProd {
    return this._baseProd;
  }  

  set baseProd(double baseProd) {
    this._baseProd = baseProd;
  }

  get amount {
    return this._amount;
  }

  set amount(int amount) {
    this._amount = amount;
  }
}

List<CurrencyModel> followers = [
  CurrencyModel(1, 0, 1, "Articles ", "1"),
  CurrencyModel(4, 0, 5, "Loudspeaker", "2"),
  CurrencyModel(40, 0, 20, "Apostles", "3"),
  CurrencyModel(350, 0, 100, "Communion", "4"),
];

List<UpgradeModel> followerUpgrades = [
  UpgradeModel(1, 0, 1, "New Writer ", "Articles published are higher quality.",
      "Followers"),
  UpgradeModel(4, 0, 5, "Bigger Amp", "Your speaker is heard by more people.",
      "Followers"),
  UpgradeModel(40, 0, 20, "Divine Robes", "The apostles now emanate mystic energy.",
      "Followers"),
  UpgradeModel(350, 0, 100, "Fine Chianti", "Spread the reach of communion.",
      "Followers"),
];

List<CurrencyModel> purchases = [
  CurrencyModel(1, 0, 1, "Newspaper", "1"),
  CurrencyModel(10, 0, 5, "Intern", "2"),
  CurrencyModel(50, 0, 20, "Shrine", "3"),
  CurrencyModel(500, 0, 100, "Temple", "4"),
];

List<UpgradeModel> purchaseUpgrades = [
  UpgradeModel(1, 0, 1, "Laminated pages ", "Make your Newspaper more premium.",
      "Energy"),
  UpgradeModel(
      4, 0, 5, "Brazilian Coffee", "Improve your Intern's productivity.", "Energy"),
  UpgradeModel(40, 0, 20, "Gilded Furniture",
      "Allow your followers more luxury.", "Energy"),
  UpgradeModel(350, 0, 100, "Holy Scripture",
      "Your word is spread more easily.", "Energy"),
];

void setCurrencyValue(MyGame game, String currencyType) {
  if (currencyType == "Follower") {
    setValues(game, followers, currencyType);
  } else if (currencyType == "Energy") {
    setValues(game, purchases, currencyType);
  }
}

void setValues(MyGame game, List<CurrencyModel> currency, String currencyType) {
  for (int i = 0; i < currency.length; i++) {
    currency[i].amount =
        game.prefs.getInt(currencyType + i.toString() + "Amount") ?? 0;
  }
}

class UpgradeModel {
  double _cost;
  int _amount;
  double _multiplier;
  final String title;
  final String description;
  final String type;

  UpgradeModel(this._cost, this._amount, this._multiplier, this.title,
      this.description, this.type);

  get cost {
    return this._cost;
  }    

  set cost(double cost) {
    this._cost = cost;
  }  

  get multiplier {
    return this._multiplier;
  }  

  set multiplier(double multiplier) {
    this._multiplier = multiplier;
  }

  get amount {
    return this._amount;
  }

  set amount(int amount) {
    this._amount = amount;
  }
}
