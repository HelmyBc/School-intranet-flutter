import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/services/http_service.dart';
import 'package:get/state_manager.dart';

class StudentController extends GetxController {
  var isLoading = true.obs;
  var studentList = <Student>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingStudent = <Student>[].obs;

  @override
  void onInit() {
    fetchStudents();
    super.onInit();
  }

  // void addStudent(int id) {
  //   final int index = studentList.indexWhere((student) => student.id == id);
  //   studentList[index].inWishList.value = true;
  // }

  void fetchStudents() async {
    try {
      isLoading(true);
      var students = await HttpService.fetchStudents();
      if (students != null) {
        studentList.value = students;
      }
    } finally {
      isLoading(false);
    }
  }

  // void deleteStudent(Student student) {
  //   studentList.remove(student);
  //   HttpService.deleteStudent(student.id);
  // }

  //  // Remove an item from the wish list
  // void removeItem(int id) async {
  //   final int index = _items.indexWhere((item) => item.id == id);
  //   _items[index].inWishList.value = false;
  // }
}
