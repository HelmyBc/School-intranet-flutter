import 'package:enetcom_app/config/palette.dart';
import 'package:enetcom_app/models/post_model.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostContainer extends StatelessWidget {
  final PostModel post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showActions() {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Select An Option'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('One'),
              onPressed: () {
                Navigator.pop(context, 'One');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Two'),
              onPressed: () {
                Navigator.pop(context, 'Two');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Three'),
              onPressed: () {
                Navigator.pop(context, 'Three');
              },
            ),
          ],
        ),
      );
    }

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
                Text(post.caption),
                // ignore: unnecessary_null_comparison
                post.imageUrl != null
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 6.0),
              ],
            ),
          ),
          // ignore: unnecessary_null_comparison
          if (post.imageUrl != '')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image(
                image: AssetImage(post.imageUrl!),
              ),
            )
          else
            const SizedBox.shrink(),
          const SizedBox(
            height: 8.0,
          ),
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
  final PostModel post;

  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo} • ',
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
          onPressed: () {},
        ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final PostModel post;

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
                '${post.interested}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${post.comments} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${post.shares} Shares',
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
