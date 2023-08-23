import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/screens/homescreen/home_screen.dart';
import 'package:watts_clone/screens/otherscreens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  User? userID = FirebaseAuth.instance.currentUser;

  bool isLogin = false;
  void isloggedIn() {
    if (userID != null) {
      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  void initMethod() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animation =
        Tween(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    _controller.forward();
    isloggedIn();

    Future.delayed(const Duration(milliseconds: 1500), () {
    
      isLogin
          ? Get.offAll(() => HomeScreen())
          : Get.offAll(() => const WelcomeScreen());
    });
  }

  @override
  void initState() {
    super.initState();
    initMethod();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: Image.asset(
            logo,
            width: 240,
            height: 240,
          ),
        ),
      ),
    );
  }
}
