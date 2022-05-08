import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/services/http_student_service.dart';
import 'package:enetcom_app/services/http_teacher_service.dart';
import 'package:enetcom_app/services/http_user_service.dart';
import 'package:enetcom_app/views/welcome_student_screen.dart';
import 'package:enetcom_app/views/welcome_teacher_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());
  User user = User(email: "", password: "");

  save() async {
    User cu = await HttpUserService.login(user);
    if (cu != null && cu.id != 0) {
      print(cu);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      userController.currentUser.clear();
      int? cuid = cu.id;
      if (cu.userType == "Student") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeStudentScreen(),
          ),
        );

        Student currentUser = HttpStudentService.getStudent(cuid!) as Student;
        userController.currentUser.add(currentUser);
        userController.currentUserType = cu.userType as RxString;
        prefs.setBool("isStudent", true);
        prefs.setBool("isTeacher", false);
      } else if (cu.userType == "Teacher") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeTeacherScreen(),
          ),
        );
        Teacher currentUser = HttpTeacherService.getTeacher(cuid!) as Teacher;
        userController.currentUser.add(currentUser);
        userController.currentUserType = cu.userType as RxString;
        prefs.setBool("isTeacher", true);
        prefs.setBool("isStudent", false);
      } else {
        const snackBar = SnackBar(
          content: Text("Please verify your credentials"),
          backgroundColor: Color(0xFFF54856),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      const snackBar = SnackBar(
        content: Text("Please verify your credentials"),
        backgroundColor: Color(0xFFF54856),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("outside");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFEDC9A6),
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 78.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "LOGIN",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Image(
                    image: const ExactAssetImage("assets/images/login.png"),
                    height: size.height * 0.5,
                    alignment: FractionalOffset.center,
                  ),

                  // EMAIL INPUT
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Palette.kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: TextEditingController(text: user.email),
                      onChanged: (val) {
                        user.email = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is empty';
                        }
                        return null;
                      },
                      cursorColor: const Color(0xFF2653E0),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xFF2653E0),
                        ),
                        hintText: "Your Email",
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  //PASSWORD INPUT
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Palette.kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: TextEditingController(text: user.password),
                      onChanged: (val) {
                        user.password = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is empty';
                        }
                        return null;
                      },
                      cursorColor: const Color(0xFF2653E0),
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: Color(0xFF2653E0),
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Color(0xFF2653E0),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: ElevatedButton(
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            save();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF2653E0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  // RoundedButton(
                  //     text: "LOGIN",
                  //     press: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) => NavScreen()));
                  //     }),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 38.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don’t have an Account ? ",
                          style: TextStyle(
                            color: Color(0xFF2653E0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => {},
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const SignUpScreen())),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFF2653E0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
