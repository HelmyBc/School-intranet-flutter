import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:enetcom_app/views/admin_views/teachers/add_teacher_screen.dart';
import 'package:enetcom_app/views/admin_views/widgets/teacher_card.dart';
import 'package:enetcom_app/views/for_teachers/teacher_root_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherDashboard extends StatelessWidget {
  final TeacherController teacherController = Get.put(TeacherController());

  TeacherDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        brightness: Brightness.light,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            iconSize: 28.0,
            onPressed: () {
              teacherController.fetchTeachers();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 28.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTeacherScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => loadData(),
        child: Column(
          children: [
            Obx(
              () {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                    child: Text(
                      'Teachers (${teacherController.teacherList.length})',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(
                () {
                  if (teacherController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final Teacher teacher =
                            teacherController.teacherList[index];
                        return TeacherCard(teacher: teacher);
                      },
                      itemCount: teacherController.teacherList.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future loadData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    teacherController.fetchTeachers();
  }
}
