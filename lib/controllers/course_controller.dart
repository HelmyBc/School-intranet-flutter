import 'package:enetcom_app/models/course.dart';
import 'package:enetcom_app/services/http_course_service.dart';
import 'package:get/state_manager.dart';

class CourseController extends GetxController {
  var isLoading = true.obs;
  var courseList = <Course>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingCourse = <Course>[].obs;

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  void fetchCourses() async {
    try {
      isLoading(true);
      var courses = await HttpCourseService.fetchCourses();
      if (courses != null) {
        courseList.value = courses;
      }
    } finally {
      isLoading(false);
    }
  }
}
