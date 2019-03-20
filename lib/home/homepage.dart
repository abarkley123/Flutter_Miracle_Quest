import 'package:flutter/material.dart';
import '../game/game.dart';
import '../progress_button/progress_button.dart';


class HomePage extends StatefulWidget {
  MyGame game;

  HomePage(this.game);

  @override
  HomePageState createState() => HomePageState(this.game);
}

class HomePageState extends State<HomePage> {
  MyGame game;

  HomePageState(this.game);

  double screenWidth = 0.0;

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
            return _clickWidget(choice.index);
          }).toList(),
        ),
      ),
    ));
  }

  Widget _clickWidget(int choice) {
    if (choice == 1) {
      return new Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return _currencyWidget(index);
            }),
      );
    } else {
      return new Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: upgrades.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  color: Color(0xFFecf2f9),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  child: _purchaseUpgradeWidget(index));
            }),
      );
    }
  }

  Widget _currencyWidget(int index) {
    String type = index == 0 ? "Energy" : "Followers";
    return Container(
        color: Color(0xFFecf2f9),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
              child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: Text(type,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Column(children: <Widget>[
                (index == 1
                    ? Text(
                        'Net: ${(this.game.mainCurrencies[type].passive - this.game.mainCurrencies["Energy"].passive).toStringAsFixed(1)} per second',
                        style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 19, 193, 100),
                    ))
                    : Container(width: 0.0, height: 0.0)),
                Text(
                    (index == 0 ? '' : 'Gross: ') +
                        '${this.game.mainCurrencies[type].passive} per second',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 136, 14, 79),
                    )),
              ]),
            ),
            Container(
              height: 80.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child:
                        GestureDetector(child: ProgressButton(this.game, type)),
                  ),
                ],
              ),
            ),
          ])),
        ));
  }

  Widget _purchaseUpgradeWidget(int index) {
    UpgradeModel upgrade = upgrades[index];
    print(upgrade.type);
    print(this.game.upgrades);
    print(this.game.upgrades["Click"].cost.toString());
    print(this.game.upgrades[upgrade.type].cost.toString());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(children: <Widget>[
                Expanded(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${upgrade.title}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
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
                            "${upgrade.description} ${(100 * game.upgrades[upgrade.type].multiplier - 100).toStringAsFixed(1)}%",
                            style:TextStyle(fontWeight: FontWeight.bold, color:Color.fromARGB(255, 19, 193, 100),),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Column(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.indigoAccent,
                          child: Row(children: <Widget>[
                            Text(
                                "Buy [${game.upgrades[upgrade.type].cost.ceil()}",
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
                              _processUpgrade(this.game, upgrade.type))),
                ]),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _processUpgrade(MyGame game, type) {
    if (game.mainCurrencies["Energy"].amount >= game.upgrades[type].cost) {
      setState(() {
        game.upgrades[type] = game.upgradeHandler.activePurchase(game, type);
      });
      game.saveActive();
      game.saveClickUpgrade(type);
    } else {
      print("Not enough energy for upgrade.");
    }
  }
}

class UpgradeModel {
  final String title;
  final String description;
  final String type;

  UpgradeModel(this.title,this.description, this.type);
}

List<UpgradeModel> upgrades = [
  UpgradeModel("Power ", "Power +", "Click"),
  UpgradeModel("Speed", "Speed +", "Tick"),
  UpgradeModel("Luck", "Critical +", "Critical"),
];

void miracle(MyGame game) {
  if (game.mainCurrencies["Followers"].amount <= 0.0) {
  } else {
    game.ch.click(game.mainCurrencies["Energy"],
        f: game.mainCurrencies["Followers"]);
  }
}

void followers(MyGame game) {
  game.ch.click(game.mainCurrencies["Followers"]);
}

class Category {
  const Category({this.name, this.icon, this.index});
  final String name;
  final IconData icon;
  final int index;
}

//could create a generic 'categories controller' and refactor the creation of this class to something generic
const List<Category> categories = <Category>[
  Category(name: 'Generate', icon: Icons.account_circle, index: 1),
  Category(name: 'Augment', icon: Icons.stars, index: 2),
];
