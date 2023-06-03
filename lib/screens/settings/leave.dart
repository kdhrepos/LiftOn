import 'package:flutter/material.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';

class LeaveMembership extends StatefulWidget {
  const LeaveMembership({super.key});

  @override
  State<LeaveMembership> createState() => _LeaveMembershipState();
}

class _LeaveMembershipState extends State<LeaveMembership> {
  bool isPasswordSame = true;
  bool isSuccessful = true;
  String message = "Bye Bye ${currentUser.name}";

  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();
  final TextEditingController email = TextEditingController();

  void postLeave() async {
    if (password.text != confirm.text) {
      setState(() {
        isPasswordSame = false;
      });
      return;
    }
    setState(() {
      isPasswordSame = true;
    });

    await dio.post("$server/leave", data: {
      "name": currentUser.name,
      "userId": currentUser.id,
      "email": email.text,
      "password": password.text,
    }).then((response) {
      final data = response.data;

      if (data['success'] == true) {
        isLoggedIn = false;
        isSuccessful = true;
        Navigator.pop(context);
      } else {
        setState(() {
          isSuccessful = false;
          message = data['message'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              isPasswordSame
                  ? Text(
                      message,
                      style: TextStyle(
                        fontSize: 25,
                        color: isSuccessful ? Colors.blue : Colors.red,
                      ),
                    )
                  : const Text(
                      "Check Your Password",
                      style: TextStyle(fontSize: 25, color: Colors.red),
                    ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Change Password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirm,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                onPressed: postLeave,
                icon: const Icon(Icons.sign_language),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
