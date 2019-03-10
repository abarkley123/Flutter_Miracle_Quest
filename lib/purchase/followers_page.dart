import 'package:flutter/material.dart';
import '../game/game.dart';

class FollowerPurchasePage extends StatefulWidget {
  final MyGame game;

  FollowerPurchasePage(this.game);

  @override
  FollowerPurchasePageState createState() => FollowerPurchasePageState(game);
}

class FollowerPurchasePageState extends State<FollowerPurchasePage> {
//   double width;
  final MyGame game;

  FollowerPurchasePageState(this.game) {
    // setPurchaseValues();
  }

//   List<PurchaseModel> purchases = [
//     PurchaseModel(1, 0, 1, "Articles ", "1"),
//     PurchaseModel(4, 0, 5, "Loudspeaker", "2"),
//     PurchaseModel(40, 0, 20, "Apostles", "3"),
//     PurchaseModel(350, 0, 100, "Communion", "4"),
//   ];

//   void setPurchaseValues() {
//     purchases[0].amount = game.prefs.getInt("Follower0Amount") ?? 0;
//     purchases[1].amount = game.prefs.getInt("Follower1Amount") ?? 0;
//     purchases[2].amount = game.prefs.getInt("Follower2Amount") ?? 0;
//     purchases[3].amount = game.prefs.getInt("Follower3Amount") ?? 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     this.width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Color(0xFFF4F4F4),
//       body: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
//               child: Text(
//                 'Generate Energy',
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: purchases.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return _purchaseWidget(purchases[index]);
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _followerPurchase(MyGame game, PurchaseModel purchase) {
//     if (game.mainCurrencies["Energy"].amount >= purchase.cost) {
//       setState(() {
//         purchase.amount++;
//       });
//       game.ch
//           .purchasePassive(game.mainCurrencies["Followers"], purchase.baseProd);
//       game.saveFollowerPurchase(purchases[0].amount, purchases[1].amount,
//           purchases[2].amount, purchases[3].amount);
//     }
//   }

//   _followerSell(MyGame game, PurchaseModel purchase) {
//     if (purchase.amount >= 1) {
//       setState(() {
//         purchase.amount--;
//       });
//       game.ch
//           .purchasePassive(game.mainCurrencies["Followers"], purchase.baseProd);
//       game.saveFollowerPurchase(purchases[0].amount, purchases[1].amount,
//           purchases[2].amount, purchases[3].amount);
//     }
//   }

//   Widget _purchaseWidget(PurchaseModel purchase) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             children: <Widget>[
//               Column(children: <Widget>[
//                 Padding(
//                     padding: const EdgeInsets.only(right: 16.0, top: 8.0),
//                     child: RaisedButton(
//                            child: Row(children: <Widget>[
//                         Text("Buy "),
//                         Text("[${purchase.cost.ceil()}]",
//                             style: TextStyle(fontWeight: FontWeight.bold))
//                       ]),
//                       onPressed: () => _followerPurchase(this.game, purchase),
//                     )),
//                 Padding(
//                     padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
//                     child: RaisedButton(
//                           child: Row(children: <Widget>[
//                         Text("Sell "),
//                         Text("[${purchase.cost.ceil()}]",
//                             style: TextStyle(fontWeight: FontWeight.bold))
//                       ]),
//                       onPressed: () => _followerSell(this.game, purchase),
//                     )),
//               ]),
//               Expanded(
//                 child: Column(children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           purchase.title,
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.left,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           "Own ${purchase.amount}",
//                           textAlign: TextAlign.left,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       Row(children: <Widget>[
//                         Text(
//                           '+ ${purchase.baseProd.ceil()} ',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Icon(Icons.supervised_user_circle, color: Colors.black)
//                       ]),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PurchaseModel {
//   double cost;
//   int amount;
//   final double baseProd;
//   final String title;
//   final String description;

//   PurchaseModel(
//       this.cost, this.amount, this.baseProd, this.title, this.description);
// }

//Our Category Dat

// List of Category Data objects.
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
