import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {

  double width; 

  List<PurchaseModel> purchases = [
    //PurchaseModel(this.assetPath, this.cost, this.amount, this.name, this.description, this.title);
    PurchaseModel('images/ico_send_money.png', 999.0, 0, "Energy increasing", "Oi"),
    PurchaseModel('images/ico_pay_elect.png', 830.0, 0, "Energy improving", "Ay"),
    PurchaseModel('images/ico_pay_phone.png', 830.0, 0, "Energy swelling", "Eh"),
    PurchaseModel('images/ico_receive_money.png', 30.0, 0, "Energy soaring", "La"),
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                    return _historyWidget(purchases[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyWidget(PurchaseModel purchase) {
    return Container(
//      height: 100.0,
    margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.asset(
                  purchase.assetPath,
                  height: 40.0,
                  width: 40.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        purchase.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                      ),
                      Text(purchase.description)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '\$${purchase.amount}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Debit from \non ${purchase.title}',
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            // child: Image.asset(
                            //   // history.cardLogoPath,
                            // ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PurchaseModel {

  final String assetPath;
  final double cost;
  final int amount;
  final String title;
  final String description;

  PurchaseModel(this.assetPath, this.cost, this.amount, this.title, this.description);
}