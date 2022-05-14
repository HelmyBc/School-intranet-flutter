import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  String text;
  EmptyContent({
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
        dashPattern: const [10, 10],
        color: Colors.blue.shade800,
        strokeWidth: 2,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.93,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.redAccent.withOpacity(0.1),
          ),
          child: Center(
            child: Column(
              children: [
                const Image(
                    image: ExactAssetImage("assets/images/empty_folder.png"),
                    //height: 60.0,
                    width: 200.0,
                    alignment: FractionalOffset.center),
                const SizedBox(height: 15.0),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
