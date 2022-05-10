import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/controllers/subject_controller.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/services/http_subject_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({Key? key}) : super(key: key);

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final minimumPadding = 5.0;
  String? value;
  int selectedId = 0;
  // List<String> selectedDepartments = [];
  // List<int> selectedDepartmentIds = [];

  final SubjectController subjectController = Get.put(SubjectController());
  final ClasseController classeController = Get.put(ClasseController());
  // final DepartmentController departmentController =
  //     Get.put(DepartmentController());

  TextEditingController nameController = TextEditingController();
  TextEditingController teacherNameController = TextEditingController();
  TextEditingController classeIdController = TextEditingController();

  Subject? subject;

  @override
  void dispose() {
    nameController.dispose();
    teacherNameController.dispose();
    classeIdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    classeController.fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    classeController.fetchClasses();

    List<String> generateClasseNames() {
      return classeController.classeList
          .map(
            (classe) => classe.name,
          )
          .toList();
    }

    int generateClasseId() {
      return selectedId = classeController.classeList
          .where((classe) => classe.name == value)
          .map(
            (dep) => dep.id,
          )
          .first;
    }

    // List<int> generateClasseIds() {
    //   return departmentController.departmentList
    //       .where((dep) => selectedDepartments.contains(dep.shortName))
    //       .map(
    //         (dep) => dep.id,
    //       )
    //       .toList();
    // }
 List<String> classeNames = generateClasseNames();
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      style: textStyle,
                      controller: teacherNameController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter Teacher full name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Teacher full name',
                        hintText: 'Enter the Teacher full name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: minimumPadding),
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.number,
                  //     style: textStyle,
                  //     controller: classeIdController,
                  //     validator: (value) {
                  //       if (value == null) {
                  //         return "Please enter classe Id";
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //       labelText: 'Classe id',
                  //       hintText: 'Enter the Classe id',
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: minimumPadding),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.grey, width: 1.5)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text("Select a class"),
                                value: value,
                                iconSize: 36,
                                isExpanded: true,
                                items:
                                    classeNames.map(buildMenuItem).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    this.value = value;
                                    this.selectedId = generateClasseId();
                                    print(selectedId);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 80.0,
                        margin: const EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.symmetric(vertical: minimumPadding),
                        child: TextFormField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: classeIdController
                            ..text = selectedId.toString(),
                          validator: (value) {
                            if (value == null) {
                              return "Please enter the classe Id";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'classeId',
                            hintText: 'Enter the classeId',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                    child: const Text('Submit'),
                    onPressed: () async {
                      String name = nameController.text;
                      String teacherName = teacherNameController.text;
                      int classeId = int.parse(classeIdController.text);

                      Subject subjects = await HttpSubjectService.addSubject(
                        name,
                        teacherName,
                        classeId,
                      );
                      nameController.text = '';
                      teacherNameController.text = '';
                      classeIdController.text = '';
                      setState(() {
                        subject = subjects;
                        Navigator.pop(context);
                        subjectController.fetchSubjects();
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
}
