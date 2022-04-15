import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/config/styles.dart';
import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/views/widgets/stats_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({Key? key}) : super(key: key);

  final TeacherController teacherController = Get.put(TeacherController());
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.adminBg,
      appBar: AppBar(
        backgroundColor: const Color(0x99003153),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            iconSize: 28.0,
            onPressed: () {
              studentController.fetchStudents();
              teacherController.fetchTeachers();
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          _buildYourOwnTest(screenHeight),
        ],
      ),
    );
  }
}

SliverPadding _buildHeader() {
  return const SliverPadding(
    padding: EdgeInsets.all(20.0),
    sliver: SliverToBoxAdapter(
      child: Text(
        'Admin Dashboard',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

SliverToBoxAdapter _buildRegionTabBar() {
  return SliverToBoxAdapter(
    child: DefaultTabController(
      length: 2,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: TabBar(
          indicator: const BubbleTabIndicator(
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
            indicatorHeight: 40.0,
            indicatorColor: Colors.white,
          ),
          labelStyle: Styles.tabTextStyle,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          tabs: const [
            Text('Enities'),
            Text('Features'),
          ],
          onTap: (index) {},
        ),
      ),
    ),
  );
}

SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
  return SliverToBoxAdapter(
    child: Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      padding: const EdgeInsets.all(0.0),
      height: screenHeight * 0.15,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(242, 174, 199, 1),
            Color.fromRGBO(72, 149, 239, 1)
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Image(
            image: AssetImage("assets/images/own_test.png"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Do your own test!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              const Text(
                'Follow the instructions\nto do your own test.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
                maxLines: 2,
              ),
            ],
          )
        ],
      ),
    ),
  );
}
