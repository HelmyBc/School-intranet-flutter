import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/views/admin_views/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class UsersScreen extends StatelessWidget {
  // final GlobalKey<RefreshIndicatorState> _refreshIndacatorKey =
  //     GlobalKey<RefreshIndicatorState>();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            // letterSpacing: -1.2,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async => loadData(),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Container(
            //   padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            //   child: Rooms(onlineUsers: onlineUsers),
            // ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (userController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final User user = userController.userList[index];
                      return UserCard(user: user);
                    },
                    itemCount: userController.userList.length,
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future loadData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    userController.fetchUsers();
  }
}
