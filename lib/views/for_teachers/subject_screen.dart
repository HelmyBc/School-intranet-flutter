import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/course.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/models/td.dart';
import 'package:enetcom_app/views/for_teachers/upload_course_screen.dart';
import 'package:enetcom_app/views/for_teachers/upload_td_screen.dart';
import 'package:enetcom_app/views/home%20screen/widgets/course_tile.dart';
import 'package:enetcom_app/views/home%20screen/widgets/empty_content.dart';
import 'package:enetcom_app/views/home%20screen/widgets/td_tile.dart';
import 'package:enetcom_app/views/home%20screen/widgets/upload_box.dart';

class SubjectScreen extends StatelessWidget {
  Subject subject;
  SubjectScreen({
    Key? key,
    required this.subject,
  }) : super(key: key);

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    userController.getUserClasseSubjectCourses();
    userController.getUserClasseSubjectTds();
    Subject subject = userController.currentSubject;
    userController.onInit();
    print(subject.name);
    print(userController.currentUserType.value);
    print(userController.currentUserTypeInt.value);
    return RefreshIndicator(
      onRefresh: () async => loadData(),
      child: Scaffold(
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
        body: ListView(shrinkWrap: true, children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                height: 170,
                margin: const EdgeInsets.fromLTRB(10, 20, 20, 20.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(0, 31, 100, 1),
                      Color.fromRGBO(4, 76, 144, 0.9),
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
                      child: const Text(
                        "Classroom space",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "We bring all you\nneed in your hand!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Courses, TDs, TDs Correction.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                right: -10,
                top: 0,
                child: Image(
                    image: ExactAssetImage("assets/images/student_2.png"),
                    //height: 60.0,
                    width: 160.0,
                    alignment: FractionalOffset.center),
                //child:Image.asset("assets/images/student_1.png",height: 50,
              ),
            ],
          ),
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
                    "${subject.name} courses",
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
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Courses",
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
                        builder: (_) => UploadCourseScreen(subject: subject),
                      ),
                    );
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
                  final Course course =
                      userController.currentUserClasseSubjectCourses[index];
                  return CourseTile(
                    course: course,
                  );
                },
                itemCount:
                    userController.currentUserClasseSubjectCourses.length,
              );
            }
          }),
          GestureDetector(
            child: UploadBox(
              text: "Add more courses? upload courses here.",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UploadCourseScreen(subject: subject),
                ),
              );
            },
          ),
          const Divider(thickness: 2.0),
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
                    "${subject.name} TDs",
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
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "TDs",
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
                        builder: (_) => UploadTdScreen(subject: subject),
                      ),
                    );
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
                  final Td td =
                      userController.currentUserClasseSubjectTds[index];
                  return TdTile(
                    td: td,
                  );
                },
                itemCount: userController.currentUserClasseSubjectTds.length,
              );
            }
          }),
          GestureDetector(
            child: UploadBox(
              text: "Add more TDs? upload TDs here.",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UploadTdScreen(subject: subject),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }

  Future loadData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    userController.getUserClasseSubjectCourses;
  }
}
