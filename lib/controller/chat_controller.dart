import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  RxBool isTyping = false.obs;
  String friendImage = '';
  User? currentUserID;

  getChatID(
      {required String friendId,
      required String friendUserName,
      required BuildContext context}) async {
    try {
      String friendToken = '';
      var currentUserID = user!.uid;
      getChatIDloading(true);
      await firebaseFirestore
          .collection(collectionUser)
          .doc(friendId)
          .get()
          .then((value) {
        friendToken = value['fcm_token'];
      });
      chats
          .where('users', isEqualTo: {currentUserID: null, friendId: null})
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) async {
            DocumentSnapshot doc = await FirebaseFirestore.instance
                .collection('User')
                .doc(currentUserID)
                .get();
            if (snapshot.docs.isNotEmpty) {
              chatID.value = snapshot.docs.single.id;
              Get.to(() => ChatScreen(
                    userName: doc['username'],
                    friendToken: friendToken,
                    friendName: friendUserName,
                    friendID: friendId,
                  ));
              getChatIDloading(false);
            } else {
              chats.add({
                'users': {currentUserID: null, friendId: null},
                'users_array': [currentUserID, friendId],
                'friend_name': friendUserName,
                'user_name': doc['username'],
                'friend_id': friendId,
                'user_typing': false,
                'friend_typing': false,
                'user_id': doc['id'],
                'createdAT': null,
                'last_msg': ''
              }).then((value) => {
                    chatID.value = value.id,
                  });
              getChatIDloading(false);
              Get.to(() => ChatScreen(
                  userName: doc['username'],
                  friendToken: friendToken,
                  friendName: friendUserName,
                  friendID: friendId));
            }
          });
    } on Exception {
      // ignore: use_build_context_synchronously
      VxToast.show(context, msg: 'Check your internet connection or try again');
    }
  }

  getMessages(String id) {
    if (id.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection('Chats')
          .doc(id)
          .collection('messages')
          .orderBy('createdAT', descending: true)
          .snapshots();
    }
  }

  getReminderMessages() {
    if (chatID.value.isNotEmpty) {
      return firebaseFirestore
          .collection(collectionChats)
          .doc(chatID.value)
          .snapshots();
    }
  }

  handleTyping(DocumentSnapshot snapshot) {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return snapshot['user_id'] == currentUserID
        ? snapshot['friend_typing']
            ? 'Typing...'
            : ''
        : snapshot['user_typing']
            ? 'Typing...'
            : '';
  }

  void updateTyping(bool typing) {
    if (chatID.value.isNotEmpty) {
      FirebaseFirestore.instance
          .collection(collectionChats)
          .doc(chatID.value)
          .update(
        {'user_typing': typing},
      );
    }
  }

  sendMessage(String msg, String chatId) {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatId).update({
        'createdAT': FieldValue.serverTimestamp(),
        'last_msg': msg,
      });
      chats.doc(chatId).collection(collectionMessages).doc().set({
        'createdAT': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': user!.uid,
      }).then((value) {
        messageController.clear();
      });
    }
  }
}
