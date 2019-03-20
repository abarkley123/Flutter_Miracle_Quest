import 'currency.dart';
import 'game.dart';

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
}

class ClickUpgrade extends Upgrade {

  ClickUpgrade(double cost, int amount, double multiplier) : super(cost, amount, multiplier);

  ClickUpgrade purchase(MainCurrency energy, {MainCurrency followers}) {
    energy.amount -= this.cost;
    energy.active *= this.multiplier; 
    if (followers != null) {
      followers.active *= this.multiplier; 
    }    
    return new ClickUpgrade(this.cost*2, this.amount+1, this.multiplier*=1.1);
  }
}

class TickUpgrade extends Upgrade {

  TickUpgrade(double cost, int amount, double multiplier) : super(cost, amount, multiplier);

  TickUpgrade purchase(MainCurrency energy, {MainCurrency followers}) {
    energy.amount -= this.cost;
    energy.active *= this.multiplier; 
    if (followers != null) {
      followers.active *= this.multiplier; 
    }    
    return new TickUpgrade(this.cost*2, this.amount+1, this.multiplier*=1.1);
  }
}

class CriticalUpgrade extends Upgrade {

  CriticalUpgrade(double cost, int amount, double multiplier) : super(cost, amount, multiplier);

  CriticalUpgrade purchase(MainCurrency energy, {MainCurrency followers}) {
    energy.amount -= this.cost;
    energy.active *= this.multiplier; 
    if (followers != null) {
      followers.active *= this.multiplier; 
    }    
    return new CriticalUpgrade(this.cost*2, this.amount+1, this.multiplier*=1.1);
  }
}

class UpgradeHandler {

  Upgrade activePurchase(MyGame game, String type) {
    return game.upgrades[type].purchase(game.mainCurrencies["Energy"], followers: game.mainCurrencies["Followers"]);
  }
}