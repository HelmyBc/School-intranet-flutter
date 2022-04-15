import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/models/models.dart';
import 'package:enetcom_app/views/current_profile_screen.dart';
import 'package:enetcom_app/views/root_app.dart';

import 'package:enetcom_app/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User user = currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
        leading: GestureDetector(
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RootApp(),
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Palette.mainWhite,
        actions: [
          CircleButton(
            icon: Icons.done,
            iconColor: Palette.mainBlack,
            toScreen: const RootApp(),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileImage(
            imageUrl: user.imageUrl,
            onClicked: () async {},
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFieldWidget(
            label: 'Nom et prénom',
            text: user.name,
            onChanged: (name) {},
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFieldWidget(
            label: 'Université',
            text: user.university,
            onChanged: (university) {},
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            decoration: BoxDecoration(
              color: Palette.facebookBlue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CurrentProfileScreen())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Save changes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
