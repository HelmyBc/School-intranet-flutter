import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/views/for_teachers/teacher_subjects_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClasseTile extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  Classe classe;

  ClasseTile({required this.classe});
  @override
  Widget build(BuildContext context) {
    // userController.onInit();
    // userController.currentClasseId.value = classe.id;
    // userController.currentClasse = classe;
    return GestureDetector(
      onTap: () {
        userController.currentClasseId.value = classe.id;
        userController.currentClasse = classe;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeacherSubjectsScreen(classe: classe)));
      },
      child: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.93,
          height: 80,
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromRGBO(255, 162, 87, 0.5),
                Color.fromRGBO(247, 122, 44, 0.5),
              ],
            ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        const Positioned(
          left: 0,
          top: 5,
          child: Image(
            height: 70,
            image: AssetImage('assets/images/class.png'),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(110, 30, 0, 0),
          height: 80,
          width: 250,
          child: Text(
            classe.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Positioned(
          right: -5,
          bottom: 5,
          child: MaterialButton(
            shape: const CircleBorder(),
            color: Colors.blue.withOpacity(0.4),
            padding: const EdgeInsets.all(8.0),
            onPressed: () {},
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 40.0,
            ),
          ),
        ),
      ]),
    );
  }
}
