import 'package:flutter/material.dart';
import 'package:lifton/models/user.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/screens/home/main.dart';

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

  bool isLoginFailed = false;
  void postLogin() async {
    await dio.post("$server/post-login", data: {
      "email": loginEmail.text,
      "password": loginPassword.text
    }).then((response) {
      final data = response.data;

      if (data['success'] == true) {
        print("Login Success");
        currentUser = UserModel.fromDB(data['userData']);
        currentUser.showInfo();
        isLoggedIn = true;
        isLoginFailed = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Main(
              selectedIdx: 0,
            ),
          ),
        );
      } else {
        setState(() {
          isLoginFailed = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          children: [
            !isLoginFailed
                ? const Text("Login")
                : const Text(
                    "Login Failed",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: postLogin, // is login successed or not
                  icon: const Icon(Icons.check),
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
