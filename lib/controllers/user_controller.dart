import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/services/http_user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var currentUser = <User>[].obs;
  var currentUserType = "".obs;
  var userList = <User>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingUser = <User>[].obs;

  @override
  void onInit() {
    fetchUsers();
    loadCurrentUser();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      var users = await HttpUserService.fetchUsers();
      if (users != null) {
        userList.value = users;
      }
    } finally {
      isLoading(false);
    }
  }

  void loadCurrentUser() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var cuid = prefs.getInt('cuid');
      User currentUser = await HttpUserService.getUser(cuid!);
      this.currentUser.add(currentUser);
    } catch (Excepetion) {
      print(
          "An error while loading current user from shared pref has occured: $Excepetion");

      isLoading(false);
    }
  }
}
