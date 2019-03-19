import 'package:flutter/material.dart';
import '../game/game.dart';
import '../progress_button/progress_button.dart';

miracle(MyGame game) {
  if (game.mainCurrencies["Followers"].amount <= 0.0) {
  } else {
    game.ch.click(game.mainCurrencies["Energy"],
        f: game.mainCurrencies["Followers"]);
  }
}

class Category {
  const Category({this.name, this.icon, this.index});
  final String name;
  final IconData icon;
  final int index;
}

const List<Category> categories = <Category>[
  Category(name: 'Generate', icon: Icons.battery_charging_full, index: 1),
  Category(name: 'Augment', icon: Icons.stars, index: 2),
];

followers(MyGame game) {
  game.ch.click(game.mainCurrencies["Followers"]);
}

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
        child: Text("TEST")
      );
    }
  }

  Widget _currencyWidget(int index) {
    String type = index == 0 ? "Energy" : "Followers";
    return Container(
        color: Color(0xFFecf2f9),
        child: Container(
          margin:
              EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0, top: 16.0),
          child: Card(
              child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                child: Text(type,
                    style: TextStyle(
                      decorationStyle: TextDecorationStyle.wavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Column(children: <Widget>[
                (index == 1
                    ? Text(
                        'Net: ${this.game.mainCurrencies[type].passive - this.game.mainCurrencies["Energy"].passive} per second')
                    : Container(width: 0.0, height: 0.0)),
                Text((index == 0 ? '' : 'Gross: ') +
                    '${this.game.mainCurrencies[type].passive} per second'),
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
}