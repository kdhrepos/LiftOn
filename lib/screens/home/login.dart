import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifton/util.dart';

final dio = Dio();

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  void postLogin() async {
    await dio.post("$server/post-login", data: {
      "email": loginEmail.text,
      "password": loginPassword.text
    }).then((response) {
      final data = response.data;
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LiftOn"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            children: [
              TextFormField(
                controller: loginEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: loginPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              IconButton(
                onPressed: postLogin, // is login successed or not
                icon: const Icon(Icons.check),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
