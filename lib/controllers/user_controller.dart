import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/services/http_user_service.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var currentUser = null.obs as User;
  var currentUserType = "".obs;
  var userList = <User>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingUser = <User>[].obs;

  @override
  void onInit() {
    fetchUsers();
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
}
