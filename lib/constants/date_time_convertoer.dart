import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  final dateTime = format.parse(dateTimeString);

  final difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else {
    // Handle larger time differences as needed
    return DateFormat('y-MM-dd').format(dateTime);
  }
}
