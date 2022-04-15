import 'package:enetcom_app/components/text_field_container.dart';
import 'package:enetcom_app/config/palette.dart';
import 'package:flutter/material.dart';


class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Palette.kPrimaryColor,
        decoration: const InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Palette.kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Palette.kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
