import 'package:flutter/material.dart';
import 'package:medium_clap_animation/Widgets/bottom_navigaition_widget.dart';
import 'package:medium_clap_animation/page/post_detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'post_detail':(context) => PostDetailPage(),
      },
      home: BottomNavigationWidget()
    );
  }
}