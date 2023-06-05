import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/controller/chat_controller.dart';
import 'package:watts_clone/fcm_service/fcm_provider.dart';
import 'package:watts_clone/fcm_service/firebase_service.dart';
import 'package:watts_clone/screens/otherscreens/splash_screen.dart';
import 'package:watts_clone/screens/otherscreens/welcome_screen.dart';
import 'consts/app_theme.dart';
import 'consts/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();
  final RemoteMessage? message =
      await FirebaseService.firebaseMessaging.getInitialMessage();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp(
    message: message,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.message});
  final RemoteMessage? message;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application
  //
  getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  void init() {
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

  @override
  void initState() {
    super.initState();
    ChatController chatC = Get.put(ChatController());
    init();
    // getToken();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (widget.message != null) {
          if (user != null) {
            chatC.getChatID(
                friendId: widget.message!.data['friend_id'],
                friendUserName: widget.message!.data['friend_name'],
                context: context);
          } else {
            Get.to(() => const WelcomeScreen());
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      title: 'Watts Chat',
      themeMode: ThemeMode.system,
      initialRoute: splash,
      getPages: appRoutes(),
    );
  }

  appRoutes() => [
        GetPage(
          name: splash,
          page: () => const SplashScreen(),
        ),
      ];
}
