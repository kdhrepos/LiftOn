import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'dart:io';

import 'package:lifton/screens/main/main.dart';

class MakePost extends StatefulWidget {
  const MakePost({super.key});

  @override
  State<MakePost> createState() => _PostMakerState();
}

class _PostMakerState extends State<MakePost> {
  TextEditingController postTitle = TextEditingController();
  TextEditingController postContent = TextEditingController();
  FilePickerResult? filePick;
  File? selectedFile;

  void postPost() async {
    if (postTitle.text == "" || postContent.text == "") return;

    FormData formData = FormData.fromMap({
      "title": postTitle.text,
      "content": postContent.text,
      "author": currentUser.name,
      "userId": currentUser.id,
      "file": filePick != null
          ? await MultipartFile.fromFile(filePick!.files.single.path.toString())
          : null,
    });

    await dio
        .post(
      "$server/post-process",
      data: formData,
    )
        .then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Main(
            selectedIdx: 2,
          ),
        ),
      );
    });
  }

  void setFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        filePick = result;
        selectedFile =
            File(filePick!.files.single.path ?? ''); // Update selectedFile
        print(filePick);
      });
    }
  }

  void deleteFile() {
    setState(() {
      selectedFile = null;
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
              if (selectedFile != null)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          filePick!.files.single.path ?? '',
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                        TextButton(
                          onPressed: deleteFile,
                          child: const Text(
                            "X",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    Image.file(selectedFile!),
                  ],
                ),
              Row(
                children: [
                  IconButton(
                    onPressed: setFile,
                    icon: const Icon(Icons.image),
                    color: Colors.blue,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: postPost,
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
