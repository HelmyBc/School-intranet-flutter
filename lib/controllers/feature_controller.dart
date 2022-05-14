import 'package:enetcom_app/models/feature.dart';
import 'package:enetcom_app/services/http_feature_service.dart';
import 'package:get/get.dart';

class FeatureController extends GetxController {
  var isLoading = false.obs;
  var current = 0.obs;
  var featureList = <Feature>[].obs;

  @override
  void onInit() {
    fetchFeatures();
    super.onInit();
  }

  void fetchFeatures() async {
    try {
      isLoading(true);
      var features = await HttpFeatureService.fetchFeatures();
      if (features != []) {
        featureList.value = features;
      }
    } finally {
      isLoading(false);
      update();
      print('feature fetch done');
    }
  }
}
