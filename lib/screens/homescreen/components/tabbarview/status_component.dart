import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';

Widget statusWidget() {
  return Container(
    padding: const EdgeInsets.all(7),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.heightBox,
        ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(isUser),
          ),
          title: 'My Status'.text.bold.size(19).make(),
          subtitle: 'Tap to add status'.text.color(grey).make(),
        ),
        10.heightBox,
        const Divider(
          height: 1,
          color: black,
        ),
        10.heightBox,
        'Recent Updates'.text.bold.size(19).make(),
        10.heightBox,
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 14,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: grey, width: 4)),
                  child: CircleAvatar(
                    radius: 27,
                    backgroundColor: Vx.randomColor,
                  ),
                ),
                title: 'Username'.text.bold.size(19).make(),
                subtitle: 'Tuesday, 6:30 PM'.text.color(grey).make(),
              );
            },
          ),
        )
      ],
    ),
  );
}
