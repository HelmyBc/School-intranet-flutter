import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/feature_controller.dart';
import 'package:enetcom_app/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FeatureCarousel extends StatefulWidget {
  @override
  State<FeatureCarousel> createState() => _FeatureCarouselState();
}

class _FeatureCarouselState extends State<FeatureCarousel> {
  FeatureController featureController = Get.put(FeatureController());
  int _current = 0;
  List<Widget> generateImagesTiles() {
    return featureController.featureList
        .map(
          (feature) => ClipRRect(
              child: CachedNetworkImage(
                imageUrl: feature.imageUrl,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
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
            return buildSheet(featureController.featureList[_current]);
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
                    featureController.featureList[_current].title,
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

  Widget buildSheet(Feature feature) {
    DateTime createdTime = DateTime.parse(feature.createdTime);
    final difference = DateTime.now().difference(createdTime);
    final dateTime = DateTime.now().subtract(difference);
    final timeAgo = timeago.format(dateTime);

    final date = DateFormat.yMd().add_jm().format(createdTime);

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
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: Stack(
                    children: [
                      // Image.network(feature.imageUrl),
                      CachedNetworkImage(
                        imageUrl: feature.imageUrl,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 5,
                        right: -50,
                        child: Container(
                          margin: const EdgeInsets.only(right: 40.0),
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
                          padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feature.title,
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
                              Text(
                                timeAgo,
                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54.withOpacity(0.9),
                                      offset: const Offset(1, 1),
                                      blurRadius: 12,
                                    ),
                                  ],
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Published at: $date",
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      const Divider(thickness: 2.0,),
                      const SizedBox(height: 8.0),
                      Text(
                        feature.description,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
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
