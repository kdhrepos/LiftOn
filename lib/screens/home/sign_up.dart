import 'package:flutter/material.dart';
import 'package:lifton/models/user.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPasswordSame = true;

  final TextEditingController signUpName = TextEditingController();
  final TextEditingController signUpEmail = TextEditingController();
  final TextEditingController signUpPassword = TextEditingController();
  final TextEditingController signUpConfirm = TextEditingController();

  void postSignUp() async {
    if (signUpPassword.text != signUpConfirm.text) {
      setState(() {
        isPasswordSame = false;
      });
      return;
    }
    setState(() {
      isPasswordSame = true;
    });

    await dio.post("$server/post-sign-up", data: {
      "name": signUpName.text,
      "email": signUpEmail.text,
      "password": signUpPassword.text
    }).then((response) {
      final data = response.data;

      if (data['success'] == true) {
        currentUser = UserModel.fromDB(data['userData']);
        isLoggedIn = true;
        // currentUser.showInfo();
        // Navigator push
      }
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
              isPasswordSame
                  ? const Text(
                      "Welcome",
                      style: TextStyle(fontSize: 50, color: Colors.blue),
                    )
                  : const Text(
                      "Wrong Password",
                      style: TextStyle(fontSize: 50, color: Colors.red),
                    ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: signUpName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: signUpEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: signUpPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: signUpConfirm,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // add this line
                children: [
                  const Tooltip(
                    message: "Normal User or Trainer",
                    child: Text(
                      "Type",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Tooltip(
                        message: "Normal",
                        child: IconButton(
                          onPressed: () {}, // is login successed or not
                          icon: const Icon(Icons.person),
                          color: Colors.blue,
                        ),
                      ),
                      Tooltip(
                        message: 'Trainer',
                        child: IconButton(
                          onPressed: () {}, // is login successed or not
                          icon: const Icon(Icons.fitness_center_sharp),
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              IconButton(
                onPressed: postSignUp, // is login successed or not
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
