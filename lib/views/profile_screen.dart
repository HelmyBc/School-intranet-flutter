import 'package:avatar_view/avatar_view.dart';
import 'package:enetcom_app/controllers/post_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/views/admin_views/widgets/new_post_container.dart';
import 'package:enetcom_app/views/admin_views/widgets/post_shimmer.dart';
import 'package:enetcom_app/views/for_students/student_root_app.dart';
import 'package:enetcom_app/views/home%20screen/widgets/empty_content.dart';
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
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    userController.getSelectedUserPosts(widget.selectedUser);
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
              onPressed: () => Navigator.pop(context),
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
                  "Posts",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Obx(
                () {
                  if (userController.isLoading.value) {
                    return const PostShimmer();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final Post post =
                            userController.selectedUserPosts.reversed.toList()[index];
                        return NewPostContainer(post: post);
                      },
                      itemCount: userController.selectedUserPosts.length,
                    );
                  }
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Column(
                    children: const [
                      Image(
                          image:
                              ExactAssetImage("assets/images/empty_folder.png"),
                          //height: 60.0,
                          width: 200.0,
                          alignment: FractionalOffset.center),
                      SizedBox(height: 15.0),
                      Text(
                        "No posts yet or no more posts.",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 70.0),
            ],
          ),
        ),
      ),
    );
  }
}
