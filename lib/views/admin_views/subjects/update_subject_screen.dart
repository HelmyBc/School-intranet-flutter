import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/controllers/subject_controller.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/services/http_subject_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

class UpdateSubjectScreen extends StatefulWidget {
  @override
  State<UpdateSubjectScreen> createState() => _UpdateSubjectScreenState();
}

class _UpdateSubjectScreenState extends State<UpdateSubjectScreen> {
  final minimumPadding = 5.0;
  List<String> selectedDepartments = [];
  List<int> selectedDepartmentIds = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController teacherIdController = TextEditingController();
  TextEditingController classeIdController = TextEditingController();
  final SubjectController subjectController = Get.put(SubjectController());
  final DepartmentController departmentController =
      Get.put(DepartmentController());

  @override
  void dispose() {
    nameController.dispose();
    teacherIdController.dispose();
    classeIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    departmentController.fetchDepartments();
    Subject subject = subjectController.editingSubject[0];

    List<String> generateDepartmentNames() {
      return departmentController.departmentList
          .map(
            (dep) => dep.shortName,
          )
          .toList();
    }

    List<int> generateDepartmentIds() {
      return departmentController.departmentList
          .where((dep) => selectedDepartments.contains(dep.shortName))
          .map(
            (dep) => dep.id,
          )
          .toList();
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                      // "Update the student ${student!.name}",
                      "Update Subject",
                      style: TextStyle(
                        color: Palette.adminBg,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Text(
                    subject.name,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      style: textStyle,
                      controller: nameController..text = subject.name,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter the Subject name";
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: teacherIdController
                        ..text = subject.teacherId.toString(),
                      validator: (value) {
                        if (value == null) {
                          return "Please enter the teacher id";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Teacher id',
                        hintText: 'Enter the teacher id',
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
                      controller: classeIdController
                        ..text = subject.classeId.toString(),
                      validator: (value) {
                        if (value == null) {
                          return "Please enter the classe id";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'classe id',
                        hintText: 'Enter the classe id',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  // DropDownMultiSelect(
                  //   whenEmpty: 'Select subject departments',
                  //   options: generateDepartmentNames(),
                  //   selectedValues: selectedDepartments,
                  //   onChanged: (List<String> x) {
                  //     setState(() {
                  //       selectedDepartments = x;
                  //       selectedDepartmentIds = generateDepartmentIds();
                  //     });
                  //   },
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                    child: const Text('Submit'),
                    onPressed: () async {
                      String name = nameController.text;
                     
                      int classeId = int.parse(classeIdController.text);
                      int teacherId = int.parse(teacherIdController.text);

                      Subject updatedSubject = Subject(
                        id: subject.id,
                        classeId: classeId,
                        teacherId: teacherId,
                        name: name,
                        teacherName: subject.teacherName,
                        coursesIds: subject.coursesIds,
                        tdsIds: subject.tdsIds,
                      );
                      await HttpSubjectService.updateSubject(
                          subject.id, updatedSubject);
                      nameController.text = '';
                      classeIdController.text = '';

                      subjectController.fetchSubjects();
                      setState(() {
                        const snackBar = SnackBar(
                            content: Text("Subject updated succefully!"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              )),
        ),
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
