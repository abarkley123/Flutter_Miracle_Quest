abstract class Mutation {
  void increment(double amount);
  void applyModifier(double amount);
}

abstract class Currency implements Mutation {
  double _amount;
  double _modifier;
  double _incrementable;

  Currency() {
    this._amount = 0;
    this._modifier = 1;
    this._incrementable = 1;
  }

  get amount {
    return this._amount;
  }

  get activeIncrement {
    return this._incrementable;
  }
}

abstract class MainCurrency extends Currency {
  double _passiveIncrementable;

  MainCurrency() : super() {
    this._passiveIncrementable = 0;
  }

  void increment(double amount) {
    this._amount += amount;
  }

  void incrementPassive({Followers f});

  void incrementActive({Followers f});

  void increasePassiveIncrement(double amount);

  get passive {
    return this._passiveIncrementable;
  }

  set amount(double amount) {
    this._amount = amount;
  }

  set passive(double amount) {
    this._passiveIncrementable = amount;
  }
}

class Energy extends MainCurrency {
  Energy() : super();

  void applyModifier(double m) {}

  void increaseIncrement(double a) {}

  @override
  incrementPassive({MainCurrency f}) {
    this._amount += (this.passive * this._modifier);
    f._amount -= (this.passive * this._modifier);
  }

  @override
  void increasePassiveIncrement(double amount) {
    this._passiveIncrementable += amount * this._modifier;
  }

  @override
  incrementActive({MainCurrency f}) {
    this._amount += this._incrementable * this._modifier;
    f._amount -= (this._incrementable * this._modifier);
  }
}

class Followers extends MainCurrency {
  Followers() : super();

  void applyModifier(double m) {}

  void increaseIncrement(double a) {}

  @override
  incrementPassive({MainCurrency f}) {
    this.amount += (this._passiveIncrementable * this._modifier) - (f._passiveIncrementable * f._modifier);
  }

  @override
  incrementActive({MainCurrency f}) {
    print('incrementing');
    this._amount += this._incrementable * this._modifier;
  }

  @override
  void increasePassiveIncrement(double amount) {
    this._passiveIncrementable += amount * this._modifier;
  }
}

class CurrencyHandler {
  void processModifierUpdate(Currency c, double modifier) {
    c.applyModifier(modifier);
  }

  void click(MainCurrency c, {MainCurrency f}) {
    print(c.amount.toString() + ' ' + c.toString());
    c.incrementActive(f: f ?? c);
    print(c.amount.toString());
  }

  void purchasePassive(MainCurrency c, double amount, {MainCurrency f}) {
    c.increasePassiveIncrement(amount);
  }
}
// other currencies to come - flame, perk points etc.
