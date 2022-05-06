import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/classe_controller.dart';
import 'package:enetcom_app/controllers/department_controller.dart';
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/services/http_classe_service.dart';
import 'package:enetcom_app/services/http_department_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateClasseScreen extends StatefulWidget {
  @override
  State<UpdateClasseScreen> createState() => _UpdateClasseScreenState();
}

class _UpdateClasseScreenState extends State<UpdateClasseScreen> {
  final minimumPadding = 5.0;

  TextEditingController nameController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController depIdController = TextEditingController();
  TextEditingController groupeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    levelController.dispose();
    depIdController.dispose();
    groupeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    final ClasseController classeController = Get.put(ClasseController());
    Classe classe = classeController.editingClasse[0];
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
                      // "Update the student ${student!.name}",
                      "Update Classe",
                      style: TextStyle(
                        color: Palette.adminBg,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Text(
                    classe.name,
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
                      controller: nameController..text = classe.name,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter the Classe name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Classe name',
                        hintText: 'Enter the Classe name',
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
                      controller: levelController..text = "${classe.level}",
                      validator: (value) {
                        if (value == null) {
                          return "Please enter Classe level";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Short name',
                        hintText: 'Enter the department level',
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
                      controller: groupeController..text = "${classe.groupe}",
                      validator: (value) {
                        if (value == null) {
                          return "Please enter Classe groupe";
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: depIdController..text = "${classe.depId}",
                      validator: (value) {
                        if (value == null) {
                          return "Please enter Classe depId";
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Palette.adminBg),
                    child: const Text('Submit'),
                    onPressed: () async {
                      String name = nameController.text;
                      int level = int.parse(levelController.text);
                      int depId = int.parse(depIdController.text);
                      int groupe = int.parse(groupeController.text);

                      Classe updatedClasse = Classe(
                        id: classe.id,
                        level: level,
                        groupe: groupe,
                        depId: depId,
                        name: name,
                      );
                      await HttpClasseService.updateClasse(
                          classe.id, updatedClasse);
                      nameController.text = '';
                      levelController.text = '';
                      depIdController.text = '';
                      groupeController.text = '';

                      classeController.fetchClasses();
                      setState(() {
                        const snackBar = SnackBar(
                            content: Text("Classe updated succefully!"));
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
