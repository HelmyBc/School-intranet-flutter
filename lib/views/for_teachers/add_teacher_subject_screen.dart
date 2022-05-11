import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/subject_controller.dart';
import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/services/http_subject_service.dart';

class AddTeacherSubjectsScreen extends StatefulWidget {
  int classeId;
  AddTeacherSubjectsScreen({
    Key? key,
    required this.classeId,
  }) : super(key: key);

  @override
  State<AddTeacherSubjectsScreen> createState() =>
      _AddTeacherSubjectsScreenState();
}

class _AddTeacherSubjectsScreenState extends State<AddTeacherSubjectsScreen> {
  final minimumPadding = 5.0;

  //final SubjectController subjectController = Get.put(SubjectController());
  final ClasseController classeController = Get.put(ClasseController());
  UserController userController = Get.put(UserController());

  TextEditingController nameController = TextEditingController();

  Subject? subject;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    classeController.fetchClasses();
    userController.onInit();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.scaffold,
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
          child: Padding(
              padding: EdgeInsets.all(minimumPadding * 2),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: minimumPadding),
                    padding: EdgeInsets.only(
                        top: minimumPadding, bottom: minimumPadding),
                    child: const Text(
                      "Add a new Subject",
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
                      controller: nameController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter Subject name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Subject name',
                        hintText: 'Enter the Subject name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                    child: const Text('Submit'),
                    onPressed: () async {
                      String name = nameController.text;
                      String teacherName =
                          "${userController.currentUser.value.firstName} ${userController.currentUser.value.lastName}";
                      int classeId = widget.classeId;
                      int teacherId = userController.currentUser.value.id!;

                      Subject subjects = await HttpSubjectService.addSubject(
                        name,
                        teacherName,
                        classeId,
                        teacherId,
                      );
                      nameController.text = '';
                      setState(() {
                        subject = subjects;
                        Navigator.pop(context);
                        userController.onInit();
                        //subjectController.fetchSubjects();
                      });
                    },
                  ),
                ],
              )),
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
}
