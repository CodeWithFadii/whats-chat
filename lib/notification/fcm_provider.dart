import 'package:firebase_messaging/firebase_messaging.dart'
    show RemoteMessage, FirebaseMessaging;
import 'package:flutter/widgets.dart';
import 'package:watts_clone/notification/fcm_service.dart';

class FcmProvider with ChangeNotifier {

  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    });
  }

  static forground() {
    FirebaseMessaging.onMessage.listen((message) {
      FirebaseService.send(message);
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {}
}
