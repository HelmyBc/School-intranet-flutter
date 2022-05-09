import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/services/http_user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var currentUser = User(email: "", password: "").obs;
  var currentUserType = "".obs;
  var currentUserId = 0.obs;
  var userList = <User>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingUser = <User>[].obs;

  @override
  void onInit() {
    fetchUsers();
    loadCurrentUser();
    getCurrentUser();
    super.onInit();
  }

  void getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser.value = await HttpUserService.getUser(prefs.getInt('cuid')!);
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
      if (cuid != null) {
        User currentUser = await HttpUserService.getUser(cuid);
        //this.currentUser.add(currentUser);
        currentUserId.value = cuid;
      } else {
        cuid = 0;
        prefs.setInt('cuid', 0);
        currentUserId.value = 0;
      }
    } catch (Excepetion) {
      print(
          "An error while loading current user from shared pref has occured: $Excepetion");
      isLoading(false);
    }
  }
}
