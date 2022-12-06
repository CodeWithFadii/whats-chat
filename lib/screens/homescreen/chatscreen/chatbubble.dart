import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../consts/bubble_const.dart';
import '../../../consts/const.dart';
import '../../../consts/strings.dart';

Widget chatBubbbleWidget(index, DocumentSnapshot docs) {
  return Directionality(
    textDirection: index.isOdd ? TextDirection.rtl : TextDirection.ltr,
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundImage: NetworkImage(index.isEven
                  ? isUser
                  : 'https://media-exp1.licdn.com/dms/image/C560BAQG0idii_L-_qQ/company-logo_200_200/0/1635777707028?e=2147483647&v=beta&t=fD-cCiVlTEk2tVLlFxl7RXMbDZKenXB4mGaHI3bmQgs'),
            ),
            10.widthBox,
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: index.isEven ? black : grey,
                      borderRadius: index.isEven ? kuserBuble : kfriendBuble),
                  child: 'Hello'
                      .text
                      .color(index.isEven ? white : black)
                      .size(16)
                      .make(),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
