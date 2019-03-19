import 'currency.dart';

abstract class Upgrader {
  void purchase(MainCurrency energy, {MainCurrency followers});
}

abstract class Upgrade implements Upgrader {

  double cost;
  double amount;
  double multiplier;

  Upgrade(this.cost, this.amount, this.multiplier);
}

class ClickUpgrade extends Upgrade {

  ClickUpgrade(double cost, double amount, double multiplier) : super(cost, amount, multiplier);

  void purchase(MainCurrency energy, {MainCurrency followers}) {
    energy.amount -= this.cost;
    if (followers != null) {
      followers.active *= this.multiplier;
    } else {
      energy.active *= this.multiplier;      
    }
    this.amount++;
    this.cost*=2;
    this.multiplier*=1.1;
  }
}

class UpgradeHandler {

  void activePurchase(MainCurrency e, {MainCurrency followers}) {
    
  }
}