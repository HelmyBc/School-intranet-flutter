import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/services/http_post_service.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  var isLoading = true.obs;
  var postList = <Post>[].obs;
  //this list MUST HAVE ONLY ONE ELEMENT
  var editingPost = <Post>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var posts = await HttpPostService.fetchPosts();
      if (posts != null) {
        postList.value = posts;
      }
    } finally {
      isLoading(false);
    }
  }
}
