import 'package:avatar_view/avatar_view.dart';
import 'package:enetcom_app/config/palette.dart';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final bool hasBorder;
  final double raduis;

  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    this.isActive = false,
    this.hasBorder = false,
    this.raduis = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          AvatarView(
            radius: raduis,
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
