import 'package:flutter/material.dart';
import '../game/game.dart';
import '../progress_button/progress_button.dart';

miracle(MyGame game) {
  if (game.mainCurrencies["Followers"].amount <= 0.0) {

  } else {
    game.ch.click(game.mainCurrencies["Energy"], f: game.mainCurrencies["Followers"]);
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
//  EdgeInsets smallItemPadding;

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
              child: _mainWidget(),
            );
          }).toList(),
        ),
      ),
    ));
  }

  Widget _mainWidget() {
    return Container(
      color: Color(0xFFecf2f9),
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Text('Energy',
                  style: TextStyle(
                    decorationStyle: TextDecorationStyle.wavy,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Text(
                  '${this.game.mainCurrencies["Energy"].passive} per second')),
          Container(
            height: 80.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                      child: ProgressButton(this.game, "Energy")),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Text('Followers',
                  style: TextStyle(
                    decorationStyle: TextDecorationStyle.wavy,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))),
          Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Text(
                  'Net: ${(this.game.mainCurrencies["Followers"].passive * this.game.mainCurrencies["Followers"].modifier) - (this.game.mainCurrencies["Energy"].passive * this.game.mainCurrencies["Energy"].modifier)} per second')),
            
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Text(
                  'Gross: ${this.game.mainCurrencies["Followers"].passive * this.game.mainCurrencies["Followers"].modifier} per second')),
          ],),
          Container(
              height: 80.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                          child: ProgressButton(this.game, "Followers")),
                    )
                  ]))
        ],
      ),
    );
  }  
}
