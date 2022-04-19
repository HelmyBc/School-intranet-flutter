import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:enetcom_app/services/http_service.dart';
import 'package:flutter/material.dart';

class AddTeacherScreen extends StatefulWidget {
  AddTeacherScreen({Key? key}) : super(key: key);

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final minimumPadding = 5.0;
  bool value = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //TextEditingController imageController = TextEditingController();

  Teacher? teacher;

  @override
  void dispose() {
    nameController.dispose();
    cinController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
                      controller: nameController,
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
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: minimumPadding),
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.url,
                  //     style: textStyle,
                  //     controller: imageController,
                  //     validator: (value) {
                  //       if (value == null) {
                  //         return "Please enter your photo URL";
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //         labelText: 'Photo URL',
                  //         hintText: 'Enter your photo URL',
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(5.0),
                  //         )),
                  //   ),
                  // ),
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
                      String name = nameController.text;
                      int cin = int.parse(cinController.text);
                      String email = emailController.text;
                      int phone = int.parse(phoneController.text);
                      //String imageUrl = imageController.text;
                      String imageUrl =
                          "https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg";
                      bool chefDep = value;
                      Teacher teachers = await HttpService.addTeacher(
                          name, email, cin, phone, imageUrl, chefDep);
                      nameController.text = '';
                      cinController.text = '';
                      emailController.text = '';
                      phoneController.text = '';
                      //imageController.text = '';
                      setState(() {
                        teacher = teachers;
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
