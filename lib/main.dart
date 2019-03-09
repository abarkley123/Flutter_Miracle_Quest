import 'package:flutter/material.dart';
import 'package:flutter_miracle_quest/history/history_page.dart';
import 'home/homepage.dart';
import 'package:flutter_miracle_quest/profile/profile_page.dart';
import 'package:flutter_miracle_quest/settings/settings_page.dart';
import 'game/game.dart';
import 'package:flame/flame.dart';
import 'navigation/navigation_drawer.dart';
import 'dart:async';

void main() async {
  MyGame game = new MyGame();
  MyHomePage home = new MyHomePage(game);
  MyApp myApp = new MyApp(game, home);
  Flame.util.initialDimensions();
  Flame.audio.disableLog();
  game.widget = myApp;
  Timer.periodic(new Duration(seconds: 1), (timer) {
    game.update(0);
    home.hps.energy.state._updateSeconds(game.mainCurrencies["Energy"].amount);
    home.hps.followers.state._updateSeconds(game.mainCurrencies["Followers"].amount);
  });

  runApp(game.widget);
}

class MyApp extends StatelessWidget {
  final MyGame _game;
  final MyHomePage _myHomePage;

  MyApp(this._game, this._myHomePage);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: _myHomePage,
    );
  }

  get home {
    return this._myHomePage;
  }
}

class MyHomePage extends StatefulWidget {
  final MyGame _game;
  _MyHomePageState hps;

  MyHomePage(this._game) {
    this.hps = new _MyHomePageState(_game);
  }

  @override
  _MyHomePageState createState() => this.hps;
}

class MyAppBar extends AppBar {
  MyAppBar({Key key, Widget title}) : super(key: key, title: title);

  set title(Widget value) {
    this.title = value;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _curIndex = 0;
  MyGame _game;
  MyAppBar _myAppBar;
  MyTextWidget energy = MyTextWidget();
  MyTextWidget followers = MyTextWidget();

  _MyHomePageState(this._game) {
    this._myAppBar =
        new MyAppBar(title: userInfoWidget(this._game, energy, followers));
  }

  get appBar {
    return this._myAppBar;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(),
      appBar: this._myAppBar,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _curIndex,
          onTap: (index) {
            _curIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _curIndex == 0 ? Colors.black : Colors.grey),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.offline_bolt,
                  color: _curIndex == 1 ? Colors.black : Colors.grey),
              title: Text(
                'Energy',
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on,
                  color: _curIndex == 2 ? Colors.black : Colors.grey),
              title: Text(
                'Followers',
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store,
                  color: _curIndex == 3 ? Colors.black : Colors.grey),
              title: Text(
                'Store',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ]),
      body: new Center(
        child: _getWidget(),
      ),
    );
  }

  Widget _getWidget() {
    switch (_curIndex) {
      case 0:
        return Container(
          color: Colors.red,
          child: HomePage(this._game),
        );
        break;
      case 1:
        return Container(
          child: HistoryPage(),
        );
        break;
      case 2:
        return Container(
          child: ProfilePage(),
        );
        break;
      default:
        return Container(
          child: SettingsPage(),
        );
        break;
    }
  }
}

class MyTextWidget extends StatefulWidget {
  _MyTextWidgetState state;

  MyTextWidget() {
    this.state = new _MyTextWidgetState();
  }

  @override
  _MyTextWidgetState createState() => this.state;
}

class _MyTextWidgetState extends State<MyTextWidget> {
  double amountToDisplay = 0;

  void _updateSeconds(double newSeconds) {
    setState(() {
      amountToDisplay = newSeconds;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      amountToDisplay.toString(),
      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
    );
  }
}
