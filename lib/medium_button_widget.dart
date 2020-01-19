import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

enum ScoreWidgetStatus {
  HIDDEN,
  BECOMING_VISIBLE,
  VISIBLE,
  BECOMING_INVISBLE,
}

class MediumButtonWidget extends StatefulWidget {
  final onTap;


  const MediumButtonWidget({Key key, this.onTap}) :super(key:key);

  @override
  State<StatefulWidget> createState() {
    return MediumButtonWidgetState();
  }
}

class MediumButtonWidgetState extends State<MediumButtonWidget> with TickerProviderStateMixin {
  int _counter = 0;
  double _sparksAngel = 0.0;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
  Timer scoreOutTimer;
  Timer holderTimer;
  Random random;

  final duration = new Duration(milliseconds: 400);

  AnimationController scoreInAnimationController;
  AnimationController scoreOutAnimationController;
  AnimationController scoreSizeAnimationController;
  AnimationController sparklesAnimationController;

  Animation scoreOutPositionAnimation;
  Animation sparklesAnimation;

  @override
  void initState() {
    super.initState();
    random = new Random();

    // ScoreIn Animation
    scoreInAnimationController = new AnimationController(duration: duration, vsync: this);
    scoreInAnimationController.addListener((){
       setState(() {   });
    });

    // ScoreOut Animation
    scoreOutAnimationController = new AnimationController(duration: duration,vsync: this);
    scoreOutPositionAnimation = new Tween(begin: 100.0,end: 150.0).animate(
     new CurvedAnimation(parent: scoreOutAnimationController, curve: Curves.easeOut)
    );
    scoreOutPositionAnimation.addListener((){
       setState(() {});
    });
    scoreOutAnimationController.addStatusListener((status){
      if(status == AnimationStatus.completed) {
         _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
       }
    });

    scoreSizeAnimationController = new AnimationController(duration: new Duration(milliseconds: 150),vsync: this);
    scoreSizeAnimationController.addStatusListener((status){
      if(status == AnimationStatus.completed) {
        scoreSizeAnimationController.reverse();
      }
    });
    scoreSizeAnimationController.addListener((){
      setState(() { });
    });

    sparklesAnimationController = new AnimationController(duration: duration,vsync: this);
    sparklesAnimation = new CurvedAnimation(parent: sparklesAnimationController, curve: Curves.easeIn);
    sparklesAnimation.addListener((){
      setState(() { });
    });
  }

  @override
  void dispose() {
    super.dispose();

    scoreSizeAnimationController.dispose();
    scoreInAnimationController.dispose();
    scoreOutAnimationController.dispose();
    scoreOutTimer.cancel();
    holderTimer.cancel();
  }

  void increamentCounter(Timer t) {
    sparklesAnimationController.forward(from: 0.0);
    scoreSizeAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
      widget.onTap(_counter);
      _sparksAngel = random.nextDouble() * 2 * pi;
    });
  }

  void onTapUp(TapUpDetails tap) {
    scoreOutTimer = new Timer(duration, (){
      scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_INVISBLE;
    });
    holderTimer.cancel();
  }

  void onTapDown(TapDownDetails tap) {
     if (scoreOutTimer != null) {
      scoreOutTimer.cancel();
    }

    if (_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISBLE) {
      scoreSizeAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    } else if (_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN) {
      scoreInAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
    }
    increamentCounter(null);
    holderTimer = new Timer.periodic(duration, increamentCounter);
  }

  Widget getScoreButton() {
    var scorePosition = 0.0;
    var scoreOpacoity = 0.0;
    var extraSize = 0.0;
    var stackChildren = <Widget>[];

    var firstAngle = _sparksAngel;
    var sparkleRadius = (sparklesAnimationController.value * 50);
    var sparklesOpacity = (1 - sparklesAnimation.value);

    switch (_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.BECOMING_VISIBLE:
        scorePosition = scoreInAnimationController.value * 100;
        scoreOpacoity = scoreInAnimationController.value;
        extraSize = scoreSizeAnimationController.value * 10;
        break;
      case ScoreWidgetStatus.BECOMING_INVISBLE:
      case ScoreWidgetStatus.VISIBLE:
        scorePosition = scoreOutPositionAnimation.value;
        scoreOpacoity = 1 - scoreOutAnimationController.value;
        break;
    }

    for (var i = 0; i < 5; i++) {
      var currentAngle = (firstAngle + ((2 * pi) / 5) * (i));
      var sparkleWiget = new Positioned(
        child: new Transform.rotate(
            angle: currentAngle - pi / 2,
            child: new Opacity(
              opacity: sparklesOpacity,
              child: new Image.asset("images/sparkles.png",
                  width: 14.0, height: 14.0),
            )),
        left: (sparkleRadius * cos(currentAngle)) + 20,
        top: (sparkleRadius * sin(currentAngle)) + 20,
      );
      stackChildren.add(sparkleWiget);
    }

    stackChildren.add(
      new Opacity(
        opacity: scoreOpacoity,
        child: new Container(
          height: 50.0 + extraSize,
          width: 50.0 + extraSize,
          decoration: new ShapeDecoration(
            shape: new CircleBorder(side: BorderSide.none),
            color: Colors.pink,
          ),
          child: new Center(
            child: new Text(
              "+" + _counter.toString(),
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
          ),
        ),
      ),
    );

    return new Positioned(
      child: new Stack(
        alignment: FractionalOffset.center,
        overflow: Overflow.visible,
        children: stackChildren,
      ),
      bottom: scorePosition,
    );
  }

  Widget getClapButton() {
    double extraSize = scoreSizeAnimationController.value * 10;
    return new GestureDetector(
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      child: new Container(
        height: 60.0 + extraSize,
        width: 60.0 + extraSize,
        padding: new EdgeInsets.all(10),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.pink, width: 1.0),
            borderRadius: new BorderRadius.circular(50.0),
            color: Colors.white,
            boxShadow: [new BoxShadow(color: Colors.pink, blurRadius: 8.0)]),
        child: new ImageIcon(new AssetImage("images/clap.png"),
            color: Colors.pink, size: 40.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   return new Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: new Stack(
        alignment: FractionalOffset.center,
        overflow: Overflow.visible,
        children: <Widget>[getScoreButton(), getClapButton()],
      ),
    );
  }
}
