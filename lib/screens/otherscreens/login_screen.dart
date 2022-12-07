import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/auth_controller.dart';
import 'package:watts_clone/screens/homescreen/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../consts/const.dart';
import '../../widgets/materialbuttonwidget.dart';
import '../../widgets/textfeild_widget.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});
  var authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 57),
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
                  Form(
                    key: authController.formKey,
                    child: Column(
                      children: [
                        TextFeildWidget(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Please enter user name with more than 5 characters';
                            }
                            return null;
                          },
                          textEditingController: authController.usernameC,
                          labelText: 'User Name',
                          icon: Icons.manage_accounts,
                          hintText: 'eg.Haroon',
                          prefixText: '',
                        ),
                        12.heightBox,
                        TextFeildWidget(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 9) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          textEditingController: authController.phonenumberC,
                          hintText: '123456789',
                          textInputType: TextInputType.phone,
                          prefixText: '+92',
                        ),
                      ],
                    ),
                  ),
                  13.heightBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: weWill.text.color(grey.shade600).size(15).make(),
                  ),
                  13.heightBox,
                  Obx(
                    () {
                      return Visibility(
                        visible: authController.isOTPsent.value,
                        child: SizedBox(
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              6,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: SizedBox(
                                  width: 56,
                                  child: TextField(
                                    onChanged: (value) {
                                      if (value.length == 1 && index <= 5) {
                                        FocusScope.of(context).nextFocus();
                                      } else if (value.isEmpty && index > 0) {
                                        FocusScope.of(context).previousFocus();
                                      }
                                    },
                                    controller: authController.otpC[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: '*',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          borderSide:
                                              const BorderSide(color: black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          borderSide:
                                              const BorderSide(color: black)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  13.heightBox,
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: MaterialbuttonWidget(
                  onPressed: () async {
                    //verifying textfields were not empty

                    if (authController.formKey.currentState!.validate()) {
                      //verifying otp
                      if (authController.isOTPsent.value == false) {
                        log(authController.phonenumberC.text);
                        authController.isOTPsent.value = true;
                        await authController.sentOTP(context);
                      } else {
                        //sending OTP

                        await authController.verifyOTP();
                      }
                    }

                    // Get.off(() => HomeScreen());
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
