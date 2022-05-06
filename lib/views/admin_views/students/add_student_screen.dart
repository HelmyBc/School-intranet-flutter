import 'package:enetcom_app/config/palette.dart';
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

  final StudentController studentController = Get.put(StudentController());

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
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: depIdController,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter your depId";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'depId',
                      hintText: 'Enter your depId',
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
                    controller: classeIdController,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter your classeId";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'classeId',
                      hintText: 'Enter your classeId',
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                  child: const Text('Submit'),
                  onPressed: () async {
                    String firstName = firstNameController.text;
                    String lastName = lastNameController.text;
                    int cin = int.parse(cinController.text);
                    int depId = int.parse(depIdController.text);
                    int classeId = int.parse(classeIdController.text);
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
