import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/controllers/subject_controller.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/services/http_Subject_service.dart';
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
  List<String> selectedDepartments = [];
  List<int> selectedDepartmentIds = [];

  final SubjectController subjectController = Get.put(SubjectController());
  final DepartmentController departmentController =
      Get.put(DepartmentController());

  TextEditingController nameController = TextEditingController();
  TextEditingController levelController = TextEditingController();

  Subject? subject;

  @override
  void dispose() {
    nameController.dispose();
    levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    departmentController.fetchDepartments();

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
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: levelController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter Subject level";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Subject level',
                        hintText: 'Enter the Subject level',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  DropDownMultiSelect(
                    whenEmpty: 'Select subject departments',
                    options: generateDepartmentNames(),
                    selectedValues: selectedDepartments,
                    onChanged: (List<String> x) {
                      setState(() {
                        selectedDepartments = x;
                        selectedDepartmentIds = generateDepartmentIds();
                      });
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                    child: const Text('Submit'),
                    onPressed: () async {
                      String name = nameController.text;
                      List? depIds = selectedDepartmentIds;
                      int level = int.parse(levelController.text);

                      Subject subjects = await HttpSubjectService.addSubject(
                        name,
                        level,
                        depIds,
                      );
                      nameController.text = '';
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
