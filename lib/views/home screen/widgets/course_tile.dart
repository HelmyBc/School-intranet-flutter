import 'package:enetcom_app/controllers/user_controller.dart';
import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/models/course.dart';
import 'package:enetcom_app/services/http_course_service.dart';
import 'package:enetcom_app/views/for_teachers/edit_course_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class CourseTile extends StatelessWidget {
  //String title;
  Course course;

  CourseTile({
    Key? key,
    required this.course,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    DateTime createdTime = DateTime.parse(course.createdTime);

    final difference = DateTime.now().difference(createdTime);
    final dateTime = DateTime.now().subtract(difference);
    final timeAgo = timeago.format(dateTime);

    void showActions() {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Select An Option'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Edit title'),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             EditCourseScreen(course: course)));
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Delete'),
              onPressed: () {
                HttpCourseService.deleteCourse(course.id);
                userController.getUserClasseSubjectCourses();
                const snackBar =
                    SnackBar(content: Text("Course deleted succefully!"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => const PDF().cachedFromUrl(
              course.pdfUrl,
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),
          ),
        );
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
            userController.currentUserTypeInt.value == 1
                ? IconButton(
                    onPressed: () {
                      showActions();
                    },
                    icon: const Icon(Icons.more_vert),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
