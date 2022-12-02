import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  var imageData = '';
  var updateProfileProgress = false.obs;

  //updateProfile
  updateProfile(context) async {
    var data = firebaseFirestore.collection(collectionUser).doc(user!.uid);
    await data.set(
      {
        'username': nameC.text,
        'about': aboutC.text,
        'img_url': imageData,
      },
      SetOptions(merge: true),
    );
    VxToast.show(context, msg: 'Profile updated successfully');
  }

  pickImage(context, source) async {
    //requesting permissions for accessing
    await Permission.photos.request();
    await Permission.camera.request();

    var status = await Permission.photos.status;

    if (!status.isGranted) {
      try {
        final img =
            //pick img from gallery or camera
            await ImagePicker().pickImage(source: source, imageQuality: 80);
        //store image path to a observable var imgSrc
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

  storeImage() async {
    updateProfileProgress(true);
    //converting the source of image to different form
    var name = basename(imgSrc.value);
    //setting destination where we want to store our data in firebase storage
    var destination = "images/${user!.uid}/$name";
    //creating storage
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    //putting data into storage
    await ref.putFile(File(imgSrc.value));
    //getting the url uploaded to store in database
    var d = await ref.getDownloadURL();
    imageData = d;
    log(d);
    updateProfileProgress(false);
  }
}
