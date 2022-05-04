import 'dart:io';

import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController descriptionController = TextEditingController();
  PickedFile? _imageFile;
  final String uploadUrl = 'http://192.168.56.1:9191/api/upload/';
  final ImagePicker _picker = ImagePicker();

  Future<String> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', filepath));
    var res = await request.send();
    return res.reasonPhrase as String;
  }

  Future<void> retriveLostData() async {
    final LostData response = await _picker.getLostData();
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
      return
          //child: Image.file(File(_imageFile!.path)),
          ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
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
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
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
              //TODO CREATE A POST SERVICE
              onPressed: () async {
                var res = await uploadImage(_imageFile!.path, uploadUrl);
                print(res);
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
                        const SizedBox(height: 10.0),
                        // _file != null
                        //     ? ClipRRect(
                        //         borderRadius: const BorderRadius.all(
                        //             Radius.circular(30.0)),
                        //         child: Stack(
                        //           children: [
                        //             Container(
                        //               padding: const EdgeInsets.symmetric(
                        //                   vertical: 8.0),
                        //               // height: 45.0,
                        //               // width: 45.0,
                        //               child: AspectRatio(
                        //                 aspectRatio: 487 / 451,
                        //                 child: Container(
                        //                   decoration: BoxDecoration(
                        //                       image: DecorationImage(
                        //                     fit: BoxFit.cover,
                        //                     alignment:
                        //                         FractionalOffset.topCenter,
                        //                     image: MemoryImage(_file!),
                        //                   )),
                        //                 ),
                        //               ),
                        //             ),
                        //             Positioned(
                        //               top: 5,
                        //               right: -20,
                        //               child: Container(
                        //                 margin: const EdgeInsets.all(10.0),
                        //                 child: MaterialButton(
                        //                   shape: const CircleBorder(),
                        //                   color:
                        //                       Colors.black54.withOpacity(0.4),
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   onPressed: () {
                        //                     clearImage();
                        //                   },
                        //                   child: const Icon(
                        //                     Icons.close,
                        //                     color: Colors.white,
                        //                     size: 20.0,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     : const SizedBox.shrink(),

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

        floatingActionButton: FloatingActionButton(
          onPressed: _pickImage,
          tooltip: 'Pick Image from gallery',
          child: Icon(Icons.photo_library),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
