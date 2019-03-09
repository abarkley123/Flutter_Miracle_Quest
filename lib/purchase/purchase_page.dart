import 'package:flutter/material.dart';
import '../game/game.dart';

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
    setPurchaseValues();
  }

  List<PurchaseModel> purchases = [
    PurchaseModel(999.0, 0, 1, "Newspaper ", "1"),
    PurchaseModel(830.0, 0, 5, "Intern", "2"),
    PurchaseModel(830.0, 0, 20, "Shrine", "3"),
    PurchaseModel(30.0, 0, 100, "Temple", "4"),
  ];

  void setPurchaseValues() {
    purchases[0].amount = game.prefs.getInt("Energy0Amount") ?? 0;
    purchases[1].amount = game.prefs.getInt("Energy1Amount") ?? 0;
    purchases[2].amount = game.prefs.getInt("Energy2Amount") ?? 0;
    purchases[3].amount = game.prefs.getInt("Energy3Amount") ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    this.width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Text(
                'Generate Energy',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: purchases.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _purchaseWidget(purchases[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _energyPurchase(MyGame game, PurchaseModel purchase) {
    setState(() {
          purchase.amount++;
    });
    game.ch.purchasePassive(game.mainCurrencies["Energy"], purchase.baseProd);
    game.saveEnergyPurchase(purchases[0].amount, purchases[1].amount, purchases[2].amount, purchases[3].amount);
  }

  _energySell(MyGame game, PurchaseModel purchase) {
    setState(() {
          purchase.amount--;
    });
    game.ch.purchasePassive(game.mainCurrencies["Energy"], purchase.baseProd);
    game.saveEnergyPurchase(purchases[0].amount, purchases[1].amount, purchases[2].amount, purchases[3].amount);
  }

  Widget _purchaseWidget(PurchaseModel purchase) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Column(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                    child: RaisedButton(
                      child: Text("Buy"),
                      onPressed: () => _energyPurchase(this.game, purchase),
                    )),
                Padding(
                    padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
                    child: RaisedButton(
                      child: Text("Sell"),
                      onPressed: () => _energySell(this.game, purchase),
                    )),
              ]),
              Expanded(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          purchase.title,
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
                          "Own ${purchase.amount}",
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text(
                          '- ${purchase.baseProd.ceil()} ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.supervised_user_circle, color: Colors.black)
                      ]),
                      Row(children: <Widget>[
                        Text(
                          '+ ${purchase.baseProd.ceil()} ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.flash_on,
                          color: Color.fromARGB(255, 136, 14, 79),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PurchaseModel {
  double cost;
  int amount;
  final double baseProd;
  final String title;
  final String description;

  PurchaseModel(
      this.cost, this.amount, this.baseProd, this.title, this.description);
}
