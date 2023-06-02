import 'package:flutter/material.dart';
import 'package:lifton/screens/settings/widget/change_password.dart';
import 'package:lifton/screens/settings/widget/leave.dart';
import 'package:lifton/screens/settings/widget/profile.dart';
import 'package:lifton/screens/settings/widget/user_comments.dart';
import 'package:lifton/screens/settings/widget/user_posts.dart';

class Setting extends StatelessWidget {
  const Setting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Profile(),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Dialog(
                                child: ChangePassword(),
                              );
                            },
                          );
                        },
                        icon: const Text(
                          "Change Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        color: Colors.white,
                        iconSize: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Dialog(
                                child: UserPosts(),
                              );
                            },
                          );
                        },
                        icon: const Text(
                          "My Posts",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        color: Colors.white,
                        iconSize: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Dialog(
                                child: UserComments(),
                              );
                            },
                          );
                        },
                        icon: const Text(
                          "My Comments",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        color: Colors.white,
                        iconSize: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: IconButton(
                        splashRadius: 1,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Dialog(
                                child: LeaveMembership(),
                              );
                            },
                          );
                        },
                        icon: const Text(
                          "Leave LiftOn",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        color: Colors.white,
                        iconSize: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
