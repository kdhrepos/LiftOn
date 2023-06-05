import 'package:flutter/material.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/models/post.dart';
import 'package:lifton/global/fetch.dart';

import 'package:lifton/screens/community/make_post.dart';
import 'package:lifton/screens/auth/start.dart';
import 'package:lifton/screens/community/post_preview.dart';

class Posts extends StatefulWidget {
  const Posts({
    super.key,
  });

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  late Future<List<PostModel>> postList;

  @override
  void initState() {
    super.initState();
    postList = Fetcher.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(children: [
            FutureBuilder(
              future: postList,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (PostModel post in snapshot.data!)
                        PostPreview(
                          post: post,
                        ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isLoggedIn
              ? Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MakePost()),
                )
              : showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: StartScreen(),
                    );
                  },
                );
        },
        tooltip: "Write Post",
        child: const Icon(Icons.add),
      ),
    );
  }
}
