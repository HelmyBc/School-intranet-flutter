import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/services/http_classe_service.dart';
import 'package:enetcom_app/services/http_user_service.dart';
import 'package:enetcom_app/views/home%20screen/widgets/subject_tile.dart';
import 'package:enetcom_app/views/widgets/build_header_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassroomStudentScreen extends StatefulWidget {
  ClassroomStudentScreen({Key? key}) : super(key: key);

  @override
  State<ClassroomStudentScreen> createState() => _ClassroomStudentScreenState();
}

class _ClassroomStudentScreenState extends State<ClassroomStudentScreen> {
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
    Classe currentUserClasse = userController.currentUserClasse.value;

    print(currentUser.firstName);
    print(userController.currentUserSubjects.value.toString());
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
                //"Hi ${currentStudent.firstName}",
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
          Obx(() {
            if (userController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final Subject subject =
                      userController.currentUserSubjects.value[index];
                  return SubjectTile(
                    subject: subject,
                  );
                },
                itemCount: userController.currentUserSubjects.value.length,
              );
            }
          }),
        ],
      ),
    );
  }
}
