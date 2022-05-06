import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/services/http_classe_service.dart';
import 'package:get/state_manager.dart';

class ClasseController extends GetxController {
  var isLoading = true.obs;
  var classeList = <Classe>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingClasse = <Classe>[].obs;

  @override
  void onInit() {
    fetchClasses();
    super.onInit();
  }

  void fetchClasses() async {
    try {
      isLoading(true);
      var classes = await HttpClasseService.fetchClasses();
      if (classes != null) {
        classeList.value = classes;
      }
    } finally {
      isLoading(false);
    }
  }
}
