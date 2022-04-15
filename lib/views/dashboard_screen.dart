// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Color> colors = [
//       Colors.amber,
//       Colors.blueAccent,
//       Colors.green.shade200,
//       Colors.red.shade400,
//       Colors.grey,
//       Colors.pinkAccent,
//       Colors.green,
//       Colors.orange,
//       Colors.black,
//       Colors.red,
//       Colors.grey,
//       Colors.deepPurple
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Dashboard",
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 35.0,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 0,
//           ),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: GridView.custom(
//         shrinkWrap: true,
//         padding: const EdgeInsets.all(18),
//         gridDelegate: SliverQuiltedGridDelegate(
//           crossAxisCount: 4,
//           mainAxisSpacing: 12,
//           crossAxisSpacing: 12,
//           repeatPattern: QuiltedGridRepeatPattern.inverted,
//           pattern: [
//             const QuiltedGridTile(2, 2),
//             QuiltedGridTile(1, 1),
//             QuiltedGridTile(1, 1),
//             QuiltedGridTile(1, 2),
//             QuiltedGridTile(1, 1),
//             QuiltedGridTile(1, 1),
//           ],
//         ),
//         childrenDelegate: SliverChildBuilderDelegate(
//           (context, index) => DashboardTile(
//             tileColor: colors[index],
//             tileIcon: Icons.settings,
//             onPressed: null as Function,
//           ),
//           childCount: 12,
//         ),
//       ),
//     );
//   }
// }

// class DashboardTile extends StatelessWidget {
//   final Color tileColor;
//   final IconData tileIcon;
//   final Function onPressed;
//   const DashboardTile({
//     Key? key,
//     required this.tileColor,
//     required this.tileIcon,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: tileColor,
//       ),
//       child: Center(
//         child: IconButton(onPressed: () => onPressed, icon: Icon(tileIcon)),
//       ),
//     );
//   }
// }
