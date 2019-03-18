import 'package:flutter/material.dart';
import '../game/game.dart';
import '../util/open_card.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PurchasePage extends StatefulWidget {
  final MyGame game;

  PurchasePage(this.game);

  @override
  PurchasePageState createState() => PurchasePageState(game);
}

List<CurrencyModel> purchases = [
  CurrencyModel(1, 0, 1, "Newspaper ", "1"),
  CurrencyModel(10, 0, 5, "Intern", "2"),
  CurrencyModel(50, 0, 20, "Shrine", "3"),
  CurrencyModel(500, 0, 100, "Temple", "4"),
];

class PurchasePageState extends State<PurchasePage> {
  double width;
  final MyGame game;

  PurchasePageState(this.game) {
    setPurchaseValues();
  }

  void setPurchaseValues() {
    purchases[0].amount = game.prefs.getInt("Energy0Amount") ?? 0;
    purchases[1].amount = game.prefs.getInt("Energy1Amount") ?? 0;
    purchases[2].amount = game.prefs.getInt("Energy2Amount") ?? 0;
    purchases[3].amount = game.prefs.getInt("Energy3Amount") ?? 0;
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
          child: Text(
            'Generate ' + (choice.index == 1 ? 'Energy' : 'Followers'),
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  choice.index == 1 ? purchases.length : followers.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
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
    CurrencyModel currency = index == 1 ? purchases[currencyNum] : followers[currencyNum];
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
                          Text("Buy "),
                          Text("[${currency.cost.ceil()}]",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        onPressed: () => index == 1 ? _energyPurchase(this.game, currency) : _followerPurchase(this.game, currency),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.indigoAccent,
                        child: Row(children: <Widget>[
                          Text("Sell "),
                          Text("[${currency.cost.ceil()}]",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        onPressed: () => index == 1 ? _energySell(this.game, currency) : _followerSell(this.game, currency),
                      )),
                ]),
                Expanded(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            currency.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                        Icon(Icons.supervised_user_circle, color: Colors.black)
                      ]),
                      index == 1
                          ? Row(children: <Widget>[
                              Text(
                                '- ${currency.baseProd.ceil()} ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.flash_on,
                                color: Color.fromARGB(255, 136, 14, 79),
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

  _followerPurchase(MyGame game, CurrencyModel purchase) {
    if (game.mainCurrencies["Energy"].amount >= purchase.cost) {
      setState(() {
        purchase.amount++;
      });
      game.ch
          .purchasePassive(game.mainCurrencies["Followers"], purchase.baseProd);
      game.saveFollowerPurchase(purchases[0].amount, purchases[1].amount,
          purchases[2].amount, purchases[3].amount);
    }
  }

  _followerSell(MyGame game, CurrencyModel purchase) {
    if (purchase.amount >= 1) {
      setState(() {
        purchase.amount--;
      });
      game.ch
          .purchasePassive(game.mainCurrencies["Followers"], purchase.baseProd);
      game.saveFollowerPurchase(purchases[0].amount, purchases[1].amount,
          purchases[2].amount, purchases[3].amount);
    }
  }

  Widget _currencyUpgradeWidget(int index, int currencyNum) {
    CurrencyModel currency = index == 1 ? purchases[currencyNum] : followers[currencyNum];
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
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.indigoAccent,
                      child: Row(children: <Widget>[
                        Text("Buy "),
                        Text("[${currency.cost.ceil()}]",
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ]),
                      onPressed: () => index == 1 ? _energyPurchase(this.game, currency) : _followerPurchase(this.game, currency),
                    )),
              ]),
              Expanded(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Upgrade",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                        '+ ${currency.baseProd.ceil()} %',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.supervised_user_circle, color: Colors.black)
                    ]),
                    index == 1
                          ? Row(children: <Widget>[
                              Text(
                                '- ${currency.baseProd.ceil()} %',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.flash_on,
                                color: Color.fromARGB(255, 136, 14, 79),
                              ),
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

  _energySell(MyGame game, CurrencyModel purchase) {
    if (purchase.amount >= 1) {
      setState(() {
        purchase.amount--;
      });
      game.ch
          .purchasePassive(game.mainCurrencies["Energy"], -purchase.baseProd);
      game.saveEnergyPurchase(purchases[0].amount, purchases[1].amount,
          purchases[2].amount, purchases[3].amount);
    }
  }
}

const List<Category> categories = <Category>[
  Category(name: 'Energy', icon: Icons.offline_bolt, index: 1),
  Category(name: 'Followers', icon: Icons.supervised_user_circle, index: 2),
];

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

class Category {
  const Category({this.name, this.icon, this.index});
  final String name;
  final IconData icon;
  final int index;
}

List<CurrencyModel> followers = [
  CurrencyModel(1, 0, 1, "Articles ", "1"),
  CurrencyModel(4, 0, 5, "Loudspeaker", "2"),
  CurrencyModel(40, 0, 20, "Apostles", "3"),
  CurrencyModel(350, 0, 100, "Communion", "4"),
];

void setFollowerValues(game) {
  followers[0].amount = game.prefs.getInt("Follower0Amount") ?? 0;
  followers[1].amount = game.prefs.getInt("Follower1Amount") ?? 0;
  followers[2].amount = game.prefs.getInt("Follower2Amount") ?? 0;
  followers[3].amount = game.prefs.getInt("Follower3Amount") ?? 0;
}

class CurrencyModel {
  double cost;
  int amount;
  final double baseProd;
  final String title;
  final String description;

  CurrencyModel(
      this.cost, this.amount, this.baseProd, this.title, this.description);
}
