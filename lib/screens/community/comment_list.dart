import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  const CommentList({super.key});

  @override
  State<CommentList> createState() => CommentListState();
}

class CommentListState extends State<CommentList> {
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
