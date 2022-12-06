import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/controller/home_controller.dart';

class ChatController extends GetxController {
  var messageController = TextEditingController();
  var getMessagesloading = false.obs;
  var chats = firebaseFirestore.collection(collectionChats);
  dynamic chatID;
  var currentUserID = user!.uid;
  var currentUserName = HomeController.instance.prefs.getString('user_name');
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
            log(chatID);
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

  sendMessage(String msg) {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatID).update({
        'createdAT': FieldValue.serverTimestamp(),
        'fromID': currentUserID,
        'toID': friendUserID,
        'last_msg': msg,
      });
      chats.doc(chatID).collection(collectionMessages).doc().set({
        'createdAT': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentUserID,
      }).then((value) {
        messageController.clear();
      });
    }
  }

  getMessages(chatID) {
    log('start');
    firebaseFirestore
        .collection(collectionChats)
        .doc(chatID)
        .collection(collectionMessages)
        .snapshots();
    log('end');
  }
  
}
