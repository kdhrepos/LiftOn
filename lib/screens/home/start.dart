import 'package:flutter/material.dart';
import 'package:lifton/screens/home/login.dart';
import 'package:lifton/screens/home/sign_up.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.logo_dev,
            size: 300,
            color: Colors.blue,
          ), // Must Be Modified To My Custom
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                icon: const Icon(Icons.login),
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
                icon: const Icon(Icons.account_box),
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.no_accounts),
                color: Colors.blue,
              ),
            ],
          ),
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
