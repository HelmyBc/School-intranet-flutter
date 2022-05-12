import 'package:dotted_border/dotted_border.dart';
import 'package:enetcom_app/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadCourseScreen extends StatelessWidget {
  const UploadCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Palette.scaffold,
        title: const Image(
            image: ExactAssetImage("assets/images/enetcom_logo.png"),
            //height: 60.0,
            width: 180.0,
            alignment: FractionalOffset.center),
        centerTitle: false,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                      const Text(
                        "Tap here to upload a PDF",
                        style: TextStyle(
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
          )
        ],
      ),
    );
  }
}
