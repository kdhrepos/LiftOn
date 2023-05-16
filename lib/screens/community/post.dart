import 'package:flutter/material.dart';
import 'package:lifton/models/post.dart';

class Post extends StatelessWidget {
  final PostModel post;

  const Post({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [Text(post.title), Text(post.content)],
        ));
  }
}
