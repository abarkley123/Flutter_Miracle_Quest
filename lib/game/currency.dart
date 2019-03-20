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

  get active {
    return this._incrementable;
  }

  set active(double amount) {
    this._incrementable = amount;
  }

  get incrementable {
    return this._incrementable;
  }
}

abstract class MainCurrency extends Currency {
  double _passiveIncrementable;
  String action;

  MainCurrency() : super() {
    this._passiveIncrementable = 0;
  }

  void increment(double amount) {
    this._amount += amount;
  }

  void incrementPassive({Followers f});

  void incrementActive({Followers f});

  void increasePassiveIncrement(double amount);

  get modifier {
    return this._modifier;
  }

  get passive {
    return this._passiveIncrementable;
  }

  set amount(double amount) {
    this._amount = amount;
  }

  set passive(double amount) {
    this._passiveIncrementable = amount;
  }

  void adjustForNegatives() {
    if (this.amount <= 0) this.amount = 0;
  }

  void reset() {
    this.amount = 0;
    this._passiveIncrementable = 0;
    this._incrementable = 1;
    this._modifier = 1;
  }

  get title {
    return this.action;
  }

  set title(String title) {
    this.action = title;
  }
}

class Energy extends MainCurrency {
  Energy() : super() {
    this.title = "Basic Charm";
  }

  void applyModifier(double m) {}

  void increaseIncrement(double a) {}

  @override
  incrementPassive({MainCurrency f}) {
    if (this.passive <= f.amount) {
      this._amount += (this.passive * this._modifier);
      f._amount -= (this.passive * this._modifier);
    } else {
      addMinimumAmount(f);
    }

    adjustForNegatives();
  }

  @override
  void increasePassiveIncrement(double amount) {
    this._passiveIncrementable += amount * this._modifier;
  }

  @override
  incrementActive({MainCurrency f}) {
    double totalIncrement = this._incrementable * this._modifier;
    double amountToIncrement = 0;
    if (f.amount >= totalIncrement) {
      amountToIncrement = totalIncrement;
    } else if (f.amount > 0) {
      amountToIncrement = f.amount;
    }

    this._amount += amountToIncrement;
    f._amount -= amountToIncrement;
    

    adjustForNegatives();
  }

  void addMinimumAmount(MainCurrency f) {
    if (f._passiveIncrementable * f._modifier >= (this._passiveIncrementable * this._modifier)) {
      this.amount += this._passiveIncrementable * this._modifier;
    } else {
      this.amount += f._passiveIncrementable * f._modifier;
    }
    f._amount = 0;
  }
}

class Followers extends MainCurrency {
  Followers() : super() {
    this.title = "Ascension";
  }

  void applyModifier(double m) {}

  void increaseIncrement(double a) {}

  @override
  incrementPassive({MainCurrency f}) {
    this.amount += (this._passiveIncrementable * this._modifier);
    adjustForNegatives();
  }

  @override
  incrementActive({MainCurrency f}) {
    this._amount += this._incrementable * this._modifier;

    adjustForNegatives();
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
    c.incrementActive(f: f ?? c);
  }

  void purchasePassive(MainCurrency c, double amount, {MainCurrency f}) {
    c.increasePassiveIncrement(amount);
  }

  void sellPassive(MainCurrency c, double amount, {MainCurrency f}) {
    c.increasePassiveIncrement(-amount);
  }
}
// other currencies to come - flame, perk points etc.
