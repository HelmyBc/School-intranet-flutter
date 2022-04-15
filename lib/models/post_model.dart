import 'user_model.dart';

class Post {
  final User user;
  final String caption;
  final String timeAgo;
  final String? imageUrl;
  final int interested;
  final int comments;
  final int shares;

  const Post({
    required this.user,
    required this.caption,
    required this.timeAgo,
    this.imageUrl,
    required this.interested,
    required this.comments,
    required this.shares,
  });
}
