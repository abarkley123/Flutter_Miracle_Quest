import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import '../game/game.dart';

class FoldingCell extends StatefulWidget {
  final MyGame game;
  final Widget mainWidget;

  FoldingCell(this.game, {this.mainWidget});

  @override
  FoldingCellState createState() =>
      FoldingCellState(this.game, mainWidget: this.mainWidget);
}

class Category {
  final String name;
  final int index;

  const Category(this.name, this.index);
}

const List<Category> categories = <Category>[
  Category('Energy', 1),
  Category('Followers', 2),
];

class FoldingCellState extends State<FoldingCell> {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  final MyGame game;
  final Widget mainWidget;

  FoldingCellState(this.game, {this.mainWidget});

  // @override
  // Widget build(BuildContext context) {
  //   return new MaterialApp(
  //     home: new DefaultTabController(
  //       length: categories.length,
  //       child: new Scaffold(
  //           body: new TabBarView(
  //               children: categories.map((Category choice) {
  //         return new Padding(
  //           padding: const EdgeInsets.all(0.0),
  //           child: Text("hello"),
  //           //     SimpleFoldingCell(
  //           // key: _foldingCellKey,
  //           // frontWidget: _buildFrontWidget(this.mainWidget),
  //           // innerTopWidget: this.mainWidget != null ? _buildFrontWidget(this.mainWidget) : _buildInnerTopWidget(),
  //           // innerBottomWidget: _buildInnerBottomWidget(),
  //           // cellSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.3),
  //           // padding: EdgeInsets.all(10),
  //           // animationDuration: Duration(milliseconds: 300),
  //           // borderRadius: 15,
  //         );
  //       }).toList())),
  //     ),
  //   );
  // }

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
              );
            }).toList(),
          ),
        ),
        body: new TabBarView(
          children: categories.map((Category choice) {
            return new Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(choice.index.toString()),
            );
          }).toList(),
        ),
      ),
    ));
  }

  Widget _buildFrontWidget(Widget widget) {
    return Container(
        color: Color(0xFFecf2f9),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            this.widget != null
                ? mainWidget
                : Text("CARD",
                    style: TextStyle(
                        color: Color(0xFF2e282a),
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
          ],
        ));
  }

  Widget _buildInnerTopWidget() {
    return Container(
        color: Color(0xFFff9234),
        alignment: Alignment.center,
        child: Text("TITLE",
            style: TextStyle(
                color: Color(0xFF2e282a),
                fontFamily: 'OpenSans',
                fontSize: 20.0,
                fontWeight: FontWeight.w800)));
  }

//upgrade cards - swipeable
  Widget _buildInnerBottomWidget() {
    return Container(
      color: Color(0xFFecf2f9),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text("UPGRADES"),
      ),
    );
  }
}
