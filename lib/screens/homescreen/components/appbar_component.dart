import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/home_controller.dart';

Widget appBarWidget(GlobalKey<ScaffoldState> key) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    color: Colors.white,
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: const Icon(
            Icons.settings,
            size: 30,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: "$appname\n",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: connecting,
                style: TextStyle(fontSize: 17, color: grey.shade700),
              ),
            ],
          ),
        ),
        Obx(
          () {
            return CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  NetworkImage(HomeController.instance.imgurl.value),
              radius: 27,
            );
          },
        )
      ],
    ),
  );
}
