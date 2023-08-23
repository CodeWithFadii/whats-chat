
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/controller/chat_controller.dart';
import 'package:watts_clone/fcm_service/fcm_provider.dart';
import 'package:watts_clone/fcm_service/firebase_service.dart';
import 'package:watts_clone/screens/otherscreens/splash_screen.dart';
import 'consts/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();

  final RemoteMessage? message =
      await FirebaseService.firebaseMessaging.getInitialMessage();
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

class _MyAppState extends State<MyApp>   {
  @override
  void initState() {
    super.initState();
    getInitialLanguage();
    Get.put(ChatController());
    FCMProvider.navigateWhenBackground(context);
    FCMProvider.navigateWhenTerminated(widget.message, context);
    // FCMProvider.getToken();
  }

 

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      locale: Get.locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocals,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
