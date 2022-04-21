import 'package:enetcom_app/controllers/post_controller.dart';
import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/services/http_post_service.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final PostController postController = Get.put(PostController());
    //Post post = postController.editingPost[0];
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
          title: const Text("New post"),
          actions: [
            TextButton(
              onPressed: () async {
                // String description = descriptionController.text;
                // Post updatedPost = Post(
                //   id: post.id,
                //   description: description,
                //   createdTime: post.createdTime,
                //   imageUrl: post.imageUrl,
                //   profImage: post.profImage,
                //   uid: post.uid,
                //   username: post.username,
                // );
                // await HttpPostService.updatePost(post.id, updatedPost);
                // descriptionController.text = '';

                // postController.fetchPosts();
                // setState(() {
                //   Navigator.pop(context);
                //   const snackBar =
                //       SnackBar(content: Text("Post updated succefully!"));
                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // });
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.blue, fontSize: 18.0),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),

              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20.0),
              //   color: Colors.white,
              //   boxShadow: const [
              //     BoxShadow(
              //       color: Colors.black12,
              //       offset: Offset(0.0, 2.0),
              //       blurRadius: 6.0,
              //     ),
              //   ],
              // ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            ProfileAvatar(imageUrl: currentUser.imageUrl),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentUser.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Public • ',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      Icon(
                                        Icons.public,
                                        color: Colors.grey[600],
                                        size: 12.0,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.0),
                        TextFormField(
                          minLines: 3,
                          maxLines: 7,
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: "Hey, what's on your mind?",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                        ),
                        //Text(widget.post.description),
                        const SizedBox(height: 18.0),

                        TextButton.icon(
                            // ignore: avoid_print
                            onPressed: () {
                              print("Photo");
                            },
                            icon: const Icon(
                              Icons.photo_library,
                              color: Colors.green,
                            ),
                            label: const Text("Add photo",
                                style: TextStyle(color: Colors.black))),

                        //  != null
                        //     ? const SizedBox.shrink()
                        //     : const SizedBox(height: 6.0),
                      ],
                    ),
                  ),
                  // ignore: unnecessary_null_comparison
                  // if (post.imageUrl != '')
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //     child: Image(
                  //       image: NetworkImage(currentUser.imageUrl),
                  //     ),
                  //   )
                  // else
                  //   const SizedBox.shrink(),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
