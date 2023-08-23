import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SendMethod {
  static void sendNotification({required String title, required String body, required String sentTo,
      required String friendName, required String friendId}) async {
    String url = 'https://fcm.googleapis.com/fcm/send';
    String serverKey =
        'AAAAxpUpLho:APA91bFXx2fyr4ZM6eXH3EPbr1fn372mmpc0hDr7j70w3yhaxcMSPq7CI-gxQEuT0DPUdUapdfyYCuZaZn-wCtk9O1pjePfTrmy0gV1FMcBv2IUDKXTi1NFcK-cVdb2zQdcOytM3XQW7';
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
        'AAAAxpUpLho:APA91bFXx2fyr4ZM6eXH3EPbr1fn372mmpc0hDr7j70w3yhaxcMSPq7CI-gxQEuT0DPUdUapdfyYCuZaZn-wCtk9O1pjePfTrmy0gV1FMcBv2IUDKXTi1NFcK-cVdb2zQdcOytM3XQW7';
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
