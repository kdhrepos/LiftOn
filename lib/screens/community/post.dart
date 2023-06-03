import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/models/comment.dart';
import 'package:lifton/models/post.dart';
import 'package:lifton/fetch/comment_fetch.dart';
import 'package:lifton/screens/home/login.dart';
import 'package:lifton/screens/community/comment.dart';
import 'package:lifton/screens/home/main.dart';

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
    print(widget.post.filePath);
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

  void deletePost() async {
    final response = await dio.post("$server/delete-post", data: {
      "id": widget.post.id,
      "userId": currentUser.id,
    });
    print(response.data['message']);

    if (response.data['success'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Main(
            selectedIdx: 2,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              response.data["message"],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
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
                      "${widget.post.author} ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(widget.post.createdAt))}",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.blueGrey),
                    ),
                  ],
                ),
                const Divider(),
                widget.post.filePath == null ||
                        widget.post.filePath == "undefined"
                    ? const Text("")
                    : Image.network(
                        '$server/get-image/?filePath=${widget.post.filePath}',
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Text(
                            "File Not Found",
                            style: TextStyle(
                              fontSize: 50,
                              backgroundColor: Colors.red,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
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
      floatingActionButton: isLoggedIn
          ? FloatingActionButton(
              heroTag: 'deleteButton',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Delete Post",
                      ),
                      content: const Text("Sure?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            deletePost();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: "delete",
              child: const Icon(Icons.delete),
            )
          : null,
    );
  }
}
