import 'package:enetcom_app/config/palette.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.moon_stars;
  return AppBar(
    title: const Text(
      'My Profile',
      style: TextStyle(
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.2,
      ),
    ),
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    leading: GestureDetector(
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: 30.0,
        color: Colors.black,
        onPressed: () {},
      ),
    ),
    elevation: 0,
    backgroundColor: Palette.mainWhite,
    actions: [
      IconButton(
          onPressed: null,
          icon: Icon(
            icon,
            color: Palette.darkScaffold,
          ))
    ],
  );
}
