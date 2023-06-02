import 'package:flutter/material.dart';
import 'package:lifton/models/user.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/global/util.dart';
import 'package:lifton/screens/home/main.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordState = true;
  bool isEmailCorrect = true;

  int isTrainer = 0; // normal : 0 , trainer : 1
  int gender = 1; // female : 0, male : 1
  final TextEditingController signUpName = TextEditingController();
  final TextEditingController signUpEmail = TextEditingController();
  final TextEditingController signUpPassword = TextEditingController();
  final TextEditingController signUpConfirm = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController bmi = TextEditingController();
  final TextEditingController muscleMass = TextEditingController();
  final TextEditingController fatMass = TextEditingController();

  String message = "Welcome";
  void postSignUp() async {
    if (signUpName.text == "" ||
        signUpEmail.text == "" ||
        signUpPassword.text == "" ||
        signUpConfirm.text == "") return;
    if (!isPasswordSame(signUpPassword.text, signUpConfirm.text)) {
      setState(() {
        passwordState = false;
      });
      return;
    } else {
      setState(() {
        passwordState = true;
      });
    }
    if (!checkPasswordLength(signUpPassword.text)) {
      showPasswordLenError(context);
      return;
    }
    if (!isValidEmail(signUpEmail.text)) {
      showEmailError(context);
      return;
    }
    await dio.post("$server/post-sign-up", data: {
      "name": signUpName.text,
      "email": signUpEmail.text,
      "password": signUpPassword.text,
      "weight": weight.text,
      "bmi": bmi.text,
      "fatMass": fatMass.text,
      "muscleMass": muscleMass.text,
      "isTrainer": isTrainer,
      "gender": gender,
    }).then((response) {
      final data = response.data;
      setState(() {
        message = data['message'];
      });
      if (data['success'] == true) {
        currentUser = UserModel.fromDB(data['userData']);
        isLoggedIn = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Main(
              selectedIdx: 0,
            ),
          ),
        );
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
            passwordState
                ? Text(
                    message,
                    style: const TextStyle(fontSize: 50, color: Colors.blue),
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
            const Divider(),
            TextFormField(
              controller: weight,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Weight',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: bmi,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'BMI',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: muscleMass,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Muscle Mass',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: fatMass,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Fat Mass',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
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
                            onPressed: () {
                              setState(() {
                                isTrainer = 0;
                              });
                            }, // is login successed or not
                            icon: const Icon(Icons.person),
                            color:
                                isTrainer == 0 ? Colors.blue : Colors.blueGrey,
                          ),
                        ),
                        Tooltip(
                          message: 'Trainer',
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isTrainer = 1;
                              });
                            }, // is login successed or not
                            icon: const Icon(Icons.fitness_center_sharp),
                            color:
                                isTrainer == 1 ? Colors.blue : Colors.blueGrey,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // add this line
                  children: [
                    const Tooltip(
                      message: "Select your gender",
                      child: Text(
                        "Gender",
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
                          message: "Male",
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                gender = 1;
                              });
                            }, // is login successed or not
                            icon: const Icon(Icons.male),
                            color: gender == 1 ? Colors.blue : Colors.blueGrey,
                          ),
                        ),
                        Tooltip(
                          message: 'Female',
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                gender = 0;
                              });
                            }, // is login successed or not
                            icon: const Icon(Icons.female),
                            color: gender == 0
                                ? Colors.pink[200]
                                : Colors.blueGrey,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            IconButton(
              onPressed: postSignUp, // is login successed or not
              icon: const Icon(Icons.check),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

void showEmailError(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Invalid Email'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showPasswordLenError(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Invalid Password'),
        content: const Text("Password Length should be longer than 5"),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
