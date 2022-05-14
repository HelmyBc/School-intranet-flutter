// import 'package:avatar_view/avatar_view.dart';
// import 'package:flutter/material.dart';

// class ProfileImage extends StatelessWidget {
//   final String imageUrl;
//   const ProfileImage({
//     Key? key,
//     required this.imageUrl,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).colorScheme.primary;
//     return Center(
//       child: Stack(
//         children: [
//           AvatarView(
//             radius: 64,
//             borderColor: Colors.grey,
//             avatarType: AvatarType.CIRCLE,
//             backgroundColor: Colors.red,
//             imagePath: imageUrl,
//             placeHolder: const Icon(
//               Icons.person,
//               size: 18,
//             ),
//             errorWidget: const Icon(
//               Icons.error,
//               size: 18,
//             ),
//           ),
//           Positioned(
//             bottom: 0.0,
//             right: 4.0,
//             child: ClipOval(
//               child: Container(
//                 padding: const EdgeInsets.all(3.0),
//                 color: Colors.white,
//                 child: const Icon(
//                   Icons.edit,
//                   size: 20.0,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget buildImage() {
//   //   return AvatarView(
//   //     radius: 64,
//   //     borderColor: Colors.grey,
//   //     avatarType: AvatarType.CIRCLE,
//   //     backgroundColor: Colors.red,
//   //     imagePath: imageUrl,
//   //     placeHolder: const Icon(
//   //       Icons.person,
//   //       size: 18,
//   //     ),
//   //     errorWidget: const Icon(
//   //       Icons.error,
//   //       size: 18,
//   //     ),
//   //   );
//   // }

//   // Widget buildEditIcon(Color color) {
//   //   return ClipOval(
//   //     child: Container(
//   //       padding: const EdgeInsets.all(3.0),
//   //       color: Colors.white,
//   //       child: const Icon(
//   //         Icons.edit,
//   //         size: 20.0,
//   //         color: Colors.white,
//   //       ),
//   //     ),
//   //   );

//     // buildCircle(
//     //   color: Colors.white,
//     //   all: 3.0,
//     //   child: buildCircle(
//     //     color: color,
//     //     all: 8.0,
//     //     child: const Icon(
//     //       Icons.edit,
//     //       size: 20.0,
//     //       color: Colors.white,
//     //     ),
//     //   ),
//     // );
//   }

// //   Widget buildCircle({
// //     required Color color,
// //     required double all,
// //     required Widget child,
// //   }) {
// //     return ClipOval(
// //       child: Container(
// //         padding: EdgeInsets.all(all),
// //         color: color,
// //         child: child,
// //       ),
// //     );
// //   }
// // }
