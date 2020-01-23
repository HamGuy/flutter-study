import 'dart:math';

import 'package:flutter/material.dart';

extension on Color {
 static Color random({bool ranmdomAlpha = false}) {
    var random = new Random();
    var alpha = 1.0;
    if(ranmdomAlpha){
      alpha = random.nextDouble();
    }
    return Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), alpha);
  }
}

class CommonPage extends StatefulWidget {
  final String title;
  final body;
  CommonPage({Key key, this.title, this.body}) : super(key: key);
  @override
  _CommonPageState createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  @override
  Widget build(BuildContext context) {
    var defaultBody = widget.body;
    if(defaultBody == null) {
      // defaultBody = Text(widget.title, style: TextStyle(color: Color.random()),);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: defaultBody,
      ),
    );
  }
}