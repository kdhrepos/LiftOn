import 'package:flutter/material.dart';
import 'package:lifton/screens/auth/login.dart';
import 'package:lifton/screens/auth/sign_up.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLogin = true;
                    });
                  },
                  icon: const Icon(Icons.login),
                  color: Colors.blue,
                  tooltip: "Login",
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                  },
                  icon: const Icon(Icons.account_box),
                  color: Colors.blue,
                  tooltip: "SignUp",
                ),
              ],
            ),
            isLogin ? const Login() : const SignUp(),
          ],
        ),
      ),
    );
  }
}
