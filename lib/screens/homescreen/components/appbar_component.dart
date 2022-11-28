import 'package:flutter/material.dart';
import 'package:watts_clone/consts/strings.dart';

Widget appBarWidget() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    color: Colors.white,
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.settings,
          size: 30,
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
        const CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(
              'https://image.shutterstock.com/image-vector/user-icon-260nw-523867123.jpg'),
          radius: 30,
        )
      ],
    ),
  );
}
