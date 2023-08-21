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
  var otpC = TextEditingController();
  //initialize observable variable
  var isOTPsent = false.obs;
  var isloading = false.obs;
  var countyCode = '+92'.obs;
  String verificationID = '';
  int token = 0;

  //sentOTP
  sentOTP(context) async {
    print(countyCode);
    //phoneVerificationCompleted
    phoneVerificationCompleted(PhoneAuthCredential credential) async {
      print('Auto Verification Completed');
      final User? user =
          (await firebaseAuth.signInWithCredential(credential)).user;
      //sending data to firebase
      if (user != null) {
        signupMethod(user);
      }
    }

    //phoneVerificationFailed
    phoneVerificationFailed(FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        return VxToast.show(context, msg: 'invalid phone number');
      }
    }

    //phoneCodeSent
    phoneCodeSent(String verificationId, int? resendToken) {
      print(verificationId);
      verificationID = verificationId;
    }

    codeAutoRetrievalTimeout(String verificationId) {
      verificationID = verificationId;
    }

    try {
      isloading(true);
      //verifyPhoneNumber
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '${countyCode.value}${phonenumberC.text}',
          verificationCompleted: phoneVerificationCompleted,
          verificationFailed: phoneVerificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      isloading(false);
    } catch (e) {
      VxToast.show(context, msg: 'Some Thing went wrong');
    }
  }

  verifyOTP() async {
    //getting otp entered by the user
    try {
      isloading(true);
      //verifying user
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otpC.text);

      final User? user =
          (await firebaseAuth.signInWithCredential(phoneAuthCredential)).user;
      //sending data to firebase
      if (user != null) {
        await signupMethod(user);
      }
      isloading(false);
    } catch (e) {
      isloading(false);
      print(e.toString());
      Get.snackbar('Error in logging', e.toString(),
          duration: const Duration(seconds: 5));
    }
  }

  joinAgain() async {
    //getting otp entered by the user
    try {
      isloading(true);
      //verifying user
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otpC.text);

      await firebaseAuth.signInWithCredential(phoneAuthCredential);
      //sending data to firebase

      Get.rawSnackbar(
          message: 'Logged In', duration: const Duration(seconds: 4));
      Get.offAll(() => HomeScreen(), transition: Transition.downToUp);

      isloading(false);
    } catch (e) {
      isloading(false);
      Get.snackbar('Error in logging', e.toString(),
          duration: const Duration(seconds: 5));
    }
  }

  signupMethod(User user) async {
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

    Get.rawSnackbar(message: 'Logged In', duration: const Duration(seconds: 4));
    Get.offAll(() => HomeScreen(), transition: Transition.downToUp);
  }
}
