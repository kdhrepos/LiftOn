import 'package:flutter/material.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    super.key,
  });

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isPasswordSame = true;
  bool isSuccessful = true;

  final TextEditingController changePassword = TextEditingController();
  final TextEditingController changeConfirm = TextEditingController();

  void postChange() async {
    if (changePassword.text != changeConfirm.text) {
      setState(() {
        isPasswordSame = false;
      });
      return;
    }
    setState(() {
      isPasswordSame = true;
    });

    await dio.post("$server/put-password", data: {
      "name": currentUser.name,
      "userId": currentUser.id,
      "email": currentUser.email,
      "password": changePassword.text,
    }).then((response) {
      final data = response.data;
      if (data['success'] == true) {
        Navigator.pop(context);
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
                  ? const Text(
                      "Change Password",
                      style: TextStyle(fontSize: 25, color: Colors.blue),
                    )
                  : const Text(
                      "Check Your Password",
                      style: TextStyle(fontSize: 25, color: Colors.red),
                    ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: changePassword,
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
                controller: changeConfirm,
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
                onPressed: postChange,
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
