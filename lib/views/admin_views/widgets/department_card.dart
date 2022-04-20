import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/services/http_department_service.dart';
import 'package:enetcom_app/views/admin_views/department/update_department_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepartmentCard extends StatelessWidget {
  final DepartmentController departmentController =
      Get.put(DepartmentController());
  Department department;
  DepartmentCard({required this.department});

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
                  department.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Short name: ${department.shortName} ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              departmentController.editingDepartment.clear();
              departmentController.editingDepartment.add(department);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateDepartmentScreen()),
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
              HttpDepartmentService.deleteDepartment(department.id);
              departmentController.fetchDepartments();
              const snackBar =
                  SnackBar(content: Text("Department removed succefully!"));
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
