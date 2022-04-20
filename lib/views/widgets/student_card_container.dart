import 'package:enetcom_app/models/student.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class StudentCardContainer extends StatelessWidget {
  final Student student;
  const StudentCardContainer({required this.student});

  @override
  Widget build(BuildContext context) {
    void showActions() {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context, 'One');
            },
          ),
          title: const Text('Select An Option'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('One'),
              onPressed: () {
                Navigator.pop(context, 'One');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Two'),
              onPressed: () {
                Navigator.pop(context, 'Two');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Three'),
              onPressed: () {
                Navigator.pop(context, 'Three');
              },
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatar(imageUrl: student.imageUrl),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: Colors.grey[600],
                      size: 12.0,
                    ),
                    Text(
                      ' • ${student.email} ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Cin: ${student.cin}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "phone: ${student.phone}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "email: ${student.email}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            // ignore: avoid_print
            onPressed: () => showActions(),
          ),
        ],
      ),
    );
  }
}
