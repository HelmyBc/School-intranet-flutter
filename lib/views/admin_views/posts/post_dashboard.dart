import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/post_controller.dart';
import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/views/admin_views/posts/create_post_screen.dart';
import 'package:enetcom_app/views/admin_views/students/add_student_screen.dart';
import 'package:enetcom_app/views/admin_views/widgets/student_card.dart';
import 'package:enetcom_app/views/admin_views/widgets/new_post_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDashboard extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  PostDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        brightness: Brightness.light,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            iconSize: 28.0,
            onPressed: () {
              postController.fetchPosts();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 28.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreatePostScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => loadData(),
        child: Column(
          children: [
            Obx(() {
              return Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  child: Text(
                    'Posts (${postController.postList.length})',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(
                () {
                  if (postController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final Post post = postController.postList[index];
                        return NewPostContainer(post: post);
                      },
                      itemCount: postController.postList.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future loadData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    postController.fetchPosts();
  }
}
