import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

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
                image: NetworkImage(post.imageUrl),
              ),
            )
          else
            const SizedBox.shrink(),
          const SizedBox(
            height: 8.0,
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
                    '${post.createdTime} • ',
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
