import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/models/models.dart';
import 'package:enetcom_app/views/widgets/category_list.dart';
import 'package:enetcom_app/views/widgets/feature_carousel.dart';
import 'package:enetcom_app/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Palette.scaffold,
              // ignore: prefer_const_constructors
              title: Image(
                  image:
                      const ExactAssetImage("assets/images/enetcom_logo.png"),
                  //height: 60.0,
                  width: 180.0,
                  alignment: FractionalOffset.center),
              centerTitle: false,
              floating: true,
              actions: [
                CircleButton(
                  icon: Icons.search,
                  iconColor: Palette.mainBlack,
                  toScreen: HomeScreen(),
                ),
                CircleButton(
                  icon: Icons.settings,
                  iconColor: Palette.mainBlack,
                  toScreen: HomeScreen(),
                ),
                // CircleButton(
                //   icon: MdiIcons.facebookMessenger,
                //   iconColor: Palette.mainBlack,
                //   toScreen: HomeScreen(),
                // ),
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
              child: FeatureCarousel(),
            ),
            SliverToBoxAdapter(
              child: CreatePostContainer(currentUser: currentUser),
            ),
            // SliverPadding(
            //   padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            //   sliver: SliverToBoxAdapter(
            //     child: Rooms(onlineUsers: onlineUsers),
            //   ),
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final Post post = posts[index];
                  return PostContainer(post: post);
                },
                childCount: posts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
