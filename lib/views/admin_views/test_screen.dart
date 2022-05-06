import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<String> selected = [];
  List<int> selectedIds = [];

  final TeacherController teacherController = Get.put(TeacherController());
  final StudentController studentController = Get.put(StudentController());
  final DepartmentController departmentController =
      Get.put(DepartmentController());

  @override
  Widget build(BuildContext context) {
    List<Department> departmentList = departmentController.departmentList;
    List<String> generateDepartmentNames() {
      return departmentController.departmentList
          .map(
            (dep) => dep.shortName,
          )
          .toList();
    }

    List<int> generateDepartmentIds() {
      return departmentController.departmentList
          .where((dep) => selected.contains(dep.shortName))
          .map(
            (dep) => dep.id,
          )
          .toList();
    }

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            // DropDownMultiSelect comes from multiselect
            child: DropDownMultiSelect(
              whenEmpty: 'Select a department',
              options: generateDepartmentNames(),
              selectedValues: selected,
              onChanged: (List<String> x) {
                setState(() {
                  selected = x;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                selectedIds = generateDepartmentIds();
                print("selected list is: $selected");
                print("selected ids list is: $selectedIds");
              },
            ),
          ),
        ],
      ),
    );
  }
}
