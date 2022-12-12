import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/screens/homescreen/home_screen.dart';

class AuthController extends GetxController {
  //intialize controllers
  var usernameC = TextEditingController();
  var phonenumberC = TextEditingController();
  var otpC = List.generate(6, (index) => TextEditingController());
  //initialize observable variable
  var isOTPsent = false.obs;
  var isloading = false.obs;
  var formKey = GlobalKey<FormState>();

  //initialize auth variables
  late final PhoneVerificationCompleted phoneVerificationCompleted;
  late final PhoneVerificationFailed phoneVerificationFailed;
  late final PhoneCodeSent phoneCodeSent;
  String verificationID = '';

  //sentOTP
  sentOTP(context) async {
    //phoneVerificationCompleted
    phoneVerificationCompleted = (PhoneAuthCredential credential) async {
      await firebaseAuth.signInWithCredential(credential);
    };
    //phoneVerificationFailed
    phoneVerificationFailed = (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        VxToast.show(context, msg: e.toString());
      }
    };
    //phoneCodeSent
    phoneCodeSent = (String verificationId, int? resendToken) {
      verificationID = verificationId;
      log(verificationID);
    };

    try {
      isloading(true);
      //verifyPhoneNumber
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+92${phonenumberC.text}',
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      isloading(false);
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  verifyOTP() async {
    String otP = '';
    //getting otp entered by the user
    for (var i = 0; i < otpC.length; i++) {
      otP += otpC[i].text;
      log(otP);
    }
    try {
      isloading(true);
      //verifying user
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otP);

      final User? user =
          (await firebaseAuth.signInWithCredential(phoneAuthCredential)).user;
      //sending data to firebase
      if (user != null) {
        DocumentReference store =
            firebaseFirestore.collection(collectionUser).doc(user.uid);
        await store.set(
          {
            'id': user.uid,
            'username': usernameC.text.toString(),
            'phonenumber': '+92${phonenumberC.text}',
            'about': '',
            'img_url': '',
          },
          SetOptions(merge: true),
        );

        Get.rawSnackbar(
            message: 'Logged In', duration: const Duration(seconds: 4));
        Get.offAll(() => HomeScreen(), transition: Transition.downToUp);
      }
      isloading(false);
    } catch (e) {
      Get.snackbar('Error in logging', e.toString(),
          duration: const Duration(seconds: 5));
    }
  }
}
