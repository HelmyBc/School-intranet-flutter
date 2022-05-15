import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/views/current_profile_screen.dart';
import 'package:enetcom_app/views/login_screen.dart';
import 'package:enetcom_app/views/widgets/build_menu_item_box.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Palette.scaffold,
          title: const Image(
              image: ExactAssetImage("assets/images/enetcom_logo.png"),
              //height: 60.0,
              width: 180.0,
              alignment: FractionalOffset.center),
          centerTitle: false,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CurrentProfileScreen(
                            currentUser: userController.currentUser.value)));
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileAvatar(
                        raduis: 40.0,
                        imageUrl: userController.currentUser.value.imageUrl!),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${userController.currentUser.value.firstName} ${userController.currentUser.value.lastName}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            "Email: ${userController.currentUser.value.email}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            "Phone: ${userController.currentUser.value.phone}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildMenuItemBox(
                    context, "Classroom", "assets/images/class.png"),
                buildMenuItemBox(
                    context, "Internship", "assets/images/stage.png"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildMenuItemBox(
                    context, "Exams", "assets/images/exam_time.png"),
                buildMenuItemBox(
                    context, "Timetable", "assets/images/timetable.png"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildMenuItemBox(
                    context, "Settings", "assets/images/settings.png"),
                GestureDetector(
                  onTap: () => logout(context),
                  child: buildMenuItemBox(
                      context, "Logout", "assets/images/logout.png"),
                ),
              ],
            ),
          ],
        ));
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
}
