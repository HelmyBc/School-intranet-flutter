import 'package:timeago/timeago.dart' as timeago;

class HelperFunction {
  String convertDateTime(String dateTime) {
    var dateTime;
    DateTime createdTime = DateTime.parse(dateTime);

    final difference = DateTime.now().difference(createdTime);
    final finalDateTime = DateTime.now().subtract(difference);
    final timeAgo = timeago.format(finalDateTime);
    return timeAgo;
  }
}
