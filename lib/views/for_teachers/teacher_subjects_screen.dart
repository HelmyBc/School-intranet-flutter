import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/views/home%20screen/widgets/subject_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/views/for_teachers/add_teacher_subjects_screen.dart';
import 'package:enetcom_app/views/home%20screen/widgets/classe_tile.dart';
import 'package:enetcom_app/views/widgets/build_header_box.dart';

class TeacherSubjectsScreen extends StatefulWidget {
  int classeId;
  TeacherSubjectsScreen({
    Key? key,
    required this.classeId,
  }) : super(key: key);

  @override
  State<TeacherSubjectsScreen> createState() => _TeacherSubjectsScreenState();
}

class _TeacherSubjectsScreenState extends State<TeacherSubjectsScreen> {
  final UserController userController = Get.put(UserController());
  final ClasseController classeController = Get.put(ClasseController());

  User currentUser = User(email: "", password: "");

  @override
  void initState() {
    super.initState();
    userController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = userController.currentUser.value;
    print(userController.currentUserClasses);

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
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => Text(
                "Hi ${userController.currentUser.value.firstName ?? ""}",
                //"Hi ${currentTeacher.firstName}",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddTeacherSubjectsScreen()));
                  },
                  child: const Text(
                    "Edit subjects",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          buildHeaderBox(
            context,
            "Classroom space",
            "LIFE IS EASY!",
            "All the documents you need\nare here for you.",
            'assets/images/student1.png',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Expanded(
                  child:  Text(
                    "I teach this/these subject(s) in this class",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddTeacherSubjectsScreen()));
                  },
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (userController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final Subject subject =
                      userController.currentUserClasseSubject[index];
                  return SubjectTile(
                    title: subject.name,
                  );
                },
                itemCount: userController.currentUserClasseSubject.length,
              );
            }
          }),
          const SizedBox(height: 70.0),
        ],
      ),
    );
  }
}
