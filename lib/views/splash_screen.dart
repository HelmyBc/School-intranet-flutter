import 'dart:async';

import 'package:enetcom_app/controllers/feature_controller.dart';
import 'package:enetcom_app/views/login_screen.dart';
import 'package:enetcom_app/views/root_app_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  FeatureController featureController = Get.put(FeatureController());
  @override
  void initState() {
    super.initState();
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
    print(status);
    if (status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RootAppAnimated(),
        ),
      );
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
