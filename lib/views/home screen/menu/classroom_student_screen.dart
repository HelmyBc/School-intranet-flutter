import 'package:enetcom_app/config/palette.dart';
import 'package:flutter/material.dart';

class ClassroomStudentScreen extends StatelessWidget {
  const ClassroomStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        backgroundColor: Palette.scaffold,
        // ignore: prefer_const_constructors
        title: Image(
            image: const ExactAssetImage("assets/images/enetcom_logo.png"),
            //height: 60.0,
            width: 180.0,
            alignment: FractionalOffset.center),
        centerTitle: false,
      ),
      body: Center(
        child: Image.network(
          "http://192.168.56.1:9191/api/download/3",
        ),
      ),
    );
  }
}
