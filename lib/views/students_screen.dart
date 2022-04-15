import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/views/widgets/online_bar_widget.dart';
import 'package:enetcom_app/views/widgets/student_card_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class StudentScreen extends StatelessWidget {
  // final GlobalKey<RefreshIndicatorState> _refreshIndacatorKey =
  //     GlobalKey<RefreshIndicatorState>();
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            // letterSpacing: -1.2,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async => studentController.refresh(),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
              child: Rooms(onlineUsers: onlineUsers),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (studentController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final Student student =
                          studentController.studentList[index];
                      return StudentCardContainer(student: student);
                    },
                    itemCount: studentController.studentList.length,
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  
}
