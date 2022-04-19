import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/teacher_controller.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:enetcom_app/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateTeacherScreen extends StatefulWidget {
  const UpdateTeacherScreen({Key? key}) : super(key: key);

  @override
  State<UpdateTeacherScreen> createState() => _UpdateTeacherScreenState();
}

class _UpdateTeacherScreenState extends State<UpdateTeacherScreen> {
  final minimumPadding = 5.0;
  bool value = false;

  TextEditingController nameController = TextEditingController();

  TextEditingController cinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cinController.dispose();
    emailController.dispose();
    phoneController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    final TeacherController teacherController = Get.put(TeacherController());
    Teacher teacher = teacherController.editingTeacher[0];
    value = teacher.chefDep;
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
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.done),
            ),
          ],
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
                      // "Update the teacher ${teacher!.name}",
                      "Update teacher",
                      style: TextStyle(
                        color: Palette.adminBg,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Text(
                    teacher.name,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      style: textStyle,
                      controller: nameController..text = "${teacher.name}",
                      validator: (value) {
                        if (value == null) {
                          return "Please enter your full name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Full name',
                        hintText: 'Enter your full name',
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
                      controller: cinController..text = "${teacher.cin}",
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
                      controller: emailController..text = "${teacher.email}",
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
                      controller: phoneController..text = "${teacher.phone}",
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
                      keyboardType: TextInputType.url,
                      style: textStyle,
                      controller: imageController..text = "${teacher.imageUrl}",
                      validator: (value) {
                        if (value == null) {
                          return "Please enter your photo URL";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Photo URL',
                          hintText: 'Enter your photo URL',
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
                    style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                    child: const Text('Submit'),
                    onPressed: () async {
                      String name = nameController.text;
                      int cin = int.parse(cinController.text);
                      String email = emailController.text;
                      int phone = int.parse(phoneController.text);
                      String imageUrl = imageController.text;
                      Teacher updatedteacher = Teacher(
                        teacherId: teacher.teacherId,
                        cin: cin,
                        name: name,
                        email: email,
                        phone: phone,
                        imageUrl: imageUrl,
                        chefDep: value,
                      );
                      await HttpService.updateTeacher(
                          teacher.teacherId, updatedteacher);
                      nameController.text = '';
                      cinController.text = '';
                      emailController.text = '';
                      phoneController.text = '';
                      imageController.text = '';
                      teacherController.fetchTeachers();
                      setState(() {
                        const snackBar = SnackBar(
                            content: Text("Teacher updated succefully!"));
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
