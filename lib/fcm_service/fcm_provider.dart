import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart'
    show FirebaseMessaging, RemoteMessage;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/fcm_service/firebase_service.dart';
import 'package:watts_clone/screens/otherscreens/welcome_screen.dart';
import '../controller/chat_controller.dart';

class FCMProvider with ChangeNotifier {
  static BuildContext? _context;
  static ChatController chatC = Get.put(ChatController());

  static void setContext(BuildContext context) =>
      FCMProvider._context = context;

  /// when app is in the foreground
  static Future<void> onTapNotification(NotificationResponse? response) async {
    if (FCMProvider._context == null || response?.payload == null) return;
    final data = FCMProvider.convertPayload(response!.payload!);
    if (data.containsKey('friend_name')) {}
  }

  static Map convertPayload(String payload) {
    if (payload != "{}") {
      final String data = payload.substring(1, payload.length - 1);
      List<String> split = [];
      List<String> list = data.split(",");
      for (var s in list) {
        split.addAll(s.split(":"));
      }
      Map mapped = {};
      for (int i = 0; i < split.length + 1; i++) {
        if (i % 2 == 1) {
          mapped.addAll({split[i - 1].trim().toString(): split[i].trim()});
        }
      }
      return mapped;
    }
    return {};
  }

  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // if (FCMProvider._refreshNotifications != null) await FCMProvider._refreshNotifications!(true);
      // if this is available when Platform.isIOS, you'll receive the notification twice
      if (Platform.isAndroid) {
        await FirebaseService.localNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          FirebaseService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {}

//navigate user ontapping nitification when app on background
  static navigateWhenBackground(context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FCMProvider.setContext(context);
    });
    Stream<RemoteMessage> stream = FirebaseMessaging.onMessageOpenedApp;
    stream.listen(
      (RemoteMessage event) async {
        if (user != null) {
          ChatController chatC = Get.put(ChatController());
          chatC.getChatID(
              friendId: event.data['friend_id'],
              friendUserName: event.data['friend_name'],
              context: context);
        } else {
          Get.to(() => const WelcomeScreen());
        }
      },
    );
  }

//navigate user ontapping nitification when app terminated
  static navigateWhenTerminated(RemoteMessage? message, context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (message != null) {
          if (user != null) {
            chatC.getChatID(
                friendId: message.data['friend_id'],
                friendUserName: message.data['friend_name'],
                context: context);
          } else {
            Get.to(() => const WelcomeScreen());
          }
        }
      },
    );
  }

  static getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
  }
}
