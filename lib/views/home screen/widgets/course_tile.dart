import 'package:enetcom_app/models/course.dart';
import 'package:enetcom_app/views/for_teachers/subject_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
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
    DateTime createdTime = DateTime.parse(course.createdTime);

    final difference = DateTime.now().difference(createdTime);
    final dateTime = DateTime.now().subtract(difference);
    final timeAgo = timeago.format(dateTime);
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
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
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
                children: [
                  Text(
                    course.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    timeAgo,
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
