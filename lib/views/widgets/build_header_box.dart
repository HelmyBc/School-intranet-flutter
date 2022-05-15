import 'package:flutter/material.dart';

Widget buildHeaderBox(
  BuildContext context,
  String title1,
  String title2,
  String title3,
  String imageUrl,
) {
  return Stack(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.93,
        height: 170,
        margin: const EdgeInsets.fromLTRB(10, 20, 20, 20),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromRGBO(0, 31, 100, 1),
              Color.fromRGBO(4, 76, 144, 0.9),
            ],
          ),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.green,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Text(
                title1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title3,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        right: -38,
        top: -23,
        child: Image(
          height: 220,
          image: AssetImage(imageUrl),
        ),
      ),
    ],
  );
}
