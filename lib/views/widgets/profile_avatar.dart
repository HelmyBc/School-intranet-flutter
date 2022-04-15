import 'package:avatar_view/avatar_view.dart';
import 'package:enetcom_app/config/palette.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final bool hasBorder;

  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    this.isActive = false,
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
      child: Stack(
        children: [
          // CircleAvatar(
          //   radius: 20.0,
          //   backgroundColor: Palette.facebookBlue,
          //   child: CircleAvatar(
          //     radius: hasBorder ? 17.0 : 20.0,
          //     backgroundColor: Colors.grey[200],
          //     backgroundImage: AssetImage(imageUrl),
          //   ),
          // ),
          // CircleAvatar(
          //   child: ClipOval(
          //     child: Image.network(
          //       imageUrl,
          //       width:20,
          //       height: 20,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          AvatarView(
            radius: 20,
            borderColor: Colors.grey,
            avatarType: AvatarType.CIRCLE,
            backgroundColor: Colors.red,
            imagePath: imageUrl,
            placeHolder: const Icon(
              Icons.person,
              size: 18,
            ),
            errorWidget: const Icon(
              Icons.error,
              size: 18,
            ),
          ),
          
          isActive
              ? Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 15.0,
                    width: 15.0,
                    decoration: BoxDecoration(
                      color: Palette.online,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
