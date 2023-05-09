import 'package:flutter/material.dart';
import 'package:lifton/screens/nav_bar.dart';

class PostMaker extends StatelessWidget {
  const PostMaker({super.key});

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
                    onPressed: () {}, // is login successed or not
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
