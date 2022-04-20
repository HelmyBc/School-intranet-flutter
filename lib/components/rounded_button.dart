import 'package:enetcom_app/config/palette.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = Palette.kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () => press,
          style: ElevatedButton.styleFrom(
            primary: Palette.kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

}
