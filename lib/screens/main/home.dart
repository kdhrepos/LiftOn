import 'package:flutter/material.dart';
import 'package:lifton/global/fetch.dart';
import 'package:lifton/global/state.dart';
import 'package:lifton/models/plan.dart';
import 'package:lifton/models/post.dart';
import 'package:lifton/screens/community/post_preview.dart';
import 'package:lifton/screens/exercise/goal.dart';
import 'package:lifton/screens/exercise/plan.dart';
import 'package:lifton/screens/main/main.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<PostModel>> postList;
  late Future<List<PlanModel>> planList;

  @override
  void initState() {
    super.initState();
    postList = Fetcher.getAllPosts();
    planList = Fetcher.getPlans(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            children: [
              Column(
                children: [
                  const Text(
                    "Latest Posts",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: postList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<PostModel> posts = snapshot.data!;
                        int maxPosts = 5; // Maximum number of posts to display

                        if (posts.length <= maxPosts) {
                          return Column(
                            children: [
                              for (PostModel post in posts)
                                PostPreview(
                                  post: post,
                                ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              for (int i = 0; i < maxPosts; i++)
                                PostPreview(
                                  post: posts[i],
                                ),
                            ],
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    splashRadius: 1,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Main(
                            selectedIdx: 1,
                          ),
                        ),
                      );
                    },
                    icon: const Text(
                      "Let's Exercise!",
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
              const SizedBox(height: 20),
              const Text(
                "Plan",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                ),
              ),
              !isLoggedIn
                  ? const Text("")
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Main(
                              selectedIdx: 1,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 0.3,
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: FutureBuilder(
                            future: planList,
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (PlanModel plan in snapshot.data!)
                                        Hero(
                                          tag: "",
                                          child: Column(
                                            children: [
                                              Plan(
                                                plan: plan,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Main(
                        selectedIdx: 1,
                      ),
                    ),
                  );
                },
                child: const Goal(),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: IconButton(
                    splashRadius: 1,
                    onPressed: () async {
                      await launchUrlString("https://music.youtube.com/");
                    },
                    icon: const Icon(Icons.music_video),
                    color: Colors.white,
                    iconSize: 50,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
