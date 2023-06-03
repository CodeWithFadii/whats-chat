import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:intl/intl.dart' as intl;
import 'package:watts_clone/consts/bubble_const.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';

Widget chatBubbleWidget(DocumentSnapshot docs) {
  DateTime dateTime = docs['createdAT'] == null
      ? DateTime.parse(DateTime.now().toString())
      : DateTime.parse(docs['createdAT'].toDate().toString());

  return Directionality(
    textDirection:
        docs['uid'] == user!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: docs['uid'] == user!.uid ? black : grey,
                    borderRadius:
                        docs['uid'] == user!.uid ? kfriendBuble : kuserBuble),
                child: '${docs['msg']}'
                    .text
                    .color(docs['uid'] == user!.uid ? white : black)
                    .size(16)
                    .make(),
              ),
            ),
            10.widthBox,
            Directionality(
                textDirection: docs['uid'] == user!.uid
                    ? TextDirection.ltr
                    : TextDirection.ltr,
                child: intl.DateFormat('h:ma')
                    .format(dateTime)
                    .text
                    .color(grey)
                    .size(12)
                    .make())
          ],
        ),
      ),
    ),
  );
}
