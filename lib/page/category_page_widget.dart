import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String title;
  CategoryPage({Key key, this.title}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
        child: Text(widget.title),
      ),
    );
  }
}