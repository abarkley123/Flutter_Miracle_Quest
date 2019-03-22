import 'package:flutter/material.dart';
import 'purchase/purchase_page.dart';
import 'home/homepage.dart';
import 'package:flutter_miracle_quest/settings/settings_page.dart';
import 'game/game.dart';
import 'package:flame/flame.dart';
import 'navigation/navigation_drawer.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'util/util.dart';
import 'store/store.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  MyGame game = new MyGame(prefs);
  MyHomePage home = new MyHomePage(game);
  MyApp myApp = new MyApp(game, home);
  Flame.util.initialDimensions();
  Flame.audio.disableLog();
  game.widget = myApp;

  double cycles = 0;
  Timer.periodic(new Duration(seconds: 1), (timer) {
    game.update(cycles++);
    home.hps.energy.state._updateSeconds(game.mainCurrencies["Energy"].amount);
    home.hps.followers.state._updateSeconds(game.mainCurrencies["Followers"].amount);
    if (cycles % 20 == 0) game.saveData();
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
        primaryColor: Colors.indigoAccent,
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
      drawer: Drawer(
          child: new Container(
        constraints: new BoxConstraints.expand(
          width: MediaQuery.of(context).size.width - 20,
        ),
        color: Colors.white,
        alignment: Alignment.center,
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
                padding: const EdgeInsets.all(16.0),
                child: new UserAccountsDrawerHeader(
                  accountName: new Container(
                    width: 0.0,
                    height: 0.0,
                  ),
                   accountEmail: new Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [Text('Miracle Quest',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    )],
                  ),
                  currentAccountPicture: FlutterLogo(),
                  decoration: new BoxDecoration(
                    color: Colors.blue[50],
                  ),
                ),
                decoration: new BoxDecoration(color: Colors.blue[50])),
             new ListTile(
                leading: new Icon(Icons.home),
                title: new Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                  _curIndex = 0;
                  setState(() {});
                }),
            new ListTile(
                leading: new Icon(Icons.offline_bolt),
                title: new Text("Purchases"),
                onTap: () {
                  Navigator.pop(context);
                  _curIndex = 1;
                  setState(() {});
                }),
            new ListTile(
                leading: new Icon(Icons.account_balance),
                title: new Text("Advanced"),
                onTap: () {
                  Navigator.pop(context);
                  _curIndex = 2;
                  setState(() {});
                }),
            new ListTile(
                leading: new Icon(Icons.settings),
                title: new Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                  _curIndex = 3;
                  setState(() {});
                }),
            new ListTile(
                leading: new Icon(Icons.close),
                title: new Text("Close"),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      )),
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
                'Production',
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store,
                  color: _curIndex == 2 ? Colors.black : Colors.grey),
              title: Text(
                'Store',
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,
                  color: _curIndex == 3 ? Colors.black : Colors.grey),
              title: Text(
                'Settings',
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
        //return Container(child: PurchasePage(this._game));
        return Container(child: PurchasePage(this._game));
        break;
      case 2:
        return Container(child: StorePage(this._game));
        break;
      case 3:
        return Container(child: SettingsPage(this._game));
        break;
      default:
        return Container(
          child: SettingsPage(this._game),
        );
        break;
    }
  }
}

class MyTextWidget extends StatefulWidget {

  final _MyTextWidgetState state = new _MyTextWidgetState();

  MyTextWidget();

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
      truncateBigValue(amountToDisplay),
      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
    );
  }
}
