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
  double _startingCost;
  int _amount;
  double _baseProd;
  double _startingProd;
  final String title;
  final String description;

  CurrencyModel(
      this._cost, this._amount, this._baseProd, this.title, this.description) {
    this._startingCost = this._cost;
    this._startingProd = this._baseProd;
  }

  void reset() {
    this._amount = 0;
    this.cost = this.startingCost;
    this._baseProd = this._startingProd;
  }

  get startingCost {
    return this._startingCost;
  }

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

void setCurrencyValue(MyGame game, String currencyType) {
  if (currencyType == "Followers") {
    setValues(game, game.followerPurchases, currencyType);
  } else if (currencyType == "Energy") {
    setValues(game, game.followerPurchases, currencyType);
  }
}

void setValues(MyGame game, List<CurrencyModel> currency, String currencyType) {
  for (int i = 0; i < currency.length; i++) {
    currency[i].amount =
        game.prefs.getInt(currencyType + i.toString() + "Amount") ?? 0;
    currency[i].cost = currency[i].cost > currency[i].startingCost
        ? currency[i].cost
        : currency[i].startingCost;
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
