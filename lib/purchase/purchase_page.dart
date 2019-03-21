import 'package:flutter/material.dart';
import '../game/game.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'purchase_logic.dart';
import '../util/util.dart';
import '../game/upgrade.dart';

class PurchasePage extends StatefulWidget {
  final MyGame game;

  PurchasePage(this.game);

  @override
  PurchasePageState createState() => PurchasePageState(game);
}

class PurchasePageState extends State<PurchasePage> {
  double width;
  final MyGame game;

  PurchasePageState(this.game) {
    setCurrencyValue(this.game, "Follower");
    setCurrencyValue(this.game, "Energy");
  }

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
                                  fontWeight: FontWeight.bold, fontSize: 16.0)),
                          Icon(
                            Icons.flash_on,
                            color: Color.fromARGB(255, 136, 14, 79),
                          ),
                          Text(
                            "]",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                        onPressed: () => _purchaseItem(this.game, currency, index)
                      )),
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
                          '+ ${_toFixedString(currency.baseProd)} ',
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
                                '- ${_toFixedString(currency.baseProd)} ',
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
    return value % 1 == 0 && value < 1000 ? value.floor().toString() : truncateBigValue(value);
  }

  Widget _currencyUpgradeWidget(int index, int currencyNum) {
    Upgrade currency = index == 1
        ? this.game.purchaseUpgrades[currencyNum]
        : this.game.followerUpgrades[currencyNum];
    UpgradeModel upgradeModel = index == 1
        ? purchaseUpgradeModels[currencyNum]
        : followerUpgradeModels[currencyNum];
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
                                '[${_toFixedString(currency.cost)}',
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
                          onPressed: () => _upgradeItem(this.game, currency, index)
                        ))),
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
                            upgradeModel.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            upgradeModel.description,
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
                        '+ ${_toFixedString(100 * (currency.multiplier - 1))} %',
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
                              '- ${_toFixedString(100 * (currency.multiplier - 1))} %',
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
      game.ch
          .purchasePassive(game.mainCurrencies[type], currency.baseProd);
      setState(() {
        game.mainCurrencies["Energy"].amount -= currency.cost;
        currency.amount = currency.amount + 1;
        currency.cost = currency.cost * 2.5;
        currency.baseProd = currency.baseProd * 1.05;
      });
      game.savePurchase(game.followerPurchases, type);
    }
  }

  _upgradeItem(MyGame game, Upgrade upgrade, int index) {
    if (index == 1 && game.mainCurrencies["Energy"].amount >= upgrade.cost) {
      game.upgradeHandler.passivePurchase(game, upgrade);
      setState(() {
        upgrade.cost = upgrade.cost * 5;
        upgrade.multiplier = upgrade.multiplier * 1.1;
        upgrade.amount = upgrade.amount + 1;
      });
    } else {
      print("Insufficent currency available for purchase.");
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
        game.savePurchase(game.energyPurchases, "Energy");
      } else if (index == 2) {
        game.ch.sellPassive(game.mainCurrencies["Followers"], currency);
        game.savePurchase(game.followerPurchases, "Followers");
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

List<UpgradeModel> purchaseUpgradeModels = [
  UpgradeModel(100, 0, 1.5, "Laminated pages ", "Make your Newspaper more premium.",
      "Energy"),
  UpgradeModel(2500, 0, 1.5, "Brazilian Coffee", "Improve your Intern's productivity.", "Energy"),
  UpgradeModel(50000, 0, 1.5, "Gilded Furniture",
      "Allow your followers more luxury.", "Energy"),
  UpgradeModel(1000000, 0, 1.5, "Holy Scripture",
      "Your word is spread more easily.", "Energy"),
];


List<UpgradeModel> followerUpgradeModels = [
  UpgradeModel(100, 0, 1.5, "New Writer ", "Articles published are higher quality.",
      "Followers"),
  UpgradeModel(2000, 0, 1.5, "Bigger Amp", "Your speaker is heard by more people.",
      "Followers"),
  UpgradeModel(30000, 0, 1.5, "Divine Robes", "The apostles now emanate mystic energy.",
      "Followers"),
  UpgradeModel(750000, 0, 1.5, "Fine Chianti", "Spread the reach of communion.",
      "Followers"),
];