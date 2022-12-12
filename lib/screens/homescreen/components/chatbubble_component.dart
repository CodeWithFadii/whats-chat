import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../chatscreen/chat_screen.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubbleComponent(DocumentSnapshot docs) {
  DateTime dateTime = docs['createdAT'] == null
      ? DateTime.parse(DateTime.now().toString())
      : DateTime.parse(docs['createdAT'].toDate().toString());
  return Card(
    margin: const EdgeInsets.all(10),
    elevation: 10,
    child: ListTile(
        onTap: () {
          Get.to(() => ChatScreen(),
              transition: Transition.downToUp,
              arguments: [ '${docs['friend_name']}','${docs['toID']}'
              ]);
        },
        title: '${docs['friend_name']}'.text.bold.size(18).make(),
        subtitle: Text(
          '${docs['last_msg']}',
          maxLines: 1,
        ),
        trailing: Directionality(
          textDirection: TextDirection.ltr,
          child: intl.DateFormat('h:m a').format(dateTime).text.make(),
        )),
  );
}
