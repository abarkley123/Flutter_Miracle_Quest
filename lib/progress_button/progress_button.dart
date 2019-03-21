import 'package:flutter/material.dart';
import 'dart:async';
import '../game/game.dart';
import 'dart:math';

class ProgressButton extends StatefulWidget {
  final MyGame game;
  final String type;

  ProgressButton(this.game, this.type);

  @override
  State<StatefulWidget> createState() =>
      _ProgressButtonState(this.game, this.type);
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  final MyGame game;
  final String type;
  bool isCritical = false;
  bool _isPressed = false, _animatingReveal = false;
  int _state = 0;
  double _width = double.infinity;
  Animation _animation;
  GlobalKey _globalKey = GlobalKey();
  AnimationController _controller;

  _ProgressButtonState(this.game, this.type);

  @override
  void deactivate() {
    reset();
    super.deactivate();
  }

  @override
  dispose() {
    try {
      _controller.dispose();
    } catch (exception) {
      print("Problems disposing progress button animation controller..");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Colors.indigoAccent,
        elevation: calculateElevation(),
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          key: _globalKey,
          height: 48.0,
          width: _width,
          child: RaisedButton(
            padding: EdgeInsets.all(0.0),
            color: _state == 2
                ? (this.type.startsWith("E") &&
                        this.game.mainCurrencies["Followers"].amount <= 0
                    ? Colors.red
                    : this.isCritical ? Color.fromARGB(255, 136, 14, 79) : Colors.green)
                : Colors.indigoAccent,
            child: buildButtonChild(),
            onPressed: () {},
            onHighlightChanged: (isPressed) {
              setState(() {
                _isPressed = isPressed;
                if (_state == 0) {
                  animateButton();
                }
              });
            },
          ),
        ));
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;
    int random = new Random().nextInt(100);
    int critical = ((this.game.upgrades["Critical"].multiplier - 1) * 100).ceil();
    if (random <= critical) {
      this.isCritical = true;
    }

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48.0) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });
    double tickMultiplier = this.game.upgrades["Tick"].multiplier;
    Timer(Duration(milliseconds: (3000 / tickMultiplier).ceil()), () {
      setState(() {
        _state = 2;
      });
    });

    Timer(Duration(milliseconds: (4500 / tickMultiplier).ceil()), () {
      if (this.game.mainCurrencies["Followers"].amount >= 0)
        this.type.startsWith("E") ? game.doMiracle(this.game, isCritical: this.isCritical) : game.doAscension(game, isCritical: this.isCritical);
      setState(() {
        _state = 0;
      });
    });
  }

  Widget buildButtonChild() {
    if (_state == 0) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  this.game.mainCurrencies[type].title,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                '+ ' +
                    (this.type.startsWith("E")
                        ? this
                            .game
                            .mainCurrencies["Energy"]
                            .incrementable
                            .toStringAsFixed(1)
                        : this
                            .game
                            .mainCurrencies["Followers"]
                            .incrementable
                            .toStringAsFixed(1)) +
                    " ",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              Icon(
                this.type.startsWith("E") ? Icons.flash_on : Icons.person,
                color: this.type.startsWith("E")
                    ? Color.fromARGB(255, 136, 14, 79)
                    : Color.fromARGB(255, 19, 193, 100),
              ),
              (this.type.startsWith("E")
                  ? Text(
                      '- ' +
                          this
                              .game
                              .mainCurrencies["Followers"]
                              .incrementable
                              .toStringAsFixed(1) +
                          " ",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    )
                  : Container(width: 0.0, height: 0.0)),
              (this.type.startsWith("E")
                  ? Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 19, 193, 100),
                    )
                  : Container(width: 0.0, height: 0.0)),
            ]),
          ]);
    } else if (_state == 1) {
      return SizedBox(
        height: 36.0,
        width: 36.0,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        this.isCritical
            ? Text(
                "Critical",
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              )
            : Container(width: 0.0, height: 0.0),
        Icon(
            this.type.startsWith("E") &&
                    this.game.mainCurrencies["Followers"].amount <= 0
                ? Icons.clear
                : this.isCritical ? Icons.whatshot : Icons.check,
            color: Colors.white),
      ]);
    }
  }

  double calculateElevation() {
    if (_animatingReveal) {
      return 0.0;
    } else {
      return _isPressed ? 6.0 : 4.0;
    }
  }

  void reset() {
    _width = double.infinity;
    _animatingReveal = false;
    _state = 0;
  }
}
