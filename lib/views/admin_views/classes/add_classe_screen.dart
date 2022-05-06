import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/services/http_classe_service.dart';
import 'package:enetcom_app/services/http_department_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddClasseScreen extends StatefulWidget {
  const AddClasseScreen({Key? key}) : super(key: key);

  @override
  State<AddClasseScreen> createState() => _AddClasseScreenState();
}

class _AddClasseScreenState extends State<AddClasseScreen> {
  final minimumPadding = 5.0;
  String? value;
  int selectedId = 0;
  final ClasseController classeController = Get.put(ClasseController());
  final DepartmentController departmentController =
      Get.put(DepartmentController());

  TextEditingController nameController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController depIdController = TextEditingController();
  TextEditingController groupeController = TextEditingController();

  Classe? classe;

  @override
  void dispose() {
    nameController.dispose();
    levelController.dispose();
    depIdController.dispose();
    groupeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    departmentController.fetchDepartments();
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

    List<String> departmentNames = generateDepartmentNames();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Admin Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Palette.adminBg,
          elevation: 0.0,
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
                      "Add a new classe",
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
                          return "Please enter classe name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'classe name',
                        hintText: 'Enter the classe name',
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
                          return "Please enter the department level";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'level',
                        hintText: 'Enter the department level',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
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
                                hint: const Text("Select a department"),
                                value: value,
                                iconSize: 36,
                                isExpanded: true,
                                items:
                                    departmentNames.map(buildMenuItem).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    this.value = value;
                                    this.selectedId = generateDepartmentId();
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
                          controller: depIdController
                            ..text = selectedId.toString(),
                          validator: (value) {
                            if (value == null) {
                              return "Please enter the department depId";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'depId',
                            hintText: 'Enter the department depId',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: groupeController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter the department groupe";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'groupe',
                        hintText: 'Enter the department groupe',
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
                      int level = int.parse(levelController.text);
                      int depId = selectedId;
                      int groupe = int.parse(groupeController.text);

                      Classe classes = await HttpClasseService.addClasse(
                        level,
                        groupe,
                        depId,
                        name,
                      );
                      nameController.text = '';
                      groupeController.text = '';
                      depIdController.text = '';
                      levelController.text = '';
                      setState(() {
                        classe = classes;
                        Navigator.pop(context);
                        classeController.fetchClasses();
                      });
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }

  int generateDepartmentId() {
    return selectedId = departmentController.departmentList
        .where((dep) => dep.shortName == value)
        .map(
          (dep) => dep.id,
        )
        .first;
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
