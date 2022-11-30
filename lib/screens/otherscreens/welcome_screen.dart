import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/strings.dart';

import '../../widgets/materialbuttonwidget.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        height: 150,
                        width: 150,
                        image: AssetImage('assets/images/logo.png'),
                      ),
                      'WattsChat'.text.bold.size(20).make()
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 20,
                      children: List.generate(
                        listOfFeatures.length,
                        (index) {
                          return Chip(
                              padding: const EdgeInsets.all(10),
                              label: listOfFeatures[index]
                                  .text
                                  .semiBold
                                  .color(grey.shade700)
                                  .size(17)
                                  .make());
                        },
                      ),
                    ),
                    30.heightBox,
                    slogan.text.size(42).letterSpacing(2).bold.make()
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    50.heightBox,
                    MaterialbuttonWidget(
                      onPressed: () {
                        Get.off(() => Loginscreen());
                      },
                      text: 'Start Messaging',
                    ),
                    17.heightBox,
                    poweredby.text.color(grey.shade700).semiBold.make()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
