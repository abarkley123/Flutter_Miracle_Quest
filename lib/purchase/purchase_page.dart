import 'package:flutter/material.dart';
import '../game/game.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'purchase_logic.dart';

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
              itemCount:
                  choice.index == 1 ? purchases.length : followers.length,
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
    CurrencyModel currency =
        index == 1 ? purchases[currencyNum] : followers[currencyNum];
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
                          Text("Buy [${currency.cost.ceil()}",
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
                        onPressed: () => index == 1
                            ? _energyPurchase(this.game, currency)
                            : _followerPurchase(this.game, currency),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.indigoAccent,
                          child: Row(children: <Widget>[
                            Text("Sell [${currency.cost.ceil()}",
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
                          '+ ${currency.baseProd.ceil()} ',
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
                                '- ${currency.baseProd.ceil()} ',
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

  Widget _currencyUpgradeWidget(int index, int currencyNum) {
    UpgradeModel currency = index == 1
        ? purchaseUpgrades[currencyNum]
        : followerUpgrades[currencyNum];
    return Container(
      margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0, top: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: <Widget>[
              Column(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                    child: ButtonTheme(
                        height: 100.0,
                        minWidth: 100.0,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.indigoAccent,
                          child: Column(children: <Widget>[
                            Text("Upgrade",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            Row(children: <Widget>[
                              Text(
                                '[${currency.cost.ceil()}',
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
                          onPressed: () => index == 1
                              ? print('energy pressed')
                              : print('follower pressed'),
                        ))),
              ]),
              Expanded(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            currency.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            currency.description,
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
                        '+ ${currency.multiplier.ceil()} %',
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
                              '- ${currency.multiplier.ceil()} %',
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

  _followerPurchase(MyGame game, CurrencyModel purchase) {
    if (game.mainCurrencies["Energy"].amount >= purchase.cost) {
      setState(() {
        game.mainCurrencies["Energy"].amount -= purchase.cost;
        purchase.amount++;
      });
      game.ch
          .purchasePassive(game.mainCurrencies["Followers"], purchase.baseProd);
      game.saveFollowerPurchase(followers[0].amount, followers[1].amount,
          followers[2].amount, followers[3].amount);
    }
  }

  _energyPurchase(MyGame game, CurrencyModel purchase) {
    if (game.mainCurrencies["Energy"].amount >= purchase.cost) {
      setState(() {
        game.mainCurrencies["Energy"].amount -= purchase.cost;
        purchase.amount++;
      });
      game.ch.purchasePassive(game.mainCurrencies["Energy"], purchase.baseProd);
      game.saveEnergyPurchase(purchases[0].amount, purchases[1].amount,
          purchases[2].amount, purchases[3].amount);
    }
  }

  _sellItem(MyGame game, CurrencyModel currency, int index) {
    if (currency.amount >= 1) {
      setState(() {
        currency.amount--;
      });
      if (index == 1) {
        game.ch.sellPassive(game.mainCurrencies["Energy"], currency.baseProd);
        game.saveEnergyPurchase(purchases[0].amount, purchases[1].amount,
            purchases[2].amount, purchases[3].amount);
      } else if (index == 2) {
        game.ch
            .sellPassive(game.mainCurrencies["Followers"], currency.baseProd);
        game.saveFollowerPurchase(purchases[0].amount, purchases[1].amount,
            purchases[2].amount, purchases[3].amount);
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
