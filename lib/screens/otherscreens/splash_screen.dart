import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:watts_clone/screens/otherscreens/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen:   const WelcomeScreen(),
      splash: 'assets/images/logo.png',
      splashTransition: SplashTransition.slideTransition,
      duration: 200,
      splashIconSize: 250,
    );
  }
}
