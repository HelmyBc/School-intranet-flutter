import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:enetcom_app/services/http_teacher_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({Key? key}) : super(key: key);

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final minimumPadding = 5.0;
  bool value = false;
  String? depValue;
  int selectedDepId = 0;
  List<String> selectedClasses = [];
  List<int> selectedClasseIds = [];

  final TeacherController teacherController = Get.put(TeacherController());
  final ClasseController classeController = Get.put(ClasseController());
  final DepartmentController departmentController =
      Get.put(DepartmentController());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController depIdController = TextEditingController();

  Teacher? teacher;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    cinController.dispose();
    emailController.dispose();
    phoneController.dispose();
    depIdController.dispose();
    //imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    departmentController.fetchDepartments();
    classeController.fetchClasses();

    List<String> generateDepartmentNames() {
      return departmentController.departmentList
          .map(
            (dep) => dep.shortName,
          )
          .toList();
    }

    List<String> departmentNames = generateDepartmentNames();

    List<String> generateClasseNames() {
      return classeController.classeList
          .map(
            (classe) => classe.name,
          )
          .toList();
    }

    List<String> classesNames = generateDepartmentNames();

    
    List<int> generateClasseIds() {
      return classeController.classeList
          .where((classe) => selectedClasses.contains(classe.name))
          .map(
            (classe) => classe.id,
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
                      "Add a new teacher",
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
                      controller: firstNameController,
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      style: textStyle,
                      controller: lastNameController,
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: cinController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter your CIN";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'CIN',
                        hintText: 'Enter your CIN',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: textStyle,
                      controller: emailController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      style: textStyle,
                      controller: phoneController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter your phone number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Phone number',
                          hintText: 'Enter your first phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
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
                                value: depValue,
                                iconSize: 36,
                                isExpanded: true,
                                items:
                                    departmentNames.map(buildMenuItem).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    depValue = value;
                                    selectedDepId = generateDepartmentId();
                                    print(selectedDepId);
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
                            ..text = selectedDepId.toString(),
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
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: Palette.adminBg,
                          value: value,
                          onChanged: (value) => setState(() {
                            this.value = value!;
                          }),
                        ),
                        const Text("Department boss ?")
                      ],
                    ),
                  ),
                  DropDownMultiSelect(
                    whenEmpty: 'Select teacher classes',
                    options: generateClasseNames(),
                    selectedValues: selectedClasses,
                    onChanged: (List<String> x) {
                      setState(() {
                        selectedClasses = x;
                        selectedClasseIds = generateClasseIds();
                        print(selectedClasseIds.toString());
                      });
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                    onPressed: () async {
                      String firstName = firstNameController.text;
                      String lastName = lastNameController.text;
                      int cin = int.parse(cinController.text);
                      String password = cinController.text;
                      String email = emailController.text;
                      int phone = int.parse(phoneController.text);
                      int depId = selectedDepId;
                      String imageUrl =
                          "https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg";
                      bool chefDep = value;
                      Teacher teachers = await HttpTeacherService.addTeacher(
                        firstName,
                        lastName,
                        email,
                        password,
                        cin,
                        phone,
                        depId,
                        imageUrl,
                        chefDep,
                        selectedClasseIds,
                        [],
                      );
                      firstNameController.text = '';
                      lastNameController.text = '';
                      cinController.text = '';
                      emailController.text = '';
                      phoneController.text = '';
                      depIdController.text = '';
                      //imageController.text = '';
                      setState(() {
                        teacher = teachers;
                        Navigator.pop(context);
                        teacherController.fetchTeachers();
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
    return selectedDepId = departmentController.departmentList
        .where((dep) => dep.shortName == depValue)
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
