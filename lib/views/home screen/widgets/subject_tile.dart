import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/views/for_teachers/subject_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:get/get.dart';

class SubjectTile extends StatelessWidget {
  UserController userController = Get.put(UserController());

  Subject subject;

  SubjectTile({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        userController.currentSubjectId.value = subject.id;
        userController.currentSubject = subject;
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => SubjectScreen(subject: subject)));
      },
      child: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.93,
          height: 100,
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
          bottom: 20,
          child: Image(
            height: 120,
            image: AssetImage('assets/images/book.png'),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(110, 30, 0, 0),
          height: 80,
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  subject.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Teached by: ${subject.teacherName}",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
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
