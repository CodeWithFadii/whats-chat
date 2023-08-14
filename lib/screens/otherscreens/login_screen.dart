import 'dart:async';
import 'dart:developer';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/screens/otherscreens/join_again.dart';
import 'package:watts_clone/widgets/materialbuttonwidget.dart';
import 'package:watts_clone/widgets/textfeild_widget.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final authController = Get.put(AuthController());
  Timer? timer;
  int start = 40;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            if (!mounted) return;
            timer.cancel();
          });
        } else {
          if (!mounted) return;
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Obx(
            () {
              return authController.isloading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    //lets connect
                                    locale!.letsconnect,
                                    style: kloginStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: authController.formKey,
                              child: Column(
                                children: [
                                  TextFeildWidget(
                                    validator: (value) {
                                      return null;
                                    },
                                    textEditingController:
                                        authController.usernameC,
                                    //username
                                    labelText: locale.username,
                                    icon: Icons.manage_accounts,
                                    hintText: 'eg.Haroon',
                                    prefixText: '',
                                  ),
                                  12.heightBox,
                                  TextFeildWidget(
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 9) {
                                        //please enter valid number
                                        return locale.pleaseentervalid;
                                      }
                                      return null;
                                    },
                                    labelText: locale.phonenumber,
                                    textEditingController:
                                        authController.phonenumberC,
                                    hintText: '123456789',
                                    textInputType: TextInputType.phone,
                                    prefixText: '+92',
                                  ),
                                ],
                              ),
                            ),
                            13.heightBox,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              //we will send code
                              child: locale.wewillsend.text
                                  .color(grey.shade600)
                                  .size(15)
                                  .make(),
                            ),
                            15.heightBox,
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const JoinAgain());
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 45),
                                //already have account
                                child: locale.alreadyhaveaccount.text.bold
                                    .size(15)
                                    .make(),
                              ),
                            ),
                            13.heightBox,
                            Obx(
                              () {
                                return Visibility(
                                  visible: authController.isOTPsent.value,
                                  child: TextFeildWidget(
                                    validator: (value) {
                                      return null;
                                    },
                                    //verification code
                                    labelText: locale.verificationcode,
                                    icon: Icons.message,
                                    prefixText: '',
                                    //enter verification code
                                    hintText: locale.entercode,
                                    textEditingController: authController.otpC,
                                  ),
                                );
                              },
                            ),
                            20.heightBox,
                            authController.isOTPsent.value
                                ? MaterialbuttonWidget(
                                    color:
                                        start == 0 ? Colors.black : Colors.grey,
                                    onPressed: () async {
                                      if (start == 0) {
                                        if (authController.formKey.currentState!
                                                .validate() &&
                                            authController
                                                .usernameC.text.isNotEmpty) {
                                          await authController.sentOTP(context);
                                        }
                                        setState(() {
                                          start = 40;
                                          startTimer();
                                        });
                                      }
                                    },
                                    text: '${locale.sendoptagain}    $start',
                                  )
                                : Container()
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: MaterialbuttonWidget(
                            text: authController.isOTPsent.value == false
                                //getotp
                                ? locale.getotp
                                //verifyotp
                                : locale.verifyotp,
                            onPressed: () async {
                              //verifying textfields were not empty

                              if (authController.formKey.currentState!
                                      .validate() &&
                                  authController.usernameC.text.isNotEmpty) {
                                //verifying otp
                                if (authController.isOTPsent.value == false) {
                                  log(authController.phonenumberC.text);
                                  setState(() {
                                    startTimer();
                                  });
                                  authController.isOTPsent.value = true;
                                  await authController.sentOTP(context);
                                } else {
                                  //sending OTP
                                  await authController.verifyOTP();
                                }
                              } else {
                                VxToast.show(context,
                                    msg: 'Field are required');
                              }
                              // Get.off(() => HomeScreen());
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
