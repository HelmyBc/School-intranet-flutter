import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/views/admin_views/department/add_department_screen.dart';
import 'package:enetcom_app/views/admin_views/widgets/department_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepartmentDashboard extends StatelessWidget {
  final DepartmentController departmentController =
      Get.put(DepartmentController());

  DepartmentDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return departmentController.departmentList == null
        ? Scaffold(
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
                    departmentController.fetchDepartments();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddDepartmentScreen()),
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
                    departmentController.fetchDepartments();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddDepartmentScreen()),
                    );
                  },
                ),
              ],
            ),
            body: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 20.0),
                  sliver: SliverToBoxAdapter(
                    child: Obx(
                      () => Text(
                        'Departments (${departmentController.departmentList.length})',
                        style: const TextStyle(
                          color: Colors.black,
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
                        final Department department =
                            departmentController.departmentList[index];
                        return DepartmentCard(department: department);
                      },
                      childCount: departmentController.departmentList.length,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
