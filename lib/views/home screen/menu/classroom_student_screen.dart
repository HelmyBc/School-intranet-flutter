import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/shared_pref.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/services/http_user_service.dart';
import 'package:enetcom_app/views/home%20screen/widgets/classroom_tile.dart';
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
  //SharedPref sharedPref = SharedPref();

  User currentUser = User(email: "", password: "");
  //SharedPref sharedPref = SharedPref();
  // User userSave = User(email: "", password: "");
  // User userLoad = User(email: "", password: "");

  // loadSharedPrefs() async {
  //   try {
  //     User user = User.fromJson(await sharedPref.read("user"));
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Loaded!"),
  //         duration: Duration(milliseconds: 500),
  //       ),
  //     );
  //     setState(() {
  //       userLoad = user;
  //     });
  //   } catch (Excepetion) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text("Nothing found!"),
  //         duration: Duration(milliseconds: 500)));
  //   }
  // }
  @override
  void initState() {
    super.initState();
    userController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    //User currentUser = userController.currentUser.value;
    //User cu = HttpUserService.getUser(userController.currentUserId.value);
    //User currentUser = sharedPref.read("user");
    print(currentUser.firstName);
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
