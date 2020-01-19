import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medium_clap_animation/page/common_page_widget.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  List<Widget> list = List();
  static const _bottomBarColor = Colors.blue;

  @override
  void initState(){
    list
        ..add(CommonPage(title: 'Home',))
        ..add(CommonPage(title: 'Category',))
        ..add(CommonPage(title: 'Message',))
        ..add(CommonPage(title: 'Setting',));

    super.initState();
  }

  TextStyle _bottomTextStyle() {
    return const TextStyle(color: _bottomBarColor);
  }

  BottomNavigationBarItem _bottomNavgationitem(String title, Icon icon) {
    return BottomNavigationBarItem(
        icon: icon, title: Text(title, style: _bottomTextStyle()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _bottomNavgationitem(
              'Home', Icon(Icons.home, color: _bottomBarColor)),
          _bottomNavgationitem(
              'Category', Icon(Icons.category, color: _bottomBarColor)),
          _bottomNavgationitem(
              'Message', Icon(Icons.message, color: _bottomBarColor)),
          _bottomNavgationitem(
              'Settting', Icon(Icons.settings, color: _bottomBarColor)),
        ],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState((){
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
