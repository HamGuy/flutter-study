import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.body,
    );
  }
}