import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/controllers/post_controller.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/services/http_post_service.dart';
import 'package:enetcom_app/views/admin_views/posts/edit_post_screen.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'dart:convert' show utf8;

class NewPostContainer extends StatelessWidget {
  final Post post;

  const NewPostContainer({
    Key? key,
    required this.post,
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
                _PostHeader(post: post),
                const SizedBox(height: 4.0),
                Text(post.description),
              ],
            ),
          ),
          // ignore: unnecessary_null_comparison
          if (post.imageUrl == null || post.imageUrl!.isEmpty)
            const SizedBox.shrink()
          else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image(
                image: NetworkImage(post.imageUrl!),
              ),
            ),

          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostStats(post: post),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime createdTime = DateTime.parse(post.createdTime);

    final difference = DateTime.now().difference(createdTime);
    final dateTime = DateTime.now().subtract(difference);
    final timeAgo = timeago.format(dateTime);

    return Row(
      children: [
        ProfileAvatar(imageUrl: post.profImage),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.username,
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
    PostController postController = Get.put(PostController());
    showCupertinoModalPopup(
      barrierColor: Colors.black26.withOpacity(0.5),
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select An Option'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Edit description'),
            onPressed: () {
              Navigator.pop(context, 'Edit description');
              postController.editingPost.clear();
              postController.editingPost.add(post);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditPostScreen(
                          post: post,
                        )),
              );
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('delete post'),
            onPressed: () {
              Navigator.pop(context, 'delete post');
              HttpPostService.deletePost(post.id);
              postController.fetchPosts();
              const snackBar =
                  SnackBar(content: Text("Post removed succefully!"));
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

class _PostStats extends StatelessWidget {
  final Post post;

  const _PostStats({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '125',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${70} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '18 Shares',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Like',
              // ignore: avoid_print
              onTap: () => print('Like'),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              // ignore: avoid_print
              onTap: () => print('Comment'),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              // ignore: avoid_print
              onTap: () => print('Share'),
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          // ignore: avoid_returning_null_for_void
          onTap: () => null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
