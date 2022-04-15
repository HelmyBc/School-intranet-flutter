import 'package:enetcom_app/theme/color.dart';
import 'package:enetcom_app/views/admin_views/admin_dashboard.dart';
import 'package:enetcom_app/views/current_profile_screen.dart';
import 'package:enetcom_app/views/home_screen.dart';
import 'package:enetcom_app/views/new_dashboard_screen.dart';
import 'package:enetcom_app/views/students_screen.dart';
import 'package:enetcom_app/views/widgets/bottombar_item.dart';
import 'package:flutter/material.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int activeTab = 0;
  List barItems = [
    {
      "icon": "assets/icons/home.svg",
      "active_icon": "assets/icons/home.svg",
      "page": HomeScreen(),
    },
    {
      "icon": "assets/icons/group.svg",
      "active_icon": "assets/icons/group.svg",
      "page": StudentScreen(),
    },
    {
      "icon": "assets/icons/profile.svg",
      "active_icon": "assets/icons/profile.svg",
      "page": CurrentProfileScreen(),
    },
    {
      "icon": "assets/icons/notification.svg",
      "active_icon": "assets/icons/notification.svg",
      "page": Scaffold(),
    },
    {
      "icon": "assets/icons/menu.svg",
      "active_icon": "assets/icons/menu.svg",
      "page":  AdminDashboard(),
    },
  ];

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  animatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      activeTab = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      bottomNavigationBar: getBottomBar(),
      body: getBarPage(),
    );
  }

  Widget getBarPage() {
    return IndexedStack(
        index: activeTab,
        children: List.generate(
            barItems.length, (index) => animatedPage(barItems[index]["page"])));
  }

  Widget getBottomBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, right: 6, left: 6),
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bottomBarColor,
          // color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: shadowColor.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            barItems.length,
            (index) => BottomBarItem(
              barItems[index]["icon"],
              isActive: activeTab == index,
              activeColor: primary,
              onTap: () {
                onPageChanged(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
