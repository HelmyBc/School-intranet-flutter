import 'package:enetcom_app/controllers/feature_controller.dart';
import 'package:enetcom_app/services/http_feature_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:enetcom_app/models/feature.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeatureContainer extends StatelessWidget {final Feature feature;
  const FeatureContainer({
    Key? key,
    required this.feature,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.only(top: 8.0),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _FeatureHeader(feature: feature),
                const SizedBox(height: 4.0),
                Text(feature.description),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20.0)),
              child: Image(
                image: NetworkImage(feature.imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureHeader extends StatelessWidget {
  final Feature feature;

  const _FeatureHeader({
    Key? key,
    required this.feature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime createdTime = DateTime.parse(feature.createdTime);

    final difference = DateTime.now().difference(createdTime);
    final dateTime = DateTime.now().subtract(difference);
    final timeAgo = timeago.format(dateTime);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feature.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '$timeAgo • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          // ignore: avoid_print
          onPressed: () => showActions(context),
        ),
      ],
    );
  }

  void showActions(BuildContext context) {
    FeatureController featureController = Get.put(FeatureController());
    showCupertinoModalPopup(
      barrierColor: Colors.black26.withOpacity(0.5),
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select An Option'),
        actions: <Widget>[
          // CupertinoActionSheetAction(
          //   child: const Text('Edit description'),
          //   onPressed: () {
          //     Navigator.pop(context, 'Edit description');
          //     featureController.editingPost.clear();
          //     featureController.editingPost.add(post);

          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => EditFeatureScreen(
          //                 feature: feature,
          //               )),
          //     );
          //   },
          // ),
          CupertinoActionSheetAction(
            child: const Text('delete post'),
            onPressed: () {
              Navigator.pop(context, 'delete post');
              HttpFeatureService.deleteFeature(feature.id);
              featureController.fetchFeatures();
              const snackBar =
                  SnackBar(content: Text("Feature removed succefully!"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          ),
        ],
      ),
    );
  }
}
