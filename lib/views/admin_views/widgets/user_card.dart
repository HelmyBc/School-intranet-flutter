import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/services/http_user_service.dart';
import 'package:enetcom_app/views/profile_screen.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCard extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  User user;
  UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProfileScreen(
                      selectedUser: user,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 1),
              Color.fromRGBO(171, 196, 255, 0.5),
              // Color.fromRGBO(215, 227, 252, 1),
              // Color.fromRGBO(171, 196, 255, 0.5),
            ],
          ),
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
            ProfileAvatar(imageUrl: user.imageUrl as String),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Email: ${user.email} ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "Cin: ${user.cin}",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "phone: ${user.phone}",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "email: ${user.email}",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // userController.editingUser.clear();
                // userController.editingUser.add(user);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => UpdateuserScreen()),
                // );
              },
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 25,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent[400],
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                HttpUserService.deleteUser(user.id as int);
                userController.fetchUsers();
                const snackBar =
                    SnackBar(content: Text("user removed succefully!"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 25,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
