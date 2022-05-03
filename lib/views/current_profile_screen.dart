import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/views/edit_profile_screen.dart';
import 'package:enetcom_app/views/root_app_animated.dart';
import 'package:enetcom_app/views/home%20screen/widgets/create_post_container.dart';
import 'package:enetcom_app/views/widgets/post_container.dart';
import 'package:enetcom_app/views/widgets/profile_image_widget.dart';
import 'package:enetcom_app/views/widgets/profile_info_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrentProfileScreen extends StatefulWidget {
  const CurrentProfileScreen({Key? key}) : super(key: key);

  @override
  _CurrentProfileScreenState createState() => _CurrentProfileScreenState();
}

class _CurrentProfileScreenState extends State<CurrentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = currentUser;
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        title: Text(
          currentUser.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
        leading: GestureDetector(
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RootAppAnimated(),
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Palette.mainWhite,
        actions: [
          // CircleButton(
          //   icon: Icons.done,
          //   iconColor: Palette.mainBlack,
          //   toScreen: const NavScreen(),
          // )
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Palette.facebookBlue,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EditProfileScreen())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileImage(
              imageUrl: currentUser.imageUrl,
              onClicked: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()));
              },
            ),
            // const SizedBox(
            //   height: 24.0,
            // ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       currentUser.name,
            //       style: const TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 24.0,
            //       ),
            //     ),
            //     const SizedBox(height: 4.0),
            //     Text("Etudiant à : ${currentUser.university}"),
            //   ],
            // ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 14.0),
              child: Text(
                "Profile Info",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            ProfileInfoTile(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 14.0),
              child: Text(
                "Create a post",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            CreatePostContainer(currentUser: currentUser),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 14.0),
              child: Text(
                "My posts",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            PostContainer(post: posts[0]),
            PostContainer(post: posts[4]),

          ],
        ),
      ),
    );
  }
}
