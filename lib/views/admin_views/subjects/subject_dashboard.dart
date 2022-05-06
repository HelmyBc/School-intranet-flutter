import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/subject_controller.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/views/admin_views/subjects/add_subject_screen.dart';
import 'package:enetcom_app/views/admin_views/widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectDashboard extends StatelessWidget {
  final SubjectController subjectController = Get.put(SubjectController());

  SubjectDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return subjectController.subjectList == null
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
                    subjectController.fetchSubjects();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddSubjectScreen()),
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
                    subjectController.fetchSubjects();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddSubjectScreen()),
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
                        'subjects (${subjectController.subjectList.length})',
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
                        final Subject subject =
                            subjectController.subjectList[index];
                        return SubjectCard(subject: subject);
                      },
                      childCount: subjectController.subjectList.length,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
