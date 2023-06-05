import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/consts/bubble_const.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/chat_controller.dart';
import 'package:watts_clone/controller/home_controller.dart';
import 'package:watts_clone/fcm_service/send_method.dart';
import 'package:watts_clone/screens/homescreen/chatscreen/chatbubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.userName,
    required this.friendToken,
    required this.friendName,
  });
  final chatController = Get.find<ChatController>();
  final String userName;
  final String friendName;
  final String friendToken;
  final currentUserID = user!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back,
        ).onTap(() {
          Get.back();
        }),
        actions: [
          const Icon(
            Icons.list,
            size: 30,
          ),
          20.widthBox,
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: friendName,
                      style: const TextStyle(
                          color: black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ])),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 21,
                        backgroundColor: grey,
                        child: Icon(
                          Icons.video_call_outlined,
                          color: black,
                        ),
                      ),
                      10.widthBox,
                      const CircleAvatar(
                        radius: 21,
                        backgroundColor: grey,
                        child: Icon(
                          Icons.phone,
                          color: black,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            10.heightBox,
            Obx(() {
              return chatController.getChatIDloading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    )
                  : Expanded(
                      child: StreamBuilder(
                        //from ProfileService we getting all chats here
                        stream: chatController
                            .getMessages(chatController.chatID.value),
                        builder:
                            ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView(
                                  reverse: true,
                                  children: snapshot.data!.docs
                                      .mapIndexed((currentValue, index) {
                                    var docs = snapshot.data!.docs[index];
                                    return chatBubbleWidget(docs);
                                  }).toList());
                        }),
                      ),
                    );
            }),
            Container(
              color: black,
              height: 65,
              child: Row(
                children: [
                  7.widthBox,
                  Expanded(
                      child: TextField(
                          controller: chatController.messageController,
                          maxLines: 1,
                          decoration: ktextfielddeco)),
                  10.widthBox,
                  GestureDetector(
                    onTap: () {
                      chatController.sendMessage(
                          chatController.messageController.text,
                          chatController.chatID.value);
                      if (chatController.messageController.text.isNotEmpty) {
                        SendMethod.sendNotification(
                            HomeController.instance.username.value,
                            chatController.messageController.text,
                            friendToken,
                            userName,
                            user!.uid);
                      }
                    },
                    child: const CircleAvatar(
                      radius: 19,
                      backgroundColor: white,
                      child: Icon(
                        Icons.send,
                        color: grey,
                      ),
                    ),
                  ),
                  7.widthBox,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
