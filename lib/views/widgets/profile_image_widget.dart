import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl; 
  final VoidCallback onClicked;
  const ProfileImage({
    Key? key,
    required this.imageUrl,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0.0,
            right: 4.0,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = AssetImage(imageUrl);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128.0,
          height: 128.0,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) {
    return buildCircle(
      color: Colors.white,
      all: 3.0,
      child: buildCircle(
        color: color,
        all: 8.0,
        child: const Icon(
          Icons.edit,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildCircle({
    required Color color,
    required double all,
    required Widget child,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}
