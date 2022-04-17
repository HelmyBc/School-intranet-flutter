import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/services/http_service.dart';
import 'package:enetcom_app/views/admin_views/students/update_student_screen.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentCard extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  Student student;
  StudentCard({required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 1),
            Color.fromRGBO(171, 196, 255, 0.5),
            // Color.fromRGBO(215, 227, 252, 1),
            // Color.fromRGBO(171, 196, 255, 0.5),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatar(imageUrl: student.imageUrl),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Email: ${student.email} ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "Cin: ${student.cin}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "phone: ${student.phone}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "email: ${student.email}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              studentController.editingStudent.clear();
              studentController.editingStudent.add(student);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateStudentScreen()),
              );
            },
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 25,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent[400],
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              HttpService.deleteStudent(student.id);
              studentController.fetchStudents();
              const snackBar =
                  SnackBar(content: Text("Student removed succefully!"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 25,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
