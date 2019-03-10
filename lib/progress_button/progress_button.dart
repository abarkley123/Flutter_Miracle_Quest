import 'package:flutter/material.dart';
import 'dart:async';
import '../game/game.dart';
import '../home/homepage.dart';

class ProgressButton extends StatefulWidget {

  final MyGame game;
  final String type;

  ProgressButton(this.game, this.type);

  @override
  State<StatefulWidget> createState() => _ProgressButtonState(this.game, this.type);
}

class _ProgressButtonState extends State<ProgressButton> with TickerProviderStateMixin {
  final MyGame game;
  final String type;
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Colors.blue,
        elevation: calculateElevation(),
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          key: _globalKey,
          height: 48.0,
          width: _width,
          child: RaisedButton(
            padding: EdgeInsets.all(0.0),
            color: _state == 2 ? (this.type.startsWith("E") && this.game.mainCurrencies["Followers"].amount <= 0 ? Colors.red : Colors.green
            ) : Colors.blue,
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

    Timer(Duration(milliseconds: 3000), () {
      setState(() {
        _state = 2;
      });
    });

    Timer(Duration(milliseconds: 4500), () {
      if (this.game.mainCurrencies["Followers"].amount >= 0) 
        this.type.startsWith("E") ? miracle(this.game) : followers(this.game);
      setState(() {
        _state = 0;
      });
    });
  }

  Widget buildButtonChild() {
    if (_state == 0) {
      return Text(
        'Generate ' + this.type,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      );
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
      return Icon(this.type.startsWith("E") && this.game.mainCurrencies["Followers"].amount <= 0 ? Icons.clear: Icons.check, color: Colors.white);
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
    //setState(() {
      _state = 0;
    //});
  }
}