import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/screens/homescreen/chatscreen/chat_screen.dart';

Widget chatInfoWidget() {
  return Expanded(
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Get.to(() => ChatScreen(),
                transition: Transition.downToUp,
                arguments: ['dummy username', 'dummyID']);
          },
          leading: const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(
                'https://image.shutterstock.com/image-vector/user-icon-260nw-523867123.jpg'),
          ),
          title: 'User Name'.text.bold.size(18).make(),
          subtitle: const Text('message here...'),
          trailing: const Text('last Seen'),
        );
      },
    ),
  );
}
