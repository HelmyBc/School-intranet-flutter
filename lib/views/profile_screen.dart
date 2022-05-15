import 'package:avatar_view/avatar_view.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/views/for_students/student_root_app.dart';
import 'package:enetcom_app/views/widgets/shimmer_widget.dart';
import 'package:enetcom_app/views/widgets/user_profile_info_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/views/home%20screen/widgets/create_post_container.dart';
import 'package:enetcom_app/views/for_teachers/teacher_root_app.dart';
import 'package:enetcom_app/views/widgets/profile_info_tile.dart';

class ProfileScreen extends StatefulWidget {
  final User selectedUser;
  const ProfileScreen({
    Key? key,
    required this.selectedUser,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        appBar: AppBar(
          title: Text(
            "${widget.selectedUser.firstName} ${widget.selectedUser.lastName}",
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              //  ProfileAvatar(imageUrl: selectedUser.imageUrl!),
              //PFOFILE IMAGE WIDGET
              Center(
                child: AvatarView(
                  radius: 64,
                  borderColor: Colors.grey,
                  avatarType: AvatarType.CIRCLE,
                  backgroundColor: Colors.red,
                  imagePath: widget.selectedUser.imageUrl!,
                  placeHolder: const ShimmerWidget.rectangular(
                    height: 64 * 2,
                    width: 64.2,
                    raduis: 64,
                  ),
                  errorWidget: const Icon(
                    Icons.person,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 14.0, right: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profile Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "${widget.selectedUser.userType}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              UserInfoTile(user: widget.selectedUser),
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
              CreatePostContainer(imageUrl: widget.selectedUser.imageUrl),
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
              // Obx(
              //   () {
              //     if (user.isLoading.value) {
              //       return const Center(child: CircularProgressIndicator());
              //     } else {
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         physics: const ScrollPhysics(),
              //         itemBuilder: (BuildContext context, int index) {
              //           final Post post =
              //               userController.selectedUserPosts[index];
              //           return NewPostContainer(post: post);
              //         },
              //         itemCount: widget.selectedUserPosts.length,
              //       );
              //     }
              //   },
              // ),
              // PostContainer(post: posts[0]),
              // PostContainer(post: posts[4]),
            ],
          ),
        ),
      ),
    );
  }
}
