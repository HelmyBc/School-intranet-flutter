// import 'package:enetcom_app/config/palette.dart';
// import 'package:enetcom_app/views/current_profile_screen.dart';
// import 'package:enetcom_app/views/new_dashboard_screen.dart';
// import 'package:enetcom_app/views/screens.dart';
// import 'package:enetcom_app/views/students_screen.dart';
// import 'package:enetcom_app/views/widgets/widgets.dart';
// import 'package:enetcom_app/views/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class NavScreen extends StatefulWidget {
//   const NavScreen({Key? key}) : super(key: key);

//   @override
//   _NavScreenState createState() => _NavScreenState();
// }

// class _NavScreenState extends State<NavScreen> {
//   final List<Widget> _screens = [
//     HomeScreen(),
//     //PeopleScreen(),
//     StudentScreen(),
//     CurrentProfileScreen(),
//     Scaffold(),
//     NewDashboardScreen(),
//   ];
//   int _selectedIndex = 0;
//   final List<IconData> _icons = [
//     Icons.home,
//     MdiIcons.accountGroupOutline,
//     MdiIcons.accountCircleOutline,
//     MdiIcons.bellOutline,
//     Icons.menu
//   ];
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       systemNavigationBarColor: Palette.mainWhite, // navigation bar color
//       statusBarColor: Palette.mainWhite,
//       statusBarIconBrightness: Brightness.dark,
//       statusBarBrightness: Brightness.dark,
//       systemNavigationBarDividerColor: Palette.mainWhite,
//       // Color(0xFFF3F5F7), // status bar color
//     ));
//     return DefaultTabController(
//       length: _icons.length,
//       child: Scaffold(
//         body: TabBarView(
//           physics: const NeverScrollableScrollPhysics(),
//           children: _screens,
//         ),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.only(bottom: 8.0),
//           child: CustomTabBar(
//             icons: _icons,
//             selectedIndex: _selectedIndex,
//             onTap: (index) => setState(() => _selectedIndex = index),
//           ),
//         ),
//       ),
//     );
//   }
// }
