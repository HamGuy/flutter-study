import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final String title;
  SettingsPage({Key key, this.title}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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