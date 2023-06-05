import 'package:flutter/material.dart';
import 'package:lifton/global/fetch.dart';
import 'package:lifton/models/post.dart';
import 'package:lifton/screens/community/post_preview.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({super.key});

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  late Future<List<PostModel>> postList;

  @override
  void initState() {
    super.initState();
    postList = Fetcher.getUserPosts();
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
                      Text(
                        "${snapshot.data!.length.toString()} Posts",
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
    );
  }
}
