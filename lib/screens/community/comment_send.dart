import 'package:flutter/material.dart';

class CommentSend extends StatefulWidget {
  const CommentSend({super.key});

  @override
  State<CommentSend> createState() => CommentSendState();
}

class CommentSendState extends State<CommentSend> {
  // void postComment() async {
  //   if (isLoggedIn) {
  //     if (commentController.text.isEmpty) return;

  //     await dio.post(
  //       "$server/post-comment-process/",
  //       data: {
  //         "userId": currentUser.id,
  //         "comment": commentController.text,
  //       },
  //       queryParameters: {
  //         "postId": widget.post.id,
  //       },
  //     ).then((response) {
  //       print("Comment sended");
  //       commentController.text = "";
  //     });
  //   } else {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const Login(),
  //       ),
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();

    return BottomAppBar(
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
                      () {};
                    },
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
