import 'dart:async';

import 'package:enetcom_app/controllers/feature_controller.dart';
import 'package:enetcom_app/controllers/post_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/views/login_screen.dart';
import 'package:enetcom_app/views/for_students/student_root_app.dart';
import 'package:enetcom_app/views/for_teachers/teacher_root_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  UserController userController = Get.put(UserController());
  FeatureController featureController = Get.put(FeatureController());
  PostController postController = Get.put(PostController());
  @override
  void initState() {
    super.initState();
    userController.getCurrentUser();
    featureController.fetchFeatures();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Image.asset(
            "assets/images/enetcom_logo.png",
          ),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(seconds: 4), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    var isTeacher = prefs.getBool('isTeacher') ?? false;
    var isStudent = prefs.getBool('isStudent') ?? false;

    if (status) {
      if (isTeacher) {
        ///// TEACHER ROUTE
        userController.currentUserTypeInt.value = 1;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TeacherRootApp(),
          ),
        );
      } else if (isStudent) {
        ////// Student ROUTE
        userController.currentUserTypeInt.value = 0;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentRootApp(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }
}
