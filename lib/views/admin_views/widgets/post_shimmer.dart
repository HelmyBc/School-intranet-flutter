// import 'package:enetcom_app/views/widgets/shimmer_widget.dart';
import 'package:enetcom_app/views/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                const _PostHeader(),
                const SizedBox(height: 4.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.9,
                      raduis: 6,
                    ),
                    const SizedBox(height: 4),
                    ShimmerWidget.rectangular(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.9,
                      raduis: 6,
                    ),
                    const SizedBox(height: 4),
                    ShimmerWidget.rectangular(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.9,
                      raduis: 6,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ShimmerWidget.rectangular(
              height: 180,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ShimmerWidget.rectangular(
          height: 50,
          width: 50,
          raduis: 25,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmerWidget.rectangular(
                height: 18,
                width: 120,
                raduis: 8,
              ),
              SizedBox(height: 4),
              ShimmerWidget.rectangular(
                height: 16,
                width: 60,
                raduis: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
