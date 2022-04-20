import 'package:enetcom_app/models/teacher.dart';
import 'package:enetcom_app/services/http_teacher_service.dart';
import 'package:get/state_manager.dart';

class TeacherController extends GetxController {
  var isLoading = true.obs;
  var teacherList = <Teacher>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingTeacher = <Teacher>[].obs;

  @override
  void onInit() {
    fetchTeachers();
    super.onInit();
  }

  void fetchTeachers() async {
    try {
      isLoading(true);
      var teachers = await HttpTeacherService.fetchTeachers();
      if (teachers != null) {
        teacherList.value = teachers;
      }
    } finally {
      isLoading(false);
    }
  }
}
