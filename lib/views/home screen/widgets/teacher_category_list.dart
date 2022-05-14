import 'package:enetcom_app/data/data.dart';
import 'package:enetcom_app/views/widgets/category_box.dart';
import 'package:flutter/material.dart';

class TeacherCategoryList extends StatefulWidget {
  const TeacherCategoryList({Key? key}) : super(key: key);

  @override
  State<TeacherCategoryList> createState() => _TeacherCategoryListState();
}

class _TeacherCategoryListState extends State<TeacherCategoryList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          teacher_categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CategoryBox(
              selectedColor: Colors.white,
              data: teacher_categories[index],
              onTap: () {
                getScreen(context, teacher_categories[index]["screen"]);
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
