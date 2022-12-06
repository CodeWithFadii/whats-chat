import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/controller/home_controller.dart';

class ChatController extends GetxController {
  var chats = firebaseFirestore.collection(collectionChats);
  dynamic chatID;
  var currentUserID = user!.uid;
  var currentUserName =
      HomeController.instance.pref.getStringList('userDetails'[0]);
  var friendUserID = Get.arguments[1];
  var friendUserName = Get.arguments[0];

  getChatID() async {
    chats
        .where('users', isEqualTo: {friendUserID: null, currentUserID: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatID = snapshot.docs.single.id;
          } else {
            chats.add({
              'users': {currentUserID: null, friendUserID: null},
              'friend_name': friendUserName,
              'user_name': currentUserName,
              'toID': '',
              'fromID': '',
              'createdAT': null,
              'last_msg': ''
            }).then((value) => {
                  chatID = value.id,
                });
          }
        });
  }

  @override
  void onInit() {
    getChatID();
    super.onInit();
  }
}
