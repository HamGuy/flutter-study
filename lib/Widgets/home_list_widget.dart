import 'package:flutter/material.dart';

import '../network_helper.dart';
import '../post.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  List<Post> _posts;
  int _selectedIndex = -1;

  @override
  void initState() {
    _posts = [];
    super.initState();
    requestData();
  }


  void requestData() {
    NetworkHelper().request<Post>(SomeAPI(), (list, error) {
      if (error == null) {
        setState(() {
          _posts = list.cast<Post>();
        });
      } else {

      }
    });
  }

  void handleTap(index) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {

    int length = 0;
    if(_posts != null) {
      length = _posts.length;
    }

    return ListView.builder(
      padding: EdgeInsets.all(6),
      itemCount: length,
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTapDown: (tap){
            handleTap(index);
          },
          child: Container(
            color: _selectedIndex == index ? Colors.red : Colors.white,
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_posts[index].title,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text(_posts[index].body, style: TextStyle(fontSize: 12, color: Colors.red)),
              Divider(color: Color(0xffffccff), height: 1.0, indent: 15, endIndent: 0),
            ],
          ),
        ));
      },
    );
  }
}
