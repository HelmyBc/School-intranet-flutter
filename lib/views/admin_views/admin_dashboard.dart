import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/config/styles.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/controllers/feature_controller.dart';
import 'package:enetcom_app/controllers/post_controller.dart';
import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/models/feature.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/views/admin_views/add_feature_screen.dart';
import 'package:enetcom_app/views/admin_views/widgets/feature_container.dart';
import 'package:enetcom_app/views/admin_views/widgets/new_post_container.dart';
import 'package:enetcom_app/views/admin_views/admin_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({Key? key}) : super(key: key);

  final TeacherController teacherController = Get.put(TeacherController());
  final StudentController studentController = Get.put(StudentController());
  final ClasseController classeController = Get.put(ClasseController());
  final PostController postController = Get.put(PostController());
  final FeatureController featureController = Get.put(FeatureController());
  final DepartmentController departmentController =
      Get.put(DepartmentController());
  //final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var headerBox = Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.93,
          height: 170,
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromRGBO(200, 0, 0, 1),
                Color.fromRGBO(300, 0, 60, 0.9),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueAccent,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: const Text(
                  "School News",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "BREAKING\nNEWS?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Try to use catchy images and short titles",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          right: -30,
          top: -35,
          child: Image(
            height: 200,
            image: AssetImage("assets/images/news1.png"),
          ),
        ),
      ],
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Palette.scaffold,
          foregroundColor: Colors.black,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Admin Dashboard',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.refresh,
              ),
              iconSize: 28.0,
              onPressed: () {
                loadData();
              },
            ),
          ],
          bottom: TabBar(
            padding: const EdgeInsets.all(20.0),
            indicator: const BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.black,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black.withOpacity(0.6),
            tabs: const [
              Text('Enities'),
              Text('Features'),
            ],
            onTap: (index) {},
          ),
        ),
        body: TabBarView(children: [
          RefreshIndicator(
            onRefresh: () async => loadData(),
            child: ListView(
              children: [
                const SizedBox(height: 10.0),
                //_buildRegionTabBar(),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: AdminGrid(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: const Text(
                    "View/Delete Posts",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Obx(
                  () {
                    if (postController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        //controller: controller,
                        itemBuilder: (BuildContext context, int index) {
                          final Post post = postController.postList[index];
                          return NewPostContainer(post: post);
                        },
                        itemCount: postController.postList.length,
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          RefreshIndicator(
            onRefresh: () async => loadData(),
            child: ListView(children: [
              headerBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Feature dashboard",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddFeatureScreen()));
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () {
                  if (postController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final Feature feature =
                            featureController.featureList[index];
                        return FeatureContainer(feature: feature);
                      },
                      itemCount: featureController.featureList.length,
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
            ]),
          ),
        ]),
        // body: RefreshIndicator(
        //   onRefresh: () async => loadData(),
        //   child: ListView(
        //     children: [
        //       Column(
        //         children: [
        //           const SizedBox(height: 10.0),
        //           //_buildRegionTabBar(),
        //           const SizedBox(height: 10.0),
        //           Container(
        //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //             child: AdminGrid(),
        //           ),
        //           Container(
        //             padding: const EdgeInsets.symmetric(
        //                 vertical: 10.0, horizontal: 20.0),
        //             child: const Text(
        //               "View/Delete Posts",
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.black,
        //                 fontSize: 20.0,
        //               ),
        //             ),
        //           ),
        //           Obx(
        //             () {
        //               if (postController.isLoading.value) {
        //                 return const Center(child: CircularProgressIndicator());
        //               } else {
        //                 return ListView.builder(
        //                   shrinkWrap: true,
        //                   physics: const ScrollPhysics(),
        //                   //controller: controller,
        //                   itemBuilder: (BuildContext context, int index) {
        //                     final Post post = postController.postList[index];
        //                     return NewPostContainer(post: post);
        //                   },
        //                   itemCount: postController.postList.length,
        //                 );
        //               }
        //             },
        //           ),
        //           const SizedBox(height: 20),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Future loadData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    studentController.fetchStudents();
    teacherController.fetchTeachers();
    departmentController.fetchDepartments();
    postController.fetchPosts();
  }
}

DefaultTabController _buildRegionTabBar() {
  return DefaultTabController(
    length: 2,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[400],
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
        unselectedLabelColor: Colors.white,
        tabs: const [
          Text('Enities'),
          Text('Features'),
        ],
        onTap: (index) {},
      ),
    ),
  );
}

// SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
//   return SliverToBoxAdapter(
//     child: Container(
//       margin: const EdgeInsets.symmetric(
//         vertical: 10.0,
//         horizontal: 20.0,
//       ),
//       padding: const EdgeInsets.all(0.0),
//       height: screenHeight * 0.15,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             Color.fromRGBO(242, 174, 199, 1),
//             Color.fromRGBO(72, 149, 239, 1)
//           ],
//         ),
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           const Image(
//             image: AssetImage("assets/images/own_test.png"),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Text(
//                 'Do your own test!',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.01),
//               const Text(
//                 'Follow the instructions\nto do your own test.',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 10.0,
//                 ),
//                 maxLines: 2,
//               ),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }
