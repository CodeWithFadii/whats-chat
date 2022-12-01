import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  var nameC = TextEditingController();
  var aboutC = TextEditingController();
  var phonenumberC = TextEditingController();
  var imgSrc = ''.obs;

  //updateProfile
  updateProfile(context) async {
    var data = firebaseFirestore.collection(collectionUser).doc(user!.uid);
    await data.set(
      {
        'username': nameC.text,
        'about': aboutC.text,
      },
      SetOptions(merge: true),
    );
    VxToast.show(context, msg: 'Profile updated successfully');
  }

  pickImage(context, source) async {
    await Permission.photos.request();
    await Permission.camera.request();

    var status = await Permission.photos.status;

    if (!status.isGranted) {
      try {
        final img =
            await ImagePicker().pickImage(source: source, imageQuality: 80);
        imgSrc.value = img!.path;
        VxToast.show(context, msg: 'Image picked');
      } on FileSystemException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    } else {
      VxToast.show(
        context,
        msg: 'Permission not given',
      );
    }
  }
}
