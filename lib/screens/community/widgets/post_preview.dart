import 'package:flutter/material.dart';
import 'package:lifton/models/post.dart';
import 'package:lifton/screens/community/post.dart';
import 'package:intl/intl.dart';

class PostPreview extends StatelessWidget {
  const PostPreview({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Post(post: post),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Text(
              post.title.length > 10
                  ? " ${post.title.substring(0, 10)}..."
                  : " ${post.title}",
              style: const TextStyle(
                color: Colors.blueGrey,
              ),
            ),
          ),
          const Spacer(),
          Text(
            post.author,
            style: const TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            DateFormat('yyyy-MM-dd HH:mm').format(
              DateTime.parse(post.createdAt),
            ),
            style: const TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
