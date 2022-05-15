import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/feature_controller.dart';
import 'package:enetcom_app/controllers/post_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/views/admin_views/widgets/new_post_container.dart';
import 'package:enetcom_app/views/admin_views/widgets/post_shimmer.dart';
import 'package:enetcom_app/views/home%20screen/widgets/carousel_loading.dart';
import 'package:enetcom_app/views/home%20screen/widgets/student_category_list.dart';
import 'package:enetcom_app/views/login_screen.dart';
import 'package:enetcom_app/views/home%20screen/widgets/teacher_category_list.dart';
import 'package:enetcom_app/views/home%20screen/widgets/feature_carousel.dart';
import 'package:enetcom_app/views/widgets/shimmer_widget.dart';
import 'package:enetcom_app/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  UserController userController = Get.put(UserController());
  FeatureController featureController = Get.put(FeatureController());
  PostController postController = Get.put(PostController());

  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    print(userController.currentUserType.value);
    userController.getCurrentUser();
    if ((featureController.featureList != null ||
            featureController.featureList != []) &&
        userController.isLoading.value == false) {
      _isLoading = false;
    }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: RefreshIndicator(
        onRefresh: () async => loadData(),
        child: Scaffold(
          backgroundColor: Palette.scaffold,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Palette.scaffold,
                  // ignore: prefer_const_constructors
                  title: const Image(
                    image: ExactAssetImage("assets/images/enetcom_logo.png"),
                    width: 180.0,
                    alignment: FractionalOffset.center,
                  ),
                  centerTitle: false,
                  floating: true,
                  actions: [
                    CircleButton(
                      icon: Icons.search,
                      iconColor: Palette.mainBlack,
                      toScreen: HomeScreen(),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.transparent, // Button color
                        child: InkWell(
                          splashColor: Colors.grey[200], // Splash color
                          onTap: () {
                            logout(context);
                          },
                          child: const SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              MdiIcons.logout,
                              color: Palette.mainBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                userController.currentUserTypeInt.value == 1
                    ? const SliverPadding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        sliver: SliverToBoxAdapter(
                          child: TeacherCategoryList(),
                        ),
                      )
                    : const SliverPadding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        sliver: SliverToBoxAdapter(
                          child: StudentCategoryList(),
                        ),
                      ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Features",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                          ),
                        ),
                        Text(
                          "See more",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: GetBuilder<FeatureController>(
                    builder: (_c) {
                      if (_c.isLoading.isTrue) {
                        if (_c.featureList.isEmpty) {
                          return const CarouselLoading();
                        }
                      } else if (_c.featureList.isNotEmpty) {
                        return FeatureCarousel();
                      }
                      return Container();
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Obx(() {
                    if (userController.isLoading.value ||
                        userController.currentUser.value.imageUrl == null ||
                        userController.currentUser.value.imageUrl!.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: ShimmerWidget.rectangular(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          raduis: 20,
                        ),
                      );
                    } else {
                      return CreatePostContainer(
                          imageUrl: userController.currentUser.value.imageUrl!);
                    }
                  }),
                ),
                SliverToBoxAdapter(
                  child: Obx(
                    () {
                      if (postController.isLoading.value) {
                        return const PostShimmer();
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final Post post = postController.postList[index];
                            return NewPostContainer(post: post);
                          },
                          itemCount: postController.postList.length,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.clearRouteTree();
    Get.reset();
    Get.deleteAll();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false);
  }

  Future loadData() async {
    await Future.delayed(const Duration(milliseconds: 700));
    userController.getCurrentUser();
    featureController.fetchFeatures();
    postController.fetchPosts();
  }
}
