import 'package:avatar_view/avatar_view.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/views/admin_views/widgets/new_post_container.dart';
import 'package:enetcom_app/views/for_students/student_root_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/views/edit_profile_screen.dart';
import 'package:enetcom_app/views/home%20screen/widgets/create_post_container.dart';
import 'package:enetcom_app/views/for_teachers/teacher_root_app.dart';
import 'package:enetcom_app/views/widgets/profile_info_tile.dart';

class CurrentProfileScreen extends StatefulWidget {
  final User currentUser;
  const CurrentProfileScreen({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  _CurrentProfileScreenState createState() => _CurrentProfileScreenState();
}

class _CurrentProfileScreenState extends State<CurrentProfileScreen> {
  final UserController userController = Get.put(UserController());

  // User currentUser = User(email: "", password: "");

  @override
  Widget build(BuildContext context) {
    User currentUser = userController.currentUser.value;
    userController.getCurrentUserPosts();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        appBar: AppBar(
          title: Text(
            "${widget.currentUser.firstName} ${widget.currentUser.lastName}",
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
                  builder: (_) => userController.currentUserTypeInt.value == 1
                      ? const TeacherRootApp()
                      : const StudentRootApp(),
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
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
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
              const SizedBox(height: 20),
              //  ProfileAvatar(imageUrl: currentUser.imageUrl!),
              //PFOFILE IMAGE WIDGET
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProfileScreen()));
                },
                child: Center(
                  child: Stack(
                    children: [
                      AvatarView(
                        radius: 64,
                        borderColor: Colors.grey,
                        avatarType: AvatarType.CIRCLE,
                        backgroundColor: Colors.red,
                        imagePath: userController.currentUser.value.imageUrl!,
                        placeHolder: const Icon(
                          Icons.person,
                          size: 18,
                        ),
                        errorWidget: const Icon(
                          Icons.error,
                          size: 18,
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 4.0,
                        child: ClipOval(
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(3.0),
                            child: ClipOval(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.blue,
                                child: const Icon(
                                  Icons.edit,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              ProfileInfoTile(user: widget.currentUser),

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
              CreatePostContainer(currentUser: widget.currentUser),
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
              Obx(
                () {
                  if (userController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final Post post =
                            userController.currentUserPosts[index];
                        return NewPostContainer(post: post);
                      },
                      itemCount: userController.currentUserPosts.length,
                    );
                  }
                },
              ),
              // PostContainer(post: posts[0]),
              // PostContainer(post: posts[4]),
            ],
          ),
        ),
      ),
    );
  }
}
