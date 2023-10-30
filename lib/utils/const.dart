import 'dart:convert';
import 'dart:developer';

import 'package:final_year_project/auth/models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

enum LoadingState {
  idle,
  processing,
  error,
  loaded,
}

class NotificationMethod {
  Future<void> sendNotification({
    required UserModel user,
    required String title,
    required String body,
    // required String image,
    required UserModel khan,
  }) async {
    log(user.profileUrl.toString());
    log(user.fcm.toString());
    // log(image);
    log(user.toString());
    var data = {
      'to': user.fcm.toString(),
      'notification': {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        'title': title,
        'body': body,

        // 'image':image,
      },
      'android': {
        'notification': {
          'channel_id': const Uuid().v1().toString(),
          'notification_count': 23,
          'user': khan
          // 'image': image,
        },
      },
      'data': {
        'type': 'activation',
        'id': 'saqalin', // Maybe make this dynamic?
        'user': khan
        // 'image': image,
      }
    };

    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAeLTk9Rw:APA91bFicE2ZYhUK25U54MWgxfLqg677g7ABlDVNHcUEYMEcTlfRvaRQPiWBmeTBSpgE9n5OGIKsoLUyg-yQEJ3U3aNs2owcCnzGwo2FR3OAS2YyYRHWDubuEmfITITnJFe-8GVN8C41'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send notification. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }
}
