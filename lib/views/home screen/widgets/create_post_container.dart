import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/views/home%20screen/create_post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;
  const CreatePostContainer({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      child: Column(
        children: [
          Row(
            children: [
              ProfileAvatar(imageUrl: currentUser.imageUrl!),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  readOnly: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreatePostScreen()),
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: "Hey, what's on your mind?",
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 10.0, thickness: 0.5),
          Container(
            color: Colors.white,
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton.icon(
                    // ignore: avoid_print
                    onPressed: () => print("live"),
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.red,
                    ),
                    label: const Text("Video")),
                const VerticalDivider(
                  width: 8.0,
                ),
                FlatButton.icon(
                    // ignore: avoid_print
                    onPressed: () => print("Photo"),
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                    ),
                    label: const Text("Photo")),
                const VerticalDivider(
                  width: 8.0,
                ),
                FlatButton.icon(
                    // ignore: avoid_print
                    onPressed: () => print("Room"),
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.purpleAccent,
                    ),
                    label: const Text("Room")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
