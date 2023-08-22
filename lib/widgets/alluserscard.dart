import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/controller/chat_controller.dart';

class AllUsersCard extends StatelessWidget {
  const AllUsersCard({
    super.key,
    required this.doc,
    required this.chatC,
  });

  final QueryDocumentSnapshot<Object?> doc;
  final ChatController chatC;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: black,
      color: white,
      elevation: 6,
      child: Column(
        children: [
          14.heightBox,
          CircleAvatar(
            radius: 40,
            backgroundImage:
                NetworkImage(doc['img_url'] == '' ? isUser : doc['img_url']),
          ),
          10.heightBox,
          '${doc['username']}'.text.black.semiBold.size(20).make(),
          8.heightBox,
          GestureDetector(
            onTap: () {
              chatC.friendImage = doc['img_url'];
              chatC.getChatID(
                  friendId: doc['id'],
                  friendUserName: doc['username'],
                  context: context);
            },
            child: Chip(
              label: 'Chat Now'.text.make(),
            ),
          )
        ],
      ),
    );
  }
}
