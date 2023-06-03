import 'package:flutter/material.dart';
import 'package:lifton/fetch/comment_fetch.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/models/comment.dart';
import 'package:lifton/models/post.dart';
import 'package:lifton/screens/community/comment.dart';
import 'package:lifton/screens/community/post_preview.dart';

class UserComments extends StatefulWidget {
  const UserComments({super.key});

  @override
  State<UserComments> createState() => _UserCommentsState();
}

class _UserCommentsState extends State<UserComments> {
  late Future<List<Map<CommentModel, PostModel>>> commentList;

  @override
  void initState() {
    super.initState();
    commentList = CommentFetch.getUserComments(
      currentUser.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(children: [
            FutureBuilder(
              future: commentList,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "${snapshot.data!.length.toString()} Comments",
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      for (Map<CommentModel, PostModel> data in snapshot.data!)
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors
                                      .blueGrey, // Set the border color here
                                  width: 0.1, // Set the border width
                                ),
                              ),
                              child: Column(
                                children: [
                                  PostPreview(post: data.values.first),
                                  const Divider(),
                                  Comment(comment: data.keys.first),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
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
