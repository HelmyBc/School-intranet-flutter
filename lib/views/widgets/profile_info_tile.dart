import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:enetcom_app/models/user.dart';
import 'package:get/get.dart';

class ProfileInfoTile extends StatelessWidget {
  final ClasseController classeController = Get.put(ClasseController());
  final UserController userController = Get.put(UserController());
  User user;
  ProfileInfoTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  // final Student student;
  // const ProfileInfoTile({required this.student});
  // List<String> generateClasseNames() {
  //   return classeController.classeList
  //       .map(
  //         (classe) => classe.name,
  //       )
  //       .toList();
  // }

  List<String> generateClasseNames() {
    print("names");
    return classeController.classeList.value
        .where((classe) => user.classesId!.contains(classe.id))
        .map(
          (classe) => classe.name,
        )
        .toList();
  }

  String generateClasseName() {
    print("name");
    return classeController.classeList.value
        .where((classe) => user.classeId == classe.id)
        .map(
          (classe) => classe.name,
        )
        .toList()
        .first;
  }

  @override
  Widget build(BuildContext context) {
    classeController.fetchClasses();
    // List<String> classesNames = generateClasseNames();
    // String classeName = generateClasseName();
    return Container(
      margin: const EdgeInsets.all(10),
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Full Name",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Divider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [
            //     Text(
            //       "Date of Birth",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w800,
            //       ),
            //     ),
            //     Text(
            //       "04 Jan 1999",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //   ],
            // ),
            // const Divider(),
            userController.currentUser.value.userType == "Teacher"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Classes",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        generateClasseNames().toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Class",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        generateClasseName(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "${user.email}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "${user.phone}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
