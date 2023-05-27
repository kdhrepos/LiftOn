import 'package:flutter/material.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';

class PostMaker extends StatefulWidget {
  const PostMaker({super.key});

  @override
  State<PostMaker> createState() => _PostMakerState();
}

class _PostMakerState extends State<PostMaker> {
  TextEditingController postTitle = TextEditingController();
  TextEditingController postContent = TextEditingController();

  void postPost() async {
    await dio.post("$server/post-process", data: {
      "title": postTitle.text,
      "content": postContent.text,
      "author": currentUser.name,
      "userId": currentUser.id,
    }).then((response) {
      print(response);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: postTitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: postContent,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Content',
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {}, // is login successed or not
                    icon: const Icon(Icons.image),
                    color: Colors.blue,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: postPost, // is login successed or not
                    icon: const Icon(Icons.check),
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
