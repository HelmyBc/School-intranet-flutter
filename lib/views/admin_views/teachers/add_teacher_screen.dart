import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:enetcom_app/services/http_teacher_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({Key? key}) : super(key: key);

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final minimumPadding = 5.0;
  bool value = false;

  final TeacherController teacherController = Get.put(TeacherController());

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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      style: textStyle,
                      controller: depIdController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter your depId ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'depId',
                          hintText: 'Enter your first depId',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
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
                      int depId = int.parse(depIdController.text);
                      //String imageUrl = imageController.text;
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
}
