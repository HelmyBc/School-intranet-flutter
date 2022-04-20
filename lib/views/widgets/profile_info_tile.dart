import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({Key? key}) : super(key: key);

  // final Student student;
  // const ProfileInfoTile({required this.student});

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Full Name",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "Helmy Bouchiha",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Date of Birth",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "04 Jan 1999",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Class",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "2 Gii 2",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "helmibouchiha@enetcom.u-sfax.tn",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Phone",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "25252424",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
