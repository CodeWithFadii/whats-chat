import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:watts_clone/notification/fcm_provider.dart';

class FirebaseService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> intializeFirebase() async {
    await Firebase.initializeApp();
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    await FirebaseService.initializeNotification();
    await FirebaseService.onBackgroundMsg();
    getDeviceToken();
    await FcmProvider.onMessage();
    await FcmProvider.forground();
  }

  static getDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  static final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotification() async {
    const InitializationSettings initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    /// on did receive notification response = for when app is opened via notification while in foreground on android
    await FirebaseService.localNotificationsPlugin.initialize(
      initSettings,
    );

    /// need this for ios foregournd notification
    await FirebaseService.firebaseMessaging
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  static void send(RemoteMessage message) async {
    final iD = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    try {
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
            "high_importance_channel", "High Importance Notifications",
            priority: Priority.high, importance: Importance.high),
      );
      await localNotificationsPlugin.show(
        iD,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // ignore: use_build_context_synchronously
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msj') {}
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage(FcmProvider.backgroundHandler);
  }
}
