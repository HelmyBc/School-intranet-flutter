import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/services/http_department_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDepartmentScreen extends StatefulWidget {
  const AddDepartmentScreen({Key? key}) : super(key: key);

  @override
  State<AddDepartmentScreen> createState() => _AddDepartmentScreenState();
}

class _AddDepartmentScreenState extends State<AddDepartmentScreen> {
  final minimumPadding = 5.0;

  final DepartmentController departmentController =
      Get.put(DepartmentController());

  TextEditingController nameController = TextEditingController();
  TextEditingController shortNameController = TextEditingController();

  Department? department;

  @override
  void dispose() {
    nameController.dispose();
    shortNameController.dispose();
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
                      "Add a new department",
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
                          return "Please enter department name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Department name',
                        hintText: 'Enter the department name',
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
                      controller: shortNameController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter the department short name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Short name',
                        hintText: 'Enter the department short name',
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
                      String shortName = shortNameController.text;

                      Department departments =
                          await HttpDepartmentService.addDepartment(
                        name,
                        shortName,
                      );
                      nameController.text = '';
                      shortNameController.text = '';
                      setState(() {
                        department = departments;
                        Navigator.pop(context);
                        departmentController.fetchDepartments();
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
}
