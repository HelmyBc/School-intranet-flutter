import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/views/admin_views/students/add_student_screen.dart';
import 'package:enetcom_app/views/admin_views/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentDashboard extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  StudentDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return studentController.studentList == null
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
                    studentController.fetchStudents();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddStudentScreen()),
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
                    studentController.fetchStudents();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddStudentScreen()),
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
                        'Students (${studentController.studentList.length})',
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
                        final Student student =
                            studentController.studentList[index];
                        return StudentCard(student: student);
                      },
                      childCount: studentController.studentList.length,
                    ),
                  ),
                ),
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            //   tooltip: "Add a new student",
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => AddStudentScreen()),
            //     );
            //   },
            //   // onPressed: () {
            //   //   showModalBottomSheet(
            //   //     // backgroundColor: Colors.white,
            //   //       context: context,
            //   //       backgroundColor: Colors.transparent,
            //   //       isScrollControlled: true,
            //   //       builder: (context) {
            //   //         return AddStudentView();
            //   //       });
            //   // },
            //   backgroundColor: const Color.fromRGBO(215, 227, 252, 0.5),
            //   child: const Icon(
            //     Icons.add,
            //     color: Colors.black,
            //   ),
            // ),
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
