import 'package:flutter/material.dart';
import 'package:medium_clap_animation/post.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  final namedPush = true;
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

    var post = widget.post;
    if(widget.namedPush){
      post = ModalRoute.of(context).settings.arguments as Post;
      print(post);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(post.title),
            Text(post.body),
          ]
        ),
      ),
    );
  }
}