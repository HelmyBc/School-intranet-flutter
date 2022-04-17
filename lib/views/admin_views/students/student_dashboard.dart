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
              studentController.fetchStudents();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 28.0,
            
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStudentScreen()),
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
                if (studentController.isLoading.value) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                      child: const Text(
                        'Students (N/A)',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'Students (${studentController.studentList.length})',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(
                () {
                  if (studentController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final Student student =
                            studentController.studentList[index];
                        return StudentCard(student: student);
                      },
                      itemCount: studentController.studentList.length,
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
    studentController.fetchStudents();
  }
}
