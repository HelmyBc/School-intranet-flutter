import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/views/admin_views/classes/add_classe_screen.dart';
import 'package:enetcom_app/views/admin_views/department/add_department_screen.dart';
import 'package:enetcom_app/views/admin_views/widgets/classe_card.dart';
import 'package:enetcom_app/views/admin_views/widgets/department_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClasseDashboard extends StatelessWidget {
  final ClasseController classeController = Get.put(ClasseController());

  ClasseDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return classeController.classeList == null
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
                    classeController.fetchClasses();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddClasseScreen()),
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
                    classeController.fetchClasses();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddClasseScreen()),
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
                        'Classes (${classeController.classeList.length})',
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
                        final Classe classe =
                            classeController.classeList[index];
                        return ClasseCard(classe: classe);
                      },
                      childCount: classeController.classeList.length,
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
              ],
            ),
          );
  }
}
