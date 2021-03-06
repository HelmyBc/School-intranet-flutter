import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/views/admin_views/admin_dashboard.dart';
import 'package:enetcom_app/views/current_profile_screen.dart';
import 'package:enetcom_app/views/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../home screen/home_screen.dart';

class AdminRootApp extends StatefulWidget {
  const AdminRootApp({Key? key}) : super(key: key);

  @override
  State<AdminRootApp> createState() => _AdminRootAppState();
}

class _AdminRootAppState extends State<AdminRootApp> {
  UserController userController = Get.put(UserController());

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    userController.getCurrentUser();
    User currentUser = userController.currentUser.value;
    Classe currentUserClasse = userController.currentClasse;
    double displayWidth = MediaQuery.of(context).size.width;
    List barItems = [
      HomeScreen(),
      UsersScreen(),
      CurrentProfileScreen(
        currentUser: currentUser,
      ),
      AdminDashboard(),
    ];
    Widget getBarPage() {
      return IndexedStack(
        index: currentIndex,
        children: List.generate(
          barItems.length,
          (index) => barItems[index],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Palette.scaffold,
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
            horizontal: displayWidth * .05, vertical: 10.0),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Colors.blue.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex ? listOfStrings[index] : '',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == currentIndex
                                ? Colors.blue
                                : Colors.black38,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: getBarPage(),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.group,
    Icons.person,
    Icons.menu,
  ];

  List<String> listOfStrings = [
    'Home',
    'Users',
    'Account',
    'Menu',
  ];
}
