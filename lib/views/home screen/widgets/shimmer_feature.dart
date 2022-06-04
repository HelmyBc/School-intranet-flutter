// import 'package:enetcom_app/views/widgets/shimmer_widget.dart';
import 'package:enetcom_app/views/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class ShimmerFeature extends StatelessWidget {
  const ShimmerFeature({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: ShimmerWidget.rectangular(
        height: height,
        width: width,
        raduis: 20,
      ),
    );
  }
}
