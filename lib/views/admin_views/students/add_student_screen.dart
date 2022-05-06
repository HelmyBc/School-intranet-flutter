import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/controllers/student_controller.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/services/http_student_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final minimumPadding = 5.0;
  String? depValue;
  int selectedDepId = 0;
  String? classeValue;
  int selectedClasseId = 0;
  final StudentController studentController = Get.put(StudentController());
  final ClasseController classeController = Get.put(ClasseController());
  final DepartmentController departmentController =
      Get.put(DepartmentController());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController depIdController = TextEditingController();
  TextEditingController classeIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Student? student;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    cinController.dispose();
    depIdController.dispose();
    classeIdController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    departmentController.fetchDepartments();
    classeController.fetchClasses();
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

    List<String> generateClassesNames() {
      return classeController.classeList
          .map(
            (classe) => classe.name,
          )
          .toList();
    }

    List<String> departmentNames = generateDepartmentNames();
    List<String> classeNames = generateClassesNames();
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
                    "Add a new student",
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
                        return "Please enter your Last name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last name',
                      hintText: 'Enter your Last name',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: minimumPadding),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: minimumPadding),
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
                              value: classeValue,
                              iconSize: 36,
                              isExpanded: true,
                              items:
                                  classeNames.map(buildMenuItem).toList(),
                              onChanged: (value) {
                                setState(() {
                                  classeValue = value;
                                  selectedClasseId = generateClasseId();
                                  print(selectedClasseId);
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
                          ..text = selectedClasseId.toString(),
                        validator: (value) {
                          if (value == null) {
                            return "Please enter the classe id";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'classId',
                          hintText: 'Enter the department classId',
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                  child: const Text('Submit'),
                  onPressed: () async {
                    String firstName = firstNameController.text;
                    String lastName = lastNameController.text;
                    int cin = int.parse(cinController.text);
                    int depId = selectedDepId;
                    int classeId = selectedClasseId;
                    String email = emailController.text;
                    String password = cinController.text;
                    int phone = int.parse(phoneController.text);

                    String imageUrl =
                        "https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg";
                    // String imageUrl = imageController.text;
                    Student students = await HttpStudentService.addStudent(
                      firstName,
                      lastName,
                      email,
                      password,
                      cin,
                      phone,
                      imageUrl,
                      classeId,
                      depId,
                    );
                    firstNameController.text = '';
                    lastNameController.text = '';
                    cinController.text = '';
                    emailController.text = '';
                    phoneController.text = '';
                    setState(() {
                      student = students;
                      Navigator.pop(context);
                      studentController.fetchStudents();
                    });
                  },
                ),
              ],
            ),
          ),
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

  int generateClasseId() {
    return selectedClasseId = classeController.classeList
        .where((classe) => classe.name == classeValue)
        .map(
          (classe) => classe.id,
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
