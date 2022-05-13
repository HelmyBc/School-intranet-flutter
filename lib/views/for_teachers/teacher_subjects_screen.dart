import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/views/for_teachers/add_teacher_subject_screen.dart';
import 'package:enetcom_app/views/for_teachers/classroom_teacher_screen.dart';
import 'package:enetcom_app/views/home%20screen/widgets/subject_tile.dart';
import 'package:enetcom_app/views/widgets/build_header_box.dart';

class TeacherSubjectsScreen extends StatelessWidget {
  Classe classe;
  TeacherSubjectsScreen({
    required this.classe,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    userController.getCurrentUser();
    userController.getUserClasseSubjects();
    Classe classe = userController.currentClasse;
    //User currentUser = userController.currentUser.value;
    //userController.onInit();
    // print(userController.currentClasse.name);
    // print(userController.currentUserClasseSubjects);
    // var children1 = Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
    //       child: Column(
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               const Expanded(
    //                 child: Text(
    //                   "No subjects detected",
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 20.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (_) => AddTeacherSubjectsScreen(
    //                                 classe: widget.classe,
    //                               )));
    //                 },
    //                 child: const Text(
    //                   "Add",
    //                   style: TextStyle(
    //                     color: Colors.blue,
    //                     fontSize: 18.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Center(
    //             child: Padding(
    //               padding: const EdgeInsets.all(58.0),
    //               child: Text(
    //                 "Please click the add button in blue to select the subjects you teach.",
    //                 style: TextStyle(
    //                   color: Colors.grey[700],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     const SizedBox(height: 70.0),
    //   ],
    // );
    var children2 = Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Subject(s) I teach in this class",
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
                          builder: (_) =>
                              AddTeacherSubjectsScreen(classe: classe)));
                },
                child: const Text(
                  "Add",
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
                    userController.currentUserClasseSubjects[index];
                return SubjectTile(
                  subject: subject,
                );
              },
              itemCount: userController.currentUserClasseSubjects.length,
            );
          }
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 58.0, vertical: 10.0),
          child: Center(
            child: Text(
              "Please click the add button in blue to select the subjects you teach.",
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
        const SizedBox(height: 70.0),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ClassroomTeacherScreen()));
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
          children2,
          // userController.currentUserClasseSubjects.isEmpty
          //     ? children1
          //     : children2,
        ],
      ),
    );
  }
}
