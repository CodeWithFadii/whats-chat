import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/bubble_const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/home_controller.dart';
import 'package:watts_clone/screens/homescreen/chatscreen/chatbubble.dart';
import '../../../consts/const.dart';
import '../../../controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  var chatController = Get.put(ChatController());
  var homeController = Get.find<HomeController>();
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
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
            color: white,
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
                      text: '${chatController.friendUserName}\n',
                      style: const TextStyle(
                          color: black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(
                      text: 'Last seen',
                      style: TextStyle(
                        color: grey,
                        fontSize: 16,
                      ),
                    )
                  ])),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 21,
                        backgroundColor: black,
                        child: Icon(
                          Icons.video_call_outlined,
                          color: white,
                        ),
                      ),
                      10.widthBox,
                      const CircleAvatar(
                        radius: 21,
                        backgroundColor: black,
                        child: Icon(
                          Icons.phone,
                          color: white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            10.heightBox,
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                //from chat controller we getting all chats here
                stream: chatController.getMessages(chatController.chatID),
                builder: ((context, AsyncSnapshot snapshot) {
                  log('start ');
                  return !snapshot.hasData ? const Center(
                      child: CircularProgressIndicator(),
                    ) : ListView(
                        children: snapshot.data!.docs
                            .mapIndexed((currentValue, index) {
                      var docs = snapshot.data!.docs[index];
                      return chatBubbbleWidget(index, docs);
                    }).toList());
                }),
              ),
            ),
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
                      chatController
                          .sendMessage(chatController.messageController.text);
                    },
                    child: const CircleAvatar(
                      radius: 19,
                      backgroundColor: white,
                      child: Icon(
                        Icons.send,
                        color: black,
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
