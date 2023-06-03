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
  var formKey = GlobalKey<FormState>();
  var joinagainformKey = GlobalKey<FormState>();
  String verificationID = '';
  int token = 0;

  //sentOTP
  sentOTP(context) async {
    //phoneVerificationCompleted
    phoneVerificationCompleted(PhoneAuthCredential credential) async {
      await firebaseAuth.signInWithCredential(credential);
    }

    //phoneVerificationFailed
    phoneVerificationFailed(FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        return VxToast.show(context, msg: 'invalid phone number');
      }
    }

    //phoneCodeSent
    phoneCodeSent(String verificationId, int? resendToken) {
      verificationID = verificationId;
    }

    // codeAutoRetrievalTimeout(String verificationId) {
    //   verificationID = verificationId;
    // }

    try {
      isloading(true);
      //verifyPhoneNumber
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+92${phonenumberC.text}',
          verificationCompleted: phoneVerificationCompleted,
          verificationFailed: phoneVerificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: (code) {});
      isloading(false);
    } catch (e) {
      VxToast.show(context, msg: 'Please try again later');
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
      isloading(false);
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

      final User? user =
          (await firebaseAuth.signInWithCredential(phoneAuthCredential)).user;
      //sending data to firebase
      if (user != null) {
        DocumentReference store =
            firebaseFirestore.collection(collectionUser).doc(user.uid);
        await store.update(
          {
            'id': user.uid,
          },
        );
      }
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
}
