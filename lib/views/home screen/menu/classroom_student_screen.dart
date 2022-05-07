import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/views/home%20screen/widgets/classroom_tile.dart';
import 'package:enetcom_app/views/widgets/build_header_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassroomStudentScreen extends StatelessWidget {
  ClassroomStudentScreen({Key? key}) : super(key: key);

  final StudentController studentController = Get.put(StudentController());
  final ClasseController classeController = Get.put(ClasseController());

  @override
  Widget build(BuildContext context) {
    Student currentStudent;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Palette.scaffold,
        title: const Image(
            image: ExactAssetImage("assets/images/enetcom_logo.png"),
            //height: 60.0,
            width: 180.0,
            alignment: FractionalOffset.center),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Hi Helmy",
              //"Hi ${currentStudent.firstName}",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              "Welcome Back!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          buildHeaderBox(
            context,
            "Classroom space",
            "LIFE IS EASY!",
            "All the documents you need\nare here for you.",
            'assets/images/student1.png',
          ),
          buildClassroomTile(
            context,
            'assets/images/book.png',
            "Intelligence Artificielle",
          ),
          buildClassroomTile(
            context,
            'assets/images/book.png',
            "Traitement d'image",
          ),
          buildClassroomTile(
            context,
            'assets/images/book.png',
            "Statistiques et probabilite",
          ),
          buildClassroomTile(
            context,
            'assets/images/book.png',
            "Developpement web",
          ),
        ],
      ),
    );
  }
}
