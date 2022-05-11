import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadBox extends StatelessWidget {
  String text;
  UploadBox({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: DottedBorder(
        padding: const EdgeInsets.all(0),
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        dashPattern: [10, 10],
        color: Colors.blue.shade800,
        strokeWidth: 2,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.93,
          padding: const EdgeInsets.all(40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.lightBlue.withOpacity(0.3),
          ),
          child: Center(
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.share,
                  color: Colors.blue[800],
                  size: 30,
                ),
                const SizedBox(height: 15.0),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  "Browse",
                  style: TextStyle(
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
