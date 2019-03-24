import 'package:flutter/material.dart';
import 'dart:math';

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
  double _multiplier;
  String title;
  String description;

  CurrencyModel(
      this._cost, this._amount, this._baseProd, this.title, this.description) {
    this._startingCost = this._cost;
    this._startingProd = this._baseProd;
    this._multiplier = 1.0;
  }

//essentially a copy constructor - limited by dart's inability to overload constructors
  void copy(CurrencyModel model) {
    this._cost = model.cost;
    this._startingProd = model.startingProd;
    this._baseProd = model.baseProd;
    this._startingCost = model.startingCost;
    this._amount = model.amount;
    this._multiplier = model.multiplier;
    this.title = model.title;
    this.description = model.description;
  }

  void reset() {
    this._amount = 0;
    this.cost = this.startingCost;
    this._baseProd = this._startingProd;
    this._multiplier = 1.0;
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

  get multiplier {
    return this._multiplier;
  }

  set multiplier(double amount) {
    this._multiplier = amount;
  }

  get startingProd {
    return this._startingProd;
  }
  
  double getTotalOutput() {
    if (this._amount == 0) {
      return 0.0;
    } else if (this._amount <= 1) {
      return this._startingProd * this._multiplier;
    } else {
      return this._startingProd * (pow(1.05, this.amount)) * this._multiplier;
    }
  }

}

double getCompleteOutputFrom(final CurrencyModel currency) {
  CurrencyModel target = copyCurrency(currency);
  double totalOutput = 0;

  for (int i = target.amount; i > 0; i--) {
    totalOutput += target.getTotalOutput();
    target.amount = target.amount - 1;
  }

  return totalOutput;
}

CurrencyModel copyCurrency(final CurrencyModel currency) {
  CurrencyModel copyCurrency = new CurrencyModel(0, 0, 0, "", "");
  copyCurrency.copy(currency);
  return copyCurrency;
}

class UpgradeDescription {
  final String title;
  final String description;

  UpgradeDescription(this.title, this.description);
}
