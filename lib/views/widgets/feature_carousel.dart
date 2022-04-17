import 'package:carousel_slider/carousel_slider.dart';
import 'package:enetcom_app/config/palette.dart';
import 'package:flutter/material.dart';

class FeatureCarousel extends StatefulWidget {
  FeatureCarousel({Key? key}) : super(key: key);

  @override
  State<FeatureCarousel> createState() => _FeatureCarouselState();
}

class _FeatureCarouselState extends State<FeatureCarousel> {
  int _current = 0;

  final List<String> images = [
    'assets/images/cisco.jpg',
    'assets/images/huawei.png',
    'assets/images/elections.jpeg',
    'assets/images/office.png',
  ];

  final List<String> titles = [
    'Cisco voucher',
    'Huawei voucher',
    'Election',
    'OFFICE 365',
  ];

  List<Widget> generateImagesTiles() {
    return images
        .map(
          (element) => ClipRRect(
              child: Image.asset(
                element,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0)),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Palette.scaffold,
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return buildSheet();
          },
        ),
        child: Stack(
          children: [
            CarouselSlider(
              items: generateImagesTiles(),
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 3 / 2,
                  onPageChanged: (index, other) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    titles[_current],
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.9),
                          offset: const Offset(1, 1),
                          blurRadius: 12,
                        ),
                      ],
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeDismissible({required Widget child}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(onTap: () {}, child: child),
    );
  }

  Widget buildSheet() {
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0))),
            child: ListView(
              controller: scrollController,
              children: [
                Stack(
                  children: [
                    Image.asset('assets/images/office.png'),
                    Positioned(
                      right: -50,
                      child: Container(
                        margin: EdgeInsets.only(right: 40.0),
                        child: MaterialButton(
                          shape: const CircleBorder(),
                          color: Colors.black54.withOpacity(0.4),
                          padding: const EdgeInsets.all(8.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Text(
                          "OFFICE 365",
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.9),
                                offset: const Offset(1, 1),
                                blurRadius: 12,
                              ),
                            ],
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'We want to say congratulations' +
                        ' for the students selected to win a cisco certification' +
                        ' voucher, after having good scores in their exams,' +
                        ' you will get more training before passing the exam',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            // controller: scrollController,
          );
        },
      ),
    );
  }
}
