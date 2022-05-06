
import 'package:enetcom_app/controllers/subject_controller.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/services/http_subject_service.dart';
import 'package:enetcom_app/views/admin_views/subjects/update_subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectCard extends StatelessWidget {
  final SubjectController subjectController = Get.put(SubjectController());
  Subject subject;
  SubjectCard({required this.subject});

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              subjectController.editingSubject.clear();
              subjectController.editingSubject.add(subject);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateSubjectScreen()),
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
              HttpSubjectService.deleteSubject(subject.id);
              subjectController.fetchSubjects();
              const snackBar =
                  SnackBar(content: Text("Subject removed succefully!"));
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
