import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/post_controller.dart';
import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/services/http_post_service.dart';
import 'package:enetcom_app/services/http_student_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final minimumPadding = 5.0;

  final PostController postController = Get.put(PostController());

  TextEditingController descriptionController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController profImageController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  //TextEditingController imageController = TextEditingController();

  Post? post;

  @override
  void dispose() {
    descriptionController.dispose();
    uidController.dispose();
    usernameController.dispose();
    profImageController.dispose();
    //imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Create post',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Palette.adminBg,
          elevation: 0.0,
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(Icons.done),
          //   ),
          // ],
        ),
        body: Form(
          child: Padding(
            padding: EdgeInsets.all(minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: minimumPadding),
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: const Text(
                    "Add a new post",
                    style: TextStyle(
                      color: Palette.adminBg,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    style: textStyle,
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter your full name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'description',
                      hintText: 'description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: uidController,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter your CIN";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'UID',
                      hintText: 'Enter your UID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    style: textStyle,
                    controller: usernameController,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'username',
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    style: textStyle,
                    controller: profImageController,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter your phone number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'profImage',
                        hintText: 'profImage',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    style: textStyle,
                    controller: imageUrlController,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter your phone number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'imageUrl',
                        hintText: 'imageUrl',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: minimumPadding),
                //   child: TextFormField(
                //     keyboardType: TextInputType.url,
                //     style: textStyle,
                //     controller: imageController,
                //     validator: (value) {
                //       if (value == null) {
                //         return "Please enter your photo URL";
                //       }
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //         labelText: 'Photo URL',
                //         hintText: 'Enter your photo URL',
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(5.0),
                //         )),
                //   ),
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                  child: const Text('Submit'),
                  onPressed: () async {
                    String description = descriptionController.text;
                    int uid = int.parse(uidController.text);
                    String username = usernameController.text;
                    String profImage = profImageController.text;
                    String imageUrl = imageUrlController.text;

                    Post posts = await HttpPostService.addPost(
                      description,
                      username,
                      uid,
                      imageUrl,
                      profImage,
                    );
                    descriptionController.text = '';
                    uidController.text = '';
                    usernameController.text = '';
                    profImageController.text = '';
                    imageUrlController.text = '';
                    //imageController.text = '';
                    setState(() {
                      post = posts;
                      Navigator.pop(context);
                      postController.fetchPosts();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final List<Widget> actions;
  const MyAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title!,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: actions,
      content: Text(
        content!,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
