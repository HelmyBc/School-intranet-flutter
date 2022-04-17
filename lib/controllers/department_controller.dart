import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/services/http_service.dart';
import 'package:get/state_manager.dart';

class DepartmentController extends GetxController {
  var isLoading = true.obs;
  var departmentList = <Department>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingDepartment = <Department>[].obs;

  @override
  void onInit() {
    fetchDepartments();
    super.onInit();
  }

  void fetchDepartments() async {
    try {
      isLoading(true);
      var departments = await HttpService.fetchDepartments();
      if (departments != null) {
        departmentList.value = departments;
      }
    } finally {
      isLoading(false);
    }
  }
}
