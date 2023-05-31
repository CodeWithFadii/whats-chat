import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:watts_clone/screens/otherscreens/splash_screen.dart';
import 'consts/app_theme.dart';
import 'consts/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      title: 'Flutter Demo',
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


