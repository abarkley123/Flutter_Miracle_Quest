import 'package:flutter/material.dart';
import '../game/game.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'purchase_logic.dart';
import '../util/util.dart';
import '../game/upgrade.dart';
import '../game/data.dart';

class PurchasePage extends StatefulWidget {
  final MyGame game;

  PurchasePage(this.game);

  @override
  PurchasePageState createState() => PurchasePageState(game);
}

class PurchasePageState extends State<PurchasePage> {
  double width;
  final MyGame game;

  PurchasePageState(this.game);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new DefaultTabController(
      length: categories.length,
      child: new Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new TabBar(
            tabs: categories.map((Category choice) {
              return new Tab(
                child: Text(
                  choice.name,
                  style: TextStyle(color: Colors.black),
                ),
                icon: new Icon(
                  choice.icon,
                  color: Colors.black,
                ),
              );
            }).toList(),
          ),
        ),
        body: new TabBarView(
          children: categories.map((Category choice) {
            return new Padding(
              padding: const EdgeInsets.all(0.0),
              child: choiceWidget(choice),
            );
          }).toList(),
        ),
      ),
    ));
  }

  Widget choiceWidget(Category choice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: choice.index == 1
                  ? game.energyPurchases.length
                  : game.followerPurchases.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    color: Color(0xFFecf2f9),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int ind) {
                        return _currencyWidget(ind, choice.index, index);
                      },
                      itemCount: 2,
                      viewportFraction: 1,
                      scale: 0.95,
                    ));
              }),
        ),
      ],
    );
  }

  Widget _currencyWidget(int ind, int index, int currencyNum) {
    return ind == 0
        ? _currencySpecificWidget(index, currencyNum)
        : _currencyUpgradeWidget(index, currencyNum);
  }

  Widget _currencySpecificWidget(int index, int currencyNum) {
    CurrencyModel currency = index == 1
        ? game.energyPurchases[currencyNum]
        : game.followerPurchases[currencyNum];
    return Container(
      margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0, top: 16.0),
      child: Card(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.indigoAccent,
                          child: Row(children: <Widget>[
                            Text("Buy [${_toFixedString(currency.cost)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            Icon(
                              Icons.flash_on,
                              color: Color.fromARGB(255, 136, 14, 79),
                            ),
                            Text(
                              "]",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          onPressed: () =>
                              _purchaseItem(this.game, currency, index))),
                  Padding(
                      padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.indigoAccent,
                          child: Row(children: <Widget>[
                            Text(
                                "Sell [${_toFixedString(currency.startingCost == currency.cost ? 0 : currency.cost / 2.5)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            Icon(
                              Icons.flash_on,
                              color: Color.fromARGB(255, 136, 14, 79),
                            ),
                            Text(
                              "]",
                            ),
                          ]),
                          onPressed: () =>
                              _sellItem(this.game, currency, index))),
                ]),
                Expanded(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 20.0, bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            currency.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Own ${currency.amount}",
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text(
                          '+ ${_toFixedString(currency.baseProd * currency.multiplier)} ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        index == 1
                            ? Icon(
                                Icons.flash_on,
                                color: Color.fromARGB(255, 136, 14, 79),
                              )
                            : Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 19, 193, 100),
                              ),
                      ]),
                      index == 1
                          ? Row(children: <Widget>[
                              Text(
                                '- ${_toFixedString(currency.baseProd * currency.multiplier)} ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 19, 193, 100),
                              ),
                            ])
                          : new Container(width: 0, height: 0),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String _toFixedString(double value) {
    if (value < 10) {
      return value % 1 == 0
          ? value.toStringAsFixed(0)
          : value.toStringAsFixed(1);
    } else if (value < 100) {
      return value.toStringAsFixed(0);
    } else if (value < 1000) {
      return value.floor().toString();
    } else {
      return truncateBigValue(value);
    }
  }

  Widget _currencyUpgradeWidget(int index, int upgradeNum) {
    Upgrade upgrade = index == 1
        ? this.game.energyUpgrades[upgradeNum]
        : this.game.followerUpgrades[upgradeNum];
    UpgradeDescription upgradeDesciption = index == 1
        ? purchaseUpgradeDescriptions[upgradeNum]
        : followerUpgradeDescriptions[upgradeNum];
    return Container(
      margin: EdgeInsets.only(bottom: 16.0, left: 8.0, right: 8.0, top: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: <Widget>[
              Column(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                    child: ButtonTheme(
                        height: 80.0,
                        minWidth: 100.0,
                        child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.indigoAccent,
                            child: Column(children: <Widget>[
                              Text("Upgrade",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0)),
                              Row(children: <Widget>[
                                Text(
                                  '[${_toFixedString(upgrade.cost)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                Icon(
                                  Icons.flash_on,
                                  color: Color.fromARGB(255, 136, 14, 79),
                                ),
                                Text(']',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ]),
                            ]),
                            onPressed: () =>
                                _upgradeItem(upgrade, index, upgradeNum)))),
              ]),
              Expanded(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            upgradeDesciption.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            upgradeDesciption.description,
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text(
                        '+ ${_toFixedString(100 * (upgrade.multiplier - 1))} %',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      index == 1
                          ? Icon(
                              Icons.flash_on,
                              color: Color.fromARGB(255, 136, 14, 79),
                            )
                          : Icon(Icons.person,
                              color: Color.fromARGB(255, 19, 193, 100))
                    ]),
                    index == 1
                        ? Row(children: <Widget>[
                            Text(
                              '- ${_toFixedString(100 * (upgrade.multiplier - 1))} %',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.person,
                                color: Color.fromARGB(255, 19, 193, 100))
                          ])
                        : new Container(width: 0, height: 0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _purchaseItem(MyGame game, CurrencyModel currency, int index) {
    String type = index == 1 ? "Energy" : "Followers";
    if (game.mainCurrencies["Energy"].amount >= currency.cost) {
      double increment = currency.baseProd;
      game.ch.purchasePassive(game.mainCurrencies[type], increment);
      setState(() {
        game.mainCurrencies["Energy"].amount -= currency.cost;
        currency.amount = currency.amount + 1;
        currency.cost = currency.cost * 2.5;
        currency.baseProd = increment * 1.05;
      });
      game.savePurchase(type);
    }
  }

  _upgradeItem(Upgrade upgrade, int index, int upgradeNum) {
    CurrencyModel currencyModel = index == 1
        ? this.game.energyPurchases[upgradeNum]
        : this.game.followerPurchases[upgradeNum];
    if (game.mainCurrencies["Energy"].amount >= upgrade.cost) {
      setState(() {
        Upgrade newUpgrade = this
            .game
            .upgradeHandler
            .passiveUpgrade(this.game, upgrade, currencyModel);
        upgrade.amount = newUpgrade.amount;
        upgrade.cost = newUpgrade.cost;
        upgrade.multiplier = newUpgrade.multiplier;
        this.game.savePurchaseUpgrades();
      });
    } else {
      print("Insufficent currency available for upgrade.");
    }
  }

  _sellItem(MyGame game, CurrencyModel currency, int index) {
    if (currency.amount >= 1) {
      setState(() {
        currency.cost = currency.cost / 2.5;
        currency.baseProd = currency.baseProd / 1.05;
        currency.amount = currency.amount - 1;
      });
      if (index == 1) {
        game.ch.sellPassive(game.mainCurrencies["Energy"], currency);
        game.savePurchase("Energy");
      } else if (index == 2) {
        game.ch.sellPassive(game.mainCurrencies["Followers"], currency);
        game.savePurchase("Followers");
      }
    }
  }
}

// Our CategoryCard data object
class CategoryCard extends StatelessWidget {
  const CategoryCard({Key key, this.choice}) : super(key: key);
  final Category choice;

  //build and return our card with icon and text
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.name, style: textStyle),
          ],
        ),
      ),
    );
  }
}
