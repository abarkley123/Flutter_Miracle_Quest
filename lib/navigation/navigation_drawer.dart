import 'package:flutter/material.dart';
import '../game/game.dart';

Widget userInfoWidget(MyGame game, Widget energy, Widget followers) {
  return Container(
    color: Color(0xFFecf2f9),
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: <Widget>[
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0), child: energy),
            CircleAvatar(
              backgroundColor: Color.fromARGB(1, 0, 0, 0),
              child: Icon(
                Icons.flash_on,
                color: Color.fromARGB(255, 136, 14, 79),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: followers),
            CircleAvatar(
              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              child: Icon(Icons.supervised_user_circle, color: Colors.white),
            ),
          ],
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              tooltip: "VIP Store",
              onPressed: () => {},
            ),]
        ),
      ],
    ),
  );
}
