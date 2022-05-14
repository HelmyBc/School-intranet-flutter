import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/views/widgets/category_box.dart';
import 'package:flutter/material.dart';

class StudentCategoryList extends StatefulWidget {
  const StudentCategoryList({Key? key}) : super(key: key);

  @override
  State<StudentCategoryList> createState() => _StudentCategoryListState();
}

class _StudentCategoryListState extends State<StudentCategoryList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          student_categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CategoryBox(
              selectedColor: Colors.white,
              data: student_categories[index],
              onTap: () {
                getScreen(context, student_categories[index]["screen"]);
              },
            ),
          ),
        ),
      ),
    );
  }

  getScreen(BuildContext context, data) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => data),
    );
  }
}
