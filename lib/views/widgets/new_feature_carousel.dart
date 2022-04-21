// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:enetcom_app/config/palette.dart';
// import 'package:enetcom_app/controllers/feature_controller.dart';
// import 'package:enetcom_app/models/feature_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class FeatureCarousel extends StatelessWidget {
//   FeatureCarousel({Key? key}) : super(key: key);
//   FeatureController featureController = Get.put(FeatureController());

//   int _current = 0;

//   @override
//   Widget build(BuildContext context) {
//     RxList features = featureController.featureList;
//     List<Widget> generateImagesTiles() {
//       return features
//           .map(
//             (feature) => ClipRRect(
//                 child: Image.asset(
//                   feature.imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.circular(15.0)),
//           )
//           .toList();
//     }

//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       color: Palette.scaffold,
//       child: GestureDetector(
//         onTap: () => showModalBottomSheet(
//           backgroundColor: Colors.transparent,
//           isScrollControlled: true,
//           context: context,
//           builder: (BuildContext context) {
//             return buildSheet(features[_current], context);
//           },
//         ),
//         child: Stack(
//           children: [
//             Obx(
//               () => CarouselSlider(
//                 items: generateImagesTiles(),
//                 options: CarouselOptions(
//                     enlargeCenterPage: true,
//                     autoPlay: true,
//                     aspectRatio: 3 / 2,
//                     onPageChanged: (index, other) {
//                       featureController.current = index as RxInt;
//                       // setState(() {
//                       //   _current = index;
//                       // });
//                     }),
//               ),
//             ),
//             AspectRatio(
//               aspectRatio: 3 / 2,
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Text(
//                     features[_current].title,
//                     style: TextStyle(
//                       shadows: [
//                         Shadow(
//                           color: Colors.black.withOpacity(0.9),
//                           offset: const Offset(1, 1),
//                           blurRadius: 12,
//                         ),
//                       ],
//                       decoration: TextDecoration.none,
//                       color: Colors.white,
//                       fontSize: 30.0,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget makeDismissible(
//       {required Widget child, required BuildContext context}) {
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () => Navigator.of(context).pop(),
//       child: GestureDetector(onTap: () {}, child: child),
//     );
//   }

//   Widget buildSheet(FeatureModel feature, BuildContext context) {
//     return makeDismissible(
//       context: context,
//       child: DraggableScrollableSheet(
//         initialChildSize: 0.5,
//         minChildSize: 0.2,
//         maxChildSize: 0.8,
//         builder: (BuildContext context, ScrollController scrollController) {
//           return Container(
//             decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius:
//                     BorderRadius.vertical(top: Radius.circular(20.0))),
//             child: ListView(
//               controller: scrollController,
//               children: [
//                 ClipRRect(
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(20.0)),
//                   child: Stack(
//                     children: [
//                       Image.asset(feature.imageUrl),
//                       Positioned(
//                         top: 5,
//                         right: -50,
//                         child: Container(
//                           margin: const EdgeInsets.only(right: 40.0),
//                           child: MaterialButton(
//                             shape: const CircleBorder(),
//                             color: Colors.black54.withOpacity(0.4),
//                             padding: const EdgeInsets.all(8.0),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Icon(
//                               Icons.close,
//                               color: Colors.white,
//                               size: 20.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Container(
//                           padding: const EdgeInsets.only(top: 8.0, left: 10.0),
//                           child: Text(
//                             feature.title,
//                             style: TextStyle(
//                               shadows: [
//                                 Shadow(
//                                   color: Colors.black.withOpacity(0.9),
//                                   offset: const Offset(1, 1),
//                                   blurRadius: 12,
//                                 ),
//                               ],
//                               decoration: TextDecoration.none,
//                               color: Colors.white,
//                               fontSize: 30.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text(
//                     feature.description,
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ],
//             ),
//             // controller: scrollController,
//           );
//         },
//       ),
//     );
//   }
// }
