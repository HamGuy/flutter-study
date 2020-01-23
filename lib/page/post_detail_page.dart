import 'package:flutter/material.dart';
import 'package:medium_clap_animation/post.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  PostDetailPage({Key key, this.post}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.post.title),
            Text(widget.post.body),
          ]
        ),
      ),
    );
  }
}