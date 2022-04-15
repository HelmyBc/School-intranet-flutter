import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:enetcom_app/views/admin_views/teachers/add_teacher_screen.dart';
import 'package:enetcom_app/views/admin_views/widgets/teacher_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherDashboard extends GetView<TeacherController> {
  final TeacherController teacherController = Get.put(TeacherController());

  TeacherDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return teacherController.teacherList == null
        ? Scaffold(
            backgroundColor: Palette.adminBg,
            appBar: AppBar(
              backgroundColor: const Color(0x99003153),
              elevation: 0.0,
              automaticallyImplyLeading: true,
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
                      MaterialPageRoute(
                          builder: (context) => AddTeacherScreen()),
                    );
                  },
                ),
              ],
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Palette.adminBg,
            appBar: AppBar(
              backgroundColor: const Color(0x99003153),
              elevation: 0.0,
              automaticallyImplyLeading: true,
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
                      MaterialPageRoute(
                          builder: (context) => AddTeacherScreen()),
                    );
                  },
                ),
              ],
            ),
            body: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                _buildHeader(),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 20.0),
                  sliver: SliverToBoxAdapter(
                    child: Obx(
                      () => Text(
                        'Teachers (${teacherController.teacherList.length})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                Obx(
                  () => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final Teacher teacher =
                            teacherController.teacherList[index];
                        return TeacherCard(teacher: teacher);
                      },
                      childCount: teacherController.teacherList.length,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  SliverPadding _buildHeader() {
    return const SliverPadding(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
