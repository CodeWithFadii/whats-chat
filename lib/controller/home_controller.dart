import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watts_clone/consts/auth_const.dart';

class HomeController extends GetxController {
  late SharedPreferences prefs;
  static HomeController instance = Get.find();
  RxString username = ''.obs;
  RxString imgurl = ''.obs;
  getuserData() async {
    await getInstance();
    firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: user!.uid)
        .get()
        .then((value) async {
      username.value = value.docs[0]['username'];
      imgurl.value = value.docs[0]['img_url'];
      prefs = await SharedPreferences.getInstance();
      prefs.setString('user_name', value.docs[0]['username']);
      prefs.setString('img_url', value.docs[0]['img_url']);

      log(value.docs[0]['username']);
    });
  }

  getInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void onInit() {
    super.onInit();
    getuserData();
  }

  getReminderMessages() {
    return firebaseFirestore
        .collection(collectionChats)
        .where('users.${user!.uid}', isEqualTo: null)
        .where('createdAT', isNotEqualTo: null)
        .snapshots();
  }
}
