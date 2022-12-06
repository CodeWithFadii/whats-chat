import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watts_clone/consts/auth_const.dart';

class HomeController extends GetxController {
  late SharedPreferences pref;
  static HomeController instance = Get.find();
  getuserData() async {
    firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: user!.uid)
        .get()
        .then((value) async {
      pref = await SharedPreferences.getInstance();
      pref.setStringList('userDetails', [
        value.docs[0]['username'],
        value.docs[0]['img_url'],
      ]);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getuserData();
  }
}
