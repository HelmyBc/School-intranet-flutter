import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/views/for_teachers/add_teacher_subject_screen.dart';
import 'package:enetcom_app/views/home%20screen/widgets/classe_tile.dart';
import 'package:enetcom_app/views/widgets/build_header_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassroomTeacherScreen extends StatefulWidget {
  ClassroomTeacherScreen({Key? key}) : super(key: key);

  @override
  State<ClassroomTeacherScreen> createState() => _ClassroomTeacherScreenState();
}

class _ClassroomTeacherScreenState extends State<ClassroomTeacherScreen> {
  final UserController userController = Get.put(UserController());
  final ClasseController classeController = Get.put(ClasseController());
  //final SubjectController subjectController = Get.put(SubjectController());

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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              //   child: TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (_) => AddTeacherSubjectsScreen()));
              //     },
              //     child: const Text(
              //       "Edit subjects",
              //       style: TextStyle(
              //         color: Colors.blue,
              //         fontSize: 18.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
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
              children:  [
               const Text(
                  "My classes",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () { },
                  child:const Text(
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
                  final Classe classe =
                      userController.currentUserClasses[index];
                  return ClasseTile(
                    classe: classe,
                  );
                },
                itemCount: userController.currentUserClasses.length,
              );
            }
          }),
          const SizedBox(height: 70.0),
          // ClassroomTile(
          //   title: "Intelligence Artificielle",
          // ),
          // ClassroomTile(
          //   title: "Traitement d'image",
          // ),
          // ClassroomTile(
          //   title: "Statistiques et probabilite",
          // ),
          // ClassroomTile(
          //   title: "Developpement web",
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (_) => AddTeacherSubjectsScreen()));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
