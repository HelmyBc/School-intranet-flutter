
import 'package:enetcom_app/models/student.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  final Student student;
  const StudentTile(this.student);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    student.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              student.name,
              maxLines: 2,
              style: const TextStyle(
                  fontFamily: 'avenir', fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              '${student.cin}',
              style: const TextStyle(fontSize: 32, fontFamily: 'avenir'),
            ),
            const SizedBox(height: 8),
            Text(
              '${student.email}',
              style: const TextStyle(fontSize: 32, fontFamily: 'avenir'),
            ),
            const SizedBox(height: 8),
            Text(
              '${student.phone}',
              style: const TextStyle(fontSize: 32, fontFamily: 'avenir'),
            ),
          ],
        ),
      ),
    );
  }
}
