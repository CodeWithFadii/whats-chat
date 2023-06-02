import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/screens/homescreen/chatscreen/chat_screen.dart';

class ChatController extends GetxController {
  var messageController = TextEditingController();
  var getChatIDloading = false.obs;
  var chats = firebaseFirestore.collection(collectionChats);
  RxString chatID = ''.obs;
  String friendImage = '';
  var currentUserID = user!.uid;

  getChatID(
      {required String friendId,
      required String friendUserName,
      required BuildContext context}) async {
    try {
      getChatIDloading(true);
      chats
          .where('users', isEqualTo: {currentUserID: null, friendId: null})
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) async {
            if (snapshot.docs.isNotEmpty) {
              chatID.value = snapshot.docs.single.id;
              getChatIDloading(false);
              Get.to(() => ChatScreen(
                    friendName: friendUserName,
                  ));
            } else {
              DocumentSnapshot doc = await FirebaseFirestore.instance
                  .collection('User')
                  .doc(currentUserID)
                  .get();
              chats.add({
                'users': {currentUserID: null, friendId: null},
                'users_array': [currentUserID, friendId],
                'friend_name': friendUserName,
                'user_name': doc['username'],
                'friend_id': friendId,
                'user_id': doc['id'],
                'createdAT': null,
                'last_msg': ''
              }).then((value) => {
                    chatID.value = value.id,
                  });
              Get.to(() => ChatScreen(
                    friendName: friendUserName,
                  ));
            }
          });
      getChatIDloading(false);
    } on Exception {
      VxToast.show(context, msg: 'Check your internet connection or try again');
    }
  }

  sendMessage(String msg) {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatID.value).update({
        'createdAT': FieldValue.serverTimestamp(),
        'last_msg': msg,
      });
      chats.doc(chatID.value).collection(collectionMessages).doc().set({
        'createdAT': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentUserID,
      }).then((value) {
        messageController.clear();
      });
    }
  }

  getMessages(String id) {
    if (id.isNotEmpty) {
      var data = FirebaseFirestore.instance
          .collection(collectionChats)
          .doc(id)
          .collection(collectionMessages)
          .orderBy('createdAT', descending: true)
          .snapshots();
      return data;
    }
  }
}
