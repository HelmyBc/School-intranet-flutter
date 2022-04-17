import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/views/root_app_animated.dart';
import 'package:enetcom_app/views/widgets/student_card_container.dart';
import 'package:enetcom_app/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PeopleScreen extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            leading: GestureDetector(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: Colors.black,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RootAppAnimated(),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            // ignore: prefer_const_constructors
            title: Text(
              'People',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
            centerTitle: false,
            pinned: true,
            floating: true,
            actions: [
              ClipOval(
                child: Material(
                  color: Colors.transparent, // Button color
                  child: InkWell(
                    splashColor: Colors.grey[200], // Splash color
                    onTap: () => null,
                    child: const SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.transparent, // Button color
                  child: InkWell(
                    splashColor: Colors.grey[200], // Splash color
                    onTap: () => null,
                    child: const SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(
                          MdiIcons.facebookMessenger,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ],
            // systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          // SliverToBoxAdapter(
          //   child: CreatePostContainer(currentUser: currentUser),
          // ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Rooms(onlineUsers: onlineUsers),
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final Student student = studentController.studentList[index];
                  return StudentCardContainer(student: student);
                },
                childCount: studentController.studentList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
