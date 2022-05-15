import 'package:flutter/material.dart';

Widget buildMenuItemBox(
  BuildContext context,
  String title,
  String imageUrl,
) {
  return Stack(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: 80,
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
        child: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      Positioned(
        left: 8,
        top: 8,
        child: Image(
          height: 60,
          image: AssetImage(imageUrl),
        ),
      ),
    ],
  );
}
