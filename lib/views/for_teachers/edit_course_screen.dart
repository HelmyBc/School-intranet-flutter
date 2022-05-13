// import 'dart:convert';
// import 'dart:io';

// import 'package:dotted_border/dotted_border.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:open_file/open_file.dart';

// import 'package:enetcom_app/config/palette.dart';
// import 'package:enetcom_app/controllers/course_controller.dart';
// import 'package:enetcom_app/controllers/user_controller.dart';
// import 'package:enetcom_app/models/attachment.dart';
// import 'package:enetcom_app/models/course.dart';
// import 'package:enetcom_app/models/subject.dart';
// import 'package:enetcom_app/services/http_course_service.dart';
// import 'package:enetcom_app/views/home%20screen/widgets/course_tile.dart';

// class EditCourseScreen extends StatefulWidget {
//   Course course;
//   EditCourseScreen({
//     Key? key,
//     required this.course,
//   }) : super(key: key);

//   @override
//   State<EditCourseScreen> createState() => _EditCourseScreenState();
// }

// class _EditCourseScreenState extends State<EditCourseScreen> {
//   final UserController userController = Get.put(UserController());
//   final CourseController courseController = Get.put(CourseController());
//   TextEditingController titleController = TextEditingController();

//   Course? course;

//   @override
//   Widget build(BuildContext context) {
//     TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           backgroundColor: Palette.scaffold,
//           title: const Image(
//               image: ExactAssetImage("assets/images/enetcom_logo.png"),
//               //height: 60.0,
//               width: 180.0,
//               alignment: FractionalOffset.center),
//           centerTitle: false,
//         ),
//         body: Form(
//           child: ListView(
//             shrinkWrap: true,
//             children: <Widget>[
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 5.0),
//                 margin: const EdgeInsets.symmetric(
//                     horizontal: 20.0, vertical: 10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Edit course's title",
//                       style: TextStyle(
//                         color: Palette.adminBg,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 28,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () async {
//                         String name = titleController.text;

//                         Course course1 = Course(
//                             id: course!.id,
//                             name: name,
//                             subjectId: course!.subjectId,
//                             pdfUrl: course!.pdfUrl,
//                             attachmentId: course!.attachmentId,
//                             createdTime: course!.createdTime);

//                         titleController.text = '';
//                         setState(() {
//                           course = course1;
//                           HttpCourseService.updateCourse(course!.id, course1);
//                           // userController.currentUserClasseSubjectCourses
//                           //     .add(course1);
//                           //courseController.fetchCourses();
//                           userController.getUserClasseSubjectCourses();
//                         });

//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         "Save",
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 5.0),
//                 margin: const EdgeInsets.symmetric(
//                     horizontal: 20.0, vertical: 10.0),
//                 child: TextFormField(
//                   keyboardType: TextInputType.name,
//                   style: textStyle,
//                   controller: titleController..text = course!.name,
//                   validator: (value) {
//                     if (value == null) {
//                       return "Please enter Subject name";
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     labelText: '  Course name',
//                     hintText: 'Enter the course name',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void openFile(PlatformFile file) {
//     OpenFile.open(file.path!);
//   }
// }
