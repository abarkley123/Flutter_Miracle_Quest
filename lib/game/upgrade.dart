import 'currency.dart';
import 'game.dart';
import 'dart:math';

abstract class Upgrader {
  void purchase(MainCurrency energy, {MainCurrency followers});
}

abstract class Upgrade implements Upgrader {

  double _cost;
  int _amount;
  double _multiplier;

  Upgrade(this._cost, this._amount, this._multiplier);

  get cost {
    return this._cost;
  }

  get amount {
    return this._amount;
  }

  get multiplier {
    return this._multiplier;
  }

  set cost(double cost) {
    this._cost = cost;
  }

  set amount(int amount) {
    this._amount = amount;
  }

  set multiplier(double multiplier) {
    this._multiplier = multiplier;
  }

  void reset() {
    this.amount = 0;
  }
}

class ClickUpgrade extends Upgrade {

  ClickUpgrade(double cost, int amount, double multiplier) : super(cost, amount, multiplier);

  ClickUpgrade purchase(MainCurrency energy, {MainCurrency followers}) {
    energy.amount -= this.cost;
    energy.active *= this.multiplier; 
    if (followers != null) {
      followers.active *= this.multiplier; 
    }    
    return new ClickUpgrade(this.cost*2, this.amount+1, this.multiplier*1.1);
  }

  @override
  void reset() {
    super.reset();
    this.cost = 10.0;
    this.multiplier = 2.0;
  }
}

class TickUpgrade extends Upgrade {

  double baseMultiplier = 1.1;

  TickUpgrade(double cost, int amount, double multiplier) : super(cost, amount, multiplier);

  TickUpgrade purchase(MainCurrency energy, {MainCurrency followers}) {
    energy.amount -= this.cost;

    return new TickUpgrade(this.cost*2, this.amount+1, this.multiplier*1.1);
  }

  @override
  get multiplier {
    if (this.amount <= 0) {
      return 1.1;
    } else {
      return this.baseMultiplier * (pow(1.1, this.amount));
    }
  }

  @override
  void reset() {
    super.reset();
    this.cost = 40.0;
    this.multiplier = 1.1;
  }
}

class CriticalUpgrade extends Upgrade {

  double baseMultiplier = 1.05;

  CriticalUpgrade(double cost, int amount, double multiplier) : super(cost, amount, multiplier);

  CriticalUpgrade purchase(MainCurrency energy, {MainCurrency followers}) {
    energy.amount -= this.cost;

    return new CriticalUpgrade(this.cost*2, this.amount+1, this.multiplier*1.05);
  }

  @override
  get multiplier {
    if (this.amount <= 0) {
      return 1.05;
    } else {
      return this.baseMultiplier * (pow(1.05, this.amount));
    }
  }

  @override
  void reset() {
    super.reset();
    this.cost = 100;
    this.multiplier = 1.05;
  }
}

class UpgradeHandler {

  Upgrade activePurchase(MyGame game, String type) {
    return game.upgrades[type].purchase(game.mainCurrencies["Energy"], followers: game.mainCurrencies["Followers"]);
  }
}