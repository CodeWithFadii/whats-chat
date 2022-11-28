import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/screens/homescreen/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/const.dart';
import '../../widgets/materialbuttonwidget.dart';
import '../../widgets/textfeild_widget.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: const [
                        Text(
                          "Let's Connect",
                          style: kloginStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFeildWidget(
                    controller: emailC,
                  ),
                  13.heightBox,
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: weWill.text.color(grey.shade600).size(15).make(),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: MaterialbuttonWidget(
                  onPressed: () {
                    Get.off(() => const HomeScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
