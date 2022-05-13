import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:enetcom_app/controllers/post_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/models/attachment.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/services/http_post_service.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final PostController postController = Get.put(PostController());
  final UserController userController = Get.put(UserController());

  TextEditingController descriptionController = TextEditingController();
  Post? post;
  XFile? _imageFile;
  String imageUrl = "";
  int imageId = 0;
  final String uploadUrl = 'http://192.168.56.1:9191/api/upload/';
  final ImagePicker _picker = ImagePicker();

  Future<Attachment> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', filepath));
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    Map responseMap = jsonDecode(response.body);
    Attachment attachment =
        Attachment.fromJson(responseMap as Map<String, dynamic>);
    // imageUrl = "http://192.168.56.1:9191/api/download/${attachment.id}";
    print(response.body);
    return attachment;
  }

  Future<void> retriveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file!;
      });
    } else {
      print('Retrieve error ' + response.exception!.code);
    }
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              // height: 45.0,
              // width: 45.0,
              child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                  child: Image.file(
                    File(_imageFile!.path),
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: -20,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: MaterialButton(
                  shape: const CircleBorder(),
                  color: Colors.black54.withOpacity(0.4),
                  padding: const EdgeInsets.all(8.0),
                  onPressed: () {
                    clearImage();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      setState(() {
        _imageFile = pickedFile!;
      });
    } catch (e) {
      print("Image picker error ");
    }
  }

  void clearImage() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();
    // usernameController.dispose();
    // profImageController.dispose();
    // uidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("New post"),
          actions: [
            TextButton(
              onPressed: () async {
                if (_imageFile != null) {
                  Attachment attachment =
                      await uploadImage(_imageFile!.path, uploadUrl);
                  if (_imageFile != null) {
                    imageUrl =
                        "http://192.168.56.1:9191/api/download/${attachment.id}";
                    imageId = attachment.id;
                  } else {
                    imageUrl = "";
                    imageId = 0;
                  }
                  String description = descriptionController.text;
                  int uid = userController.currentUser.value.id!;
                  String username =
                      "${userController.currentUser.value.firstName} ${userController.currentUser.value.lastName}";
                  String profImage = userController.currentUser.value.imageUrl!;

                  Post posts = await HttpPostService.addPost(
                    description,
                    username,
                    uid,
                    imageUrl,
                    imageId,
                    profImage,
                  );
                  descriptionController.text = '';
                  // uidController.text = '';
                  // usernameController.text = '';
                  // profImageController.text = '';
                  setState(() {
                    post = posts;
                    Navigator.pop(context);
                    postController.fetchPosts();
                  });
                } else {
                  String description = descriptionController.text;
                  int uid = userController.currentUser.value.id!;
                  String username =
                      "${userController.currentUser.value.firstName} ${userController.currentUser.value.lastName}";
                  String profImage = userController.currentUser.value.imageUrl!;
                  String imageUrl = "";
                  int imageId = 0;

                  Post posts = await HttpPostService.addPost(
                    description,
                    username,
                    uid,
                    imageUrl,
                    imageId,
                    profImage,
                  );
                  descriptionController.text = '';
                  setState(() {
                    post = posts;
                    Navigator.pop(context);
                    postController.fetchPosts();
                  });
                }
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.blue, fontSize: 18.0),
              ),
            )
          ],
        ),
        body: ListView(
          //physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Form(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 20.0),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  ProfileAvatar(
                                      imageUrl: userController
                                          .currentUser.value.imageUrl!),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${userController.currentUser.value.firstName} ${userController.currentUser.value.lastName}",
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
                              const SizedBox(height: 10.0),
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
                              const SizedBox(height: 10.0),

                              Center(
                                child: FutureBuilder<void>(
                                  future: retriveLostData(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<void> snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
                                        return const Text('Picked an image');
                                      case ConnectionState.done:
                                        return _previewImage();
                                      default:
                                        return const Text('Picked an image');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _imageFile == null
                ? GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: DottedBorder(
                        padding: const EdgeInsets.all(0),
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        dashPattern: const [10, 10],
                        color: Colors.blue.shade800,
                        strokeWidth: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: const EdgeInsets.all(40.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.lightBlue.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  CupertinoIcons.photo,
                                  color: Colors.blue[800],
                                  size: 30,
                                ),
                                const SizedBox(height: 15.0),
                                const Text(
                                  "A post with an image looks more attractive",
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                Text(
                                  "Browse",
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                :const SizedBox(),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: _pickImage,
          tooltip: 'Pick Image from gallery',
          child: const Icon(Icons.photo_library),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
