import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/auth_const.dart';

class HomeController extends GetxController {
  RxString username = ''.obs;
  RxString imgurl = ''.obs;
  RxString about = ''.obs;
  RxString phone = ''.obs;
  static HomeController instance = Get.find();
  getuserData() async {
    User? user = firebaseAuth.currentUser;
    firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: user!.uid)
        .get()
        .then((value) async {
      username.value = value.docs[0]['username'];
      imgurl.value = value.docs[0]['img_url'];
      about.value = value.docs[0]['about'];
      phone.value = value.docs[0]['phonenumber'];
    });
  }

  @override
  void onInit() {
    super.onInit();
    getuserData();
  }

  getReminderMessages() {
    return firebaseFirestore
        .collection(collectionChats)
        .where('users_array', arrayContains: user!.uid)
        .where('createdAT', isNotEqualTo: null)
        .snapshots();
  }
}
