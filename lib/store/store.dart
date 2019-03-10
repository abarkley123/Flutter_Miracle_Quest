import 'package:flutter/material.dart';
import '../game/game.dart';

class StorePage extends StatefulWidget {
  final MyGame game;

  StorePage(this.game);

  @override
  StorePageState createState() => StorePageState(game);
}

class StorePageState extends State<StorePage> {
  double width;
  final MyGame game;

  StorePageState(this.game) {
    // setPurchaseValues();
  }

static const List<Category> categories = <Category>[
    Category(name: 'Upgrades', icon: Icons.assessment),
    Category(name: 'Perks', icon: Icons.code),
    Category(name: 'VIP Store', icon: Icons.people),
  ];

// Our MrTabs class.
//Will build and return our app structure.
// class MrTabs extends StatelessWidget {
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
                child: new CategoryCard(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
      theme: new ThemeData(primaryColor: Colors.deepOrange),
    );
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

class Category {
  const Category({this.name, this.icon});
  final String name;
  final IconData icon;
}
