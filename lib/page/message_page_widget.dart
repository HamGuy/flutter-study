import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  final String title;
  MessagePage({Key key, this.title}) : super(key: key);
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(),
    );
  }
}