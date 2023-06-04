import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SendMethod {
  static void sendNotification(String title, String body, String sentTo,
      String friendName, String friendId) async {
    String url = 'https://fcm.googleapis.com/fcm/send';
    String serverKey =
        'AAAAVEnwmic:APA91bHL_o8HQBYcAiFs09p7-S30a_2CR4zmlpEXVIipsEJ4Qcj0gfBMMwDfZkugAamcbV2o6e9aHnzItdSfQPVWRyXy4NhzmFb5mFU2lhXPICbGm8J31vwhYO6_w56vXDLyGO9HBfnm';
    try {
      await Dio().post(
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
        ),
        url,
        data: {
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'friend_name': friendName,
            'friend_id': friendId,
          },
          'notification': {
            'title': title,
            'body': body,
          },
          'to': sentTo,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static void eventNotification(String title, String body) async {
    String url = 'https://fcm.googleapis.com/fcm/send';
    String serverKey =
        'AAAAq4_OuHQ:APA91bFt9RFwuFPM2kOE9ztUu5DhYsZEyEj9KKK5DG9769n1_InPalTJa0Nrs5sMDJbEvZd07uAlNZE7crpQUp_hOVp_BQQIF5h9ljwAl9v9jGq7UR6okJZ-ewzVEfvq3_t759oArfpP';
    try {
      await Dio().post(
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
        ),
        url,
        data: {
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
          },
          'notification': {
            'title': title.capitalize,
            'body': body,
          },
          'to': '/topics/events'
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
