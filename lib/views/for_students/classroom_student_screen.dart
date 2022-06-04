import 'package:enetcom_app/views/for_students/student_root_app.dart';
import 'package:enetcom_app/views/for_students/student_subject_tile.dart';
import 'package:enetcom_app/views/home%20screen/widgets/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/views/widgets/build_header_box.dart';

class ClassroomStudentScreen extends StatelessWidget {
  const ClassroomStudentScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    userController.getCurrentUserSubjects();
    Classe classe = userController.currentClasse;

    var children2 = Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.green,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Text(
                  "${classe.name} subjects",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(thickness: 2),
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
                    userController.currentUserSubjects[index];
                return StudentSubjectTile(
                  subject: subject,
                );
              },
              itemCount: userController.currentUserSubjects.length,
            );
          }
        }),

        EmptyContent(
          text:
              "Unavailable subject? please ask your teacher update their clasroom space.",
        ),

        const SizedBox(height: 70.0),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        "Hi ${userController.currentUser.value.firstName ?? ""}",
                        //"Hi ${currentTeacher.firstName}",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          buildHeaderBox(
            context,
            "Classroom space",
            "LIFE IS EASY!",
            "All the documents you need\nare here for you.",
            'assets/images/student1.png',
          ),
          children2,
          // userController.currentUserClasseSubjects.isEmpty
          //     ? children1
          //     : children2,
        ],
      ),
    );
  }
}
