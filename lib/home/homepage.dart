import 'package:flutter/material.dart';
import 'package:flutter_miracle_quest/send_money_flow/select_account_page.dart';
import 'package:flutter_miracle_quest/widgets/bank_card.dart';
import '../game/game.dart';

class HomePage extends StatefulWidget {

  MyGame game;

  HomePage(this.game);

  @override
  HomePageState createState() => HomePageState(this.game);
}

class HomePageState extends State<HomePage> {

  MyGame game;

  HomePageState(this.game);

  final List<BankCardModel> cards = [
    BankCardModel('images/bg_red_card.png', 'Hoang Cuu Long',
        '4221 5168 7464 2283', '08/20', 10000000),
    BankCardModel('images/bg_blue_circle_card.png', 'Hoang Cuu Long',
        '4221 5168 7464 2283', '08/20', 10000000),
    BankCardModel('images/bg_purple_card.png', 'Hoang Cuu Long',
        '4221 5168 7464 2283', '08/20', 10000000),
    BankCardModel('images/bg_blue_card.png', 'Hoang Cuu Long',
        '4221 5168 7464 2283', '08/20', 10000000),
  ];

  double screenWidth = 0.0;
//  EdgeInsets smallItemPadding;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _userBankCardsWidget();
            } 
            // else if (index == 1) {
            //   return _sendMoneySectionWidget();
            // } /* else {
            //   return _utilitesSectionWidget();
            //  } */
          }),
    );
  }

  _miracle() {
    this.game.ch.click(this.game.mainCurrencies["Energy"], f: this.game.mainCurrencies["Followers"]);
  } 

  _followers() {
    print(this.game.mainCurrencies["Followers"]);
    this.game.ch.click(this.game.mainCurrencies["Followers"]);
  } 

  Widget _userBankCardsWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Text('0 per second')),
          Container(
            height: 80.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: 
                      _miracle
                    ,
                    child: RaisedButton(
                      child: Text("Get Energy"),
                      onPressed: _miracle,
                    )
                  ),
                 ),

              ],
            ),
          ),
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Text('0 per second')
              ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 8.0),
          //   height: 166.0,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 4,
          //     itemBuilder: (BuildContext context, int index) {
          //       return _getBankCard(index);
          //     },
          //   ),
          // ),
           Container(
            height: 80.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: 
                      _followers,
                    child: RaisedButton(
                      child: Text("Get Followers"),
                      onPressed: _followers,
                    )
                  )
                )
              ]
            )
           )
        ],
      ),
    );
  }

  Widget _sendMoneySectionWidget() {
    var smallItemPadding = EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0);
    if (screenWidth <= 320) {
      smallItemPadding = EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0);
    }
    return Container(
//      color: Colors.yellow,
      margin: EdgeInsets.all(16.0),
//      height: 200.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Send money to',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTapUp: null,
                child: Text('View all'),
              )
            ],
          ),
          Container(
            height: 100.0,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'images/ico_add_new.png',
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Add new'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text('T'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Salina'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text('T'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Emily'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text('T'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Nichole'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _utilitesSectionWidget() {
    var smallItemPadding = EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0);
    if (screenWidth <= 320) {
      smallItemPadding = EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0);
    }
    return Container(
//      color: Colors.yellow,
      margin: EdgeInsets.all(16.0),
//      height: 200.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Utilities',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 80.0,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'images/ico_pay_phone.png',
                          height: 26.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child:
                              Text('Mobile', style: TextStyle(fontSize: 12.0)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'images/ico_pay_elect.png',
                          height: 26.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Electricity',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'images/ico_pay_broad.png',
                          height: 26.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Broadband',
                              style: TextStyle(fontSize: 12.0)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: smallItemPadding,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'images/ico_pay_gas.png',
                          height: 26.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Gas', style: TextStyle(fontSize: 12.0)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getBankCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BankCard(card: cards[index]),
    );
  }
}
