import 'package:enetcom_app/models/feature.dart';
import 'package:enetcom_app/services/http_feature_service.dart';
import 'package:get/get.dart';

class FeatureController extends GetxController {
  var isLoading = true.obs;
  var current = 0.obs;
  var featureList = <Feature>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingFeature = <Feature>[].obs;

  @override
  void onInit() {
    fetchFeatures();
    super.onInit();
  }

  void fetchFeatures() async {
    try {
      isLoading(true);
      var posts = await HttpFeatureService.fetchFeatures();
      if (posts != null) {
        featureList.value = posts;
      }
    } finally {
      isLoading(false);
    }
  }
}
