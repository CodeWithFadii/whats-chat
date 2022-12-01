import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:watts_clone/screens/homescreen/home_screen.dart';
import 'package:watts_clone/screens/otherscreens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  isloggedIn() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isloggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: isLogin?HomeScreen():const WelcomeScreen(),
      splash: 'assets/images/logo.png',
      splashTransition: SplashTransition.slideTransition,
      duration: 200,
      splashIconSize: 250,
    );
  }
}
