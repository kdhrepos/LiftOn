import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/models/comment.dart';
import 'package:lifton/models/post.dart';
import 'package:lifton/screens/community/comment_fetch.dart';
import 'package:lifton/screens/home/login.dart';
import 'package:lifton/widgets/community/comment.dart';

class Post extends StatefulWidget {
  final PostModel post;

  const Post({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  late Future<List<CommentModel>> commentList;

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    commentList = CommentFetch.getAllComments(widget.post.id);
  }

  void postComment() async {
    if (isLoggedIn) {
      if (commentController.text.isEmpty) return;

      await dio.post(
        "$server/post-comment-process/",
        data: {
          "userId": currentUser.id,
          "comment": commentController.text,
          "postId": widget.post.id,
        },
      ).then((_) {
        commentController.clear();

        print("Comment sent");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Post(post: widget.post),
          ),
        );
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.post.author),
      ),
      body: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.post.author} ${DateFormat('yyyy-MM-dd HH:mm').format(
                        DateTime.parse(widget.post.createdAt),
                      )}",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.blueGrey),
                    ),
                  ],
                ),
                const Divider(),
                Text(
                  widget.post.content,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                FutureBuilder(
                  future: commentList,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (CommentModel comment in snapshot.data!)
                            Comment(
                              comment: comment,
                            ),
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    child: TextFormField(
                      textInputAction: TextInputAction.go,
                      controller: commentController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Comment',
                      ),
                      onFieldSubmitted: (_) {
                        postComment();
                      },
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: postComment,
                icon: const Icon(Icons.send),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.delete),
      ),
    );
  }
}
