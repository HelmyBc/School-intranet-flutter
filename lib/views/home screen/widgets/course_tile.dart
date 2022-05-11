import 'package:enetcom_app/models/course.dart';
import 'package:enetcom_app/views/for_teachers/subject_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:enetcom_app/models/subject.dart';

class CourseTile extends StatelessWidget {
  //String title;
  Course course;

  CourseTile({
    Key? key,
    required this.course,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => SubjectScreen(
        //               subject: subject,
        //             )));
      },
      child: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            const Image(
              image: ExactAssetImage("assets/images/pdf.png"),
              //height: 60.0,
              width: 80.0,
              alignment: FractionalOffset.center,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Chapitre 1 intelligence arrtificielle partie 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Published 2 days ago',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
