import 'dart:convert';
import 'dart:io';

import 'package:avatar_view/avatar_view.dart';
import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/attachment.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/services/http_user_service.dart';
import 'package:enetcom_app/views/teacher_root_app.dart';

import 'package:enetcom_app/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

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
                child: Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.cover,
                  alignment: FractionalOffset.topCenter,
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

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return
        //  GestureDetector(
        //   onTap: () {
        //     FocusManager.instance.primaryFocus?.unfocus();
        //   },
        //   child:
        Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
        leading: GestureDetector(
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TeacherRootApp(),
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Palette.mainWhite,
        actions: [
          CircleButton(
            icon: Icons.done,
            iconColor: Palette.mainBlack,
            toScreen: const TeacherRootApp(),
          )
        ],
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickImage,
              child: Center(
                child: Stack(
                  children: [
                    _imageFile == null
                        ? AvatarView(
                            radius: 64,
                            borderColor: Colors.grey,
                            avatarType: AvatarType.CIRCLE,
                            backgroundColor: Colors.red,
                            imagePath:
                                userController.currentUser.value.imageUrl!,
                            placeHolder: const Icon(
                              Icons.person,
                              size: 18,
                            ),
                            errorWidget: const Icon(
                              Icons.error,
                              size: 18,
                            ),
                          )
                        : AvatarView(
                            radius: 64,
                            borderColor: Colors.grey,
                            avatarType: AvatarType.CIRCLE,
                            backgroundColor: Colors.red,
                            imagePath: imageUrl,
                            placeHolder: const Icon(
                              Icons.person,
                              size: 18,
                            ),
                            errorWidget: const Icon(
                              Icons.error,
                              size: 18,
                            ),
                          ),
                    Positioned(
                      bottom: 0.0,
                      right: 4.0,
                      child: ClipOval(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(3.0),
                          child: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.blue,
                              child: const Icon(
                                Icons.edit,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                style: textStyle,
                controller: firstNameController
                  ..text = userController.currentUser.value.firstName!,
                validator: (value) {
                  if (value == null) {
                    return "Please enter your first name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'First name',
                  hintText: 'Enter your first name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                style: textStyle,
                controller: lastNameController
                  ..text = userController.currentUser.value.firstName!,
                validator: (value) {
                  if (value == null) {
                    return "Please enter your last name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Last name',
                  hintText: 'Enter your last name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: Palette.facebookBlue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () async {
                  String firstName = firstNameController.text;
                  String lastName = lastNameController.text;
                  String password = userController.currentUser.value.password;

                  User updatedUser = User(
                    cin: userController.currentUser.value.cin,
                    id: userController.currentUser.value.id,
                    firstName: firstName,
                    lastName: lastName,
                    email: userController.currentUser.value.email,
                    password: password,
                    imageUrl: userController.currentUser.value.imageUrl,
                    phone: userController.currentUser.value.phone,
                    chefDep: userController.currentUser.value.chefDep,
                    classeId: userController.currentUser.value.classeId,
                    depId: userController.currentUser.value.depId,
                    classesId: userController.currentUser.value.classesId,
                    postsId: userController.currentUser.value.postsId,
                    subjectsId: userController.currentUser.value.subjectsId,
                  );
                  await HttpUserService.updateUser(
                      userController.currentUser.value.id!, updatedUser);
                  firstNameController.text = '';
                  lastNameController.text = '';
                  userController.fetchUsers();
                  setState(() {
                    const snackBar =
                        SnackBar(content: Text("Profile updated succefully!"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Save changes",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
