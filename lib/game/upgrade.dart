import 'currency.dart';
import 'game.dart';

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

  ClickUpgrade purchase(MainCurrency energy, {MainCurrency followers}) {
    energy.amount -= this.cost;
    energy.active *= this.multiplier; 
    if (followers != null) {
      followers.active *= this.multiplier; 
    }    
    return new ClickUpgrade(this.cost*2, this.amount+1, this.multiplier*=1.1);
  }
}

class UpgradeHandler {

  Upgrade activePurchase(MyGame game) {
    return game.upgrades["Click"].purchase(game.mainCurrencies["Energy"], followers: game.mainCurrencies["Followers"]);
  }
}