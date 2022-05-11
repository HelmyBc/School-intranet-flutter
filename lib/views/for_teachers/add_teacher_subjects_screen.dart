// import 'package:enetcom_app/config/palette.dart';
// import 'package:enetcom_app/controllers/subject_controller.dart';
// import 'package:enetcom_app/controllers/user_controller.dart';
// import 'package:enetcom_app/models/teacher.dart';
// import 'package:enetcom_app/models/user.dart';
// import 'package:enetcom_app/services/http_teacher_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:multiselect/multiselect.dart';

// class AddTeacherSubjectsScreen extends StatefulWidget {
//   AddTeacherSubjectsScreen({Key? key}) : super(key: key);

//   @override
//   State<AddTeacherSubjectsScreen> createState() =>
//       _AddTeacherSubjectsScreenState();
// }

// class _AddTeacherSubjectsScreenState extends State<AddTeacherSubjectsScreen> {
//   final SubjectController subjectController = Get.put(SubjectController());
//   final UserController userController = Get.put(UserController());

//   User currentUser = User(email: "", password: "");

//   List<String> selectedSubjects = [];
//   List<int> selectedSubjectIds = [];

//   @override
//   Widget build(BuildContext context) {
//     User currentUser = userController.currentUser.value;
//     subjectController.fetchSubjects();
//     List<String> generateSubjectsNames() {
//       return subjectController.subjectList
//           .map(
//             (subject) => subject.name,
//           )
//           .toList();
//     }

//     List<int> generateSubjectIds() {
//       return subjectController.subjectList
//           .where((subject) => selectedSubjects.contains(subject.name))
//           .map(
//             (subject) => subject.id,
//           )
//           .toList();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         backgroundColor: Palette.scaffold,
//         title: const Image(
//             image: ExactAssetImage("assets/images/enetcom_logo.png"),
//             //height: 60.0,
//             width: 180.0,
//             alignment: FractionalOffset.center),
//         centerTitle: false,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(28.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Align(
//                 child: Text(
//                   "Update my subjects I teach",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 alignment: Alignment.topLeft,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: DropDownMultiSelect(
//                   whenEmpty: 'Select the Subjects you teach',
//                   options: generateSubjectsNames(),
//                   selectedValues: selectedSubjects,
//                   onChanged: (List<String> x) {
//                     setState(() {
//                       selectedSubjects = x;
//                       selectedSubjectIds = generateSubjectIds();
//                     });
//                   },
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {Teacher updatedteacher = Teacher(
//                         id: currentUser.id,
//                         cin: currentUser.cin,
//                         firstName: currentUser.firstName,
//                         lastName: currentUser.lastName,
//                         email: currentUser.email,
//                         password: currentUser.password,
//                         phone: currentUser.phone,
//                         imageUrl: currentUser.imageUrl,
//                         chefDep: currentUser.chefDep,
//                         depId: currentUser.depId,
//                         classesId: currentUser.classesId,
//                         subjectsId: selectedSubjectIds,
                        
//                       );
//                        HttpTeacherService.updateTeacher(
//                           currentUser.id!, updatedteacher);
                      
//                       userController.fetchUsers();
//                       setState(() {
//                         const snackBar = SnackBar(
//                             content: Text("Teacher subjects updated succefully!"));
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                         Navigator.pop(context);
//                       });},
//                 child: const Text("Update my subjects"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
