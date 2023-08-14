import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/widgets/materialbuttonwidget.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    List<String> listOfFeatures = listfeatures(locale);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
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
              Column(
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
                              .make(),
                        );
                      },
                    ),
                  ),
                  15.heightBox,
                  //join revolution
                  locale!.joinrevolution.text
                      .size(42)
                      .letterSpacing(2)
                      .bold
                      .make()
                ],
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MaterialbuttonWidget(
                  onPressed: () {
                    Get.to(() => const Loginscreen());
                  },
                  //start messaging
                  text: locale.startmessaging,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
