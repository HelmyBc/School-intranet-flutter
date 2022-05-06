import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/services/http_subject_service.dart';
import 'package:get/state_manager.dart';

class SubjectController extends GetxController {
  var isLoading = true.obs;
  var subjectList = <Subject>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingSubject = <Subject>[].obs;

  @override
  void onInit() {
    fetchSubjects();
    super.onInit();
  }

  void fetchSubjects() async {
    try {
      isLoading(true);
      var subjects = await HttpSubjectService.fetchSubjects();
      if (subjects != null) {
        subjectList.value = subjects;
      }
    } finally {
      isLoading(false);
    }
  }
}
