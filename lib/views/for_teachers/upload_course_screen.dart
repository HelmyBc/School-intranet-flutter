import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:enetcom_app/views/home%20screen/widgets/course_tile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/course_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/attachment.dart';
import 'package:enetcom_app/models/course.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/services/http_course_service.dart';

class UploadCourseScreen extends StatefulWidget {
  Subject subject;
  UploadCourseScreen({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  State<UploadCourseScreen> createState() => _UploadCourseScreenState();
}

class _UploadCourseScreenState extends State<UploadCourseScreen> {
  final UserController userController = Get.put(UserController());
  final CourseController courseController = Get.put(CourseController());
  TextEditingController titleController = TextEditingController();

  Course? course;
  PlatformFile? _pdfFile;
  String pdfUrl = "";
  int pdfId = 0;
  final String uploadUrl = 'http://192.168.56.1:9191/api/upload/';

  Future<Attachment> uploadPdf(filepath, url) async {
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

  void _pickPdf() async {
    try {
      final pickedFile = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (pickedFile == null) return;

      //open single pdf
      PlatformFile file = pickedFile.files.first;
      setState(() {
        _pdfFile = file;
      });
      //openFile(file);
      print("Name:  ${file.name}");
      print("Bytes:  ${file.bytes}");
      print("Size:  ${file.size}");
      print("Extension:  ${file.extension}");
      print("Path:  ${file.path}");
    } catch (e) {
      print("Image picker error ");
    }
  }

  void clearPdf() {
    setState(() {
      _pdfFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Palette.scaffold,
          title: const Image(
              image: ExactAssetImage("assets/images/enetcom_logo.png"),
              //height: 60.0,
              width: 180.0,
              alignment: FractionalOffset.center),
          centerTitle: false,
        ),
        body: Form(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add a new course",
                      style: TextStyle(
                        color: Palette.adminBg,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_pdfFile != null && titleController.text != "") {
                          Attachment attachment =
                              await uploadPdf(_pdfFile!.path, uploadUrl);
                          pdfUrl =
                              "http://192.168.56.1:9191/api/download/${attachment.id}";
                          pdfId = attachment.id;
                          String name = titleController.text;
                          Course course1 = await HttpCourseService.addCourse(
                            name,
                            widget.subject.id,
                            pdfId,
                            pdfUrl,
                          );
                          titleController.text = '';
                          setState(() {
                            course = course1;
                            // userController.currentUserClasseSubjectCourses
                            //     .add(course1);
                            //courseController.fetchCourses();
                            userController.getUserClasseSubjectCourses();
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  style: textStyle,
                  controller: titleController,
                  validator: (value) {
                    if (value == null) {
                      return "Please enter Subject name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: '  Course name',
                    hintText: 'Enter the course name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              _pdfFile == null
                  ? GestureDetector(
                      onTap: () {
                        _pickPdf();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: DottedBorder(
                          padding: const EdgeInsets.all(0),
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          dashPattern: const [10, 10],
                          color: Colors.blue.shade800,
                          strokeWidth: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.93,
                            padding: const EdgeInsets.all(40.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.lightBlue.withOpacity(0.3),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    CupertinoIcons.share,
                                    color: Colors.blue[800],
                                    size: 30,
                                  ),
                                  const SizedBox(height: 15.0),
                                  const Text(
                                    "Tap here to upload a PDF",
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
                  : Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 7.0),
                      padding: const EdgeInsets.all(10.0),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Image(
                            image: ExactAssetImage("assets/images/pdf.png"),
                            //height: 60.0,
                            width: 80.0,
                            alignment: FractionalOffset.center,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _pdfFile!.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              clearPdf();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}
