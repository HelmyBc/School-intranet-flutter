import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/feature_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/models/post_model.dart';
import 'package:enetcom_app/views/home%20screen/widgets/carousel_loading.dart';
import 'package:enetcom_app/views/home%20screen/widgets/carousel_slider_data_found.dart';
import 'package:enetcom_app/views/login_screen.dart';
import 'package:enetcom_app/views/widgets/category_list.dart';
import 'package:enetcom_app/views/home%20screen/widgets/feature_carousel.dart';
import 'package:enetcom_app/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  FeatureController featureController = Get.put(FeatureController());
  UserController userController = Get.put(UserController());

  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    featureController.fetchFeatures();
    if (featureController.featureList != null ||
        featureController.featureList != []) {
      _isLoading = false;
    }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Palette.scaffold,
                // ignore: prefer_const_constructors
                title: Hero(
                  tag: "logo",
                  child: const Image(
                    image: ExactAssetImage("assets/images/enetcom_logo.png"),
                    width: 180.0,
                    alignment: FractionalOffset.center,
                  ),
                ),
                centerTitle: false,
                floating: true,
                actions: [
                  CircleButton(
                    icon: Icons.search,
                    iconColor: Palette.mainBlack,
                    toScreen: HomeScreen(),
                  ),
                  // CircleButton(
                  //   icon: Icons.settings,
                  //   iconColor: Palette.mainBlack,
                  //   toScreen: HomeScreen(),
                  // ),
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
                              Icons.logout_rounded,
                              color: Palette.mainBlack,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                sliver: SliverToBoxAdapter(
                  child: CategoryList(),
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
                      if (_c.featureList.isNotEmpty) {
                        return FeatureCarousel();
                      } else {
                        return const CarouselLoading();
                      }
                    } else if (_c.featureList.isNotEmpty) {
                      return FeatureCarousel();
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              // SliverToBoxAdapter(
              //   child: CreatePostContainer(currentUser: currentUser),
              // ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final PostModel post = posts[index];
                    return PostContainer(post: post);
                  },
                  childCount: posts.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.deleteAll();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false);
  }
}
