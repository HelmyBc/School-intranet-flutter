import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:enetcom_app/services/http_teacher_service.dart';
import 'package:enetcom_app/views/admin_views/teachers/update_teacher_screen.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherCard extends StatelessWidget {
  final TeacherController teacherController = Get.put(TeacherController());
  Teacher teacher;
  TeacherCard({required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(215, 227, 252, 1),
            Color.fromRGBO(171, 196, 255, 0.5),
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
          ProfileAvatar(imageUrl: teacher.imageUrl!),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${teacher.firstName} ${teacher.lastName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Email: ${teacher.email} ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "Cin: ${teacher.cin}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "phone: ${teacher.phone}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "email: ${teacher.email}",
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
              teacherController.editingTeacher.clear();
              teacherController.editingTeacher.add(teacher);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateTeacherScreen()),
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
              HttpTeacherService.deleteTeacher(teacher.id!);
              teacherController.fetchTeachers();
              const snackBar =
                  SnackBar(content: Text("Teacher removed succefully!"));
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
