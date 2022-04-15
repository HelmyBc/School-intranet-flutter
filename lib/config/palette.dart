import 'package:flutter/material.dart';

class Palette {
  // static const Color scaffold = Color(0xFFF0F2F5);
  static const Color scaffold = Color(0xFFECE9E9);
  static const darkScaffold = Color(0xFF1c1c1c);
  static const mainWhite = Color(0xffffffff);
  static const mainBlack = Color(0xff262626);
  static const mainGrey = Color(0xff505050);

  static const Color facebookBlue = Color(0xFF1777F2);

  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);
  static const Color kPrimaryColor = Color(0xFF6F35A5);
  static const Color kPrimaryLightColor = Color(0xFFF1E6FF);

  static const scaffolDark = Color.fromRGBO(0, 0, 0, 1);
  static const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
  static const mobileSearchColor = Color.fromRGBO(38, 38, 38, 1);
  static const blueColor = Color.fromRGBO(0, 149, 246, 1);
  static const primaryColor = Colors.white;
  static const secondaryColor = Colors.grey;
  static const adminBg =Color.fromRGBO(0, 49, 83, 1);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );


static Image enetcomLogo = const Image(
image: ExactAssetImage("assets/images/enetcom_logo.png"),
height: 28.0,
width: 20.0,
alignment: FractionalOffset.center);
}