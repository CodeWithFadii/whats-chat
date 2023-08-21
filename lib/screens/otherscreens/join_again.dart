import 'dart:async';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/screens/otherscreens/login_screen.dart';
import 'package:watts_clone/widgets/materialbuttonwidget.dart';
import 'package:watts_clone/widgets/textfeild_widget.dart';

class JoinAgain extends StatefulWidget {
  const JoinAgain({super.key});

  @override
  State<JoinAgain> createState() => _JoinAgainState();
}

class _JoinAgainState extends State<JoinAgain> {
  final authController = Get.put(AuthController());
  Timer? timer;
  int start = 0;
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
                                    locale!.joinagain,
                                    style: kloginStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFeildWidget(
                              icon: CountryCodePicker(
                                flagWidth: 25,
                                initialSelection: 'PK',
                                onChanged: (value) {
                                  authController.countyCode(value.dialCode);
                                },
                              ),
                              labelText: locale.phonenumber,
                              textEditingController:
                                  authController.phonenumberC,
                              textInputType: TextInputType.phone,
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
                            20.heightBox,
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const Loginscreen());
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 45),
                                child: locale.nothaveaccount.text.bold
                                    .size(15)
                                    .make(),
                              ),
                            ),
                            30.heightBox,
                            Visibility(
                              visible: authController.isOTPsent.value,
                              child: TextFeildWidget(
                                textInputType: TextInputType.number,
                                //verification code
                                labelText: locale.verificationcode,
                                icon: const Icon(
                                  Icons.message,
                                ),
                                prefixText: '',
                                //enter verification code
                                hintText: locale.entercode,
                                textEditingController: authController.otpC,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialbuttonWidget(
                                color: start == 0 ? Colors.black : Colors.grey,
                                width: 150,
                                text: start == 0
                                    ? locale.getotp
                                    : '${locale.getotp}    $start',
                                onPressed: () async {
                                  if (start == 0) {
                                    getOtpOnTap(context);
                                  }
                                },
                              ),
                              25.widthBox,
                              MaterialbuttonWidget(
                                width: 150,
                                text: locale.verifyotp,
                                onPressed: verifyOtpOnTap,
                              ),
                            ],
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

  Future<void> getOtpOnTap(BuildContext context) async {
    if (authController.phonenumberC.text.isEmpty) {
      VxToast.show(context, msg: 'All  fields are required');
      return;
    }
    authController.isOTPsent(true);
    setState(() {
      start = 60;
      startTimer();
    });
    await authController.sentOTP(context);
  }

  Future<void> verifyOtpOnTap() async {
    if (authController.phonenumberC.text.isEmpty ||
        authController.otpC.text.isEmpty) {
      VxToast.show(context, msg: 'All  fields are required');
      return;
    }
    await authController.verifyOTP();
  }
}
