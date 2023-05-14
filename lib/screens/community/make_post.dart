import 'package:flutter/material.dart';
import 'package:lifton/screens/nav_bar.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class PostMaker extends StatefulWidget {
  const PostMaker({super.key});

  @override
  State<PostMaker> createState() => _PostMakerState();
}

class _PostMakerState extends State<PostMaker> {
  TextEditingController postTitle = TextEditingController();
  TextEditingController postContent = TextEditingController();

  void sendToServer() async {
    // await dio.post("http://localhost:8080/flutter",
    //     queryParameters: {"hello": "hello"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write Page'),
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
                    onPressed: sendToServer, // is login successed or not
                    icon: const Icon(Icons.check),
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
