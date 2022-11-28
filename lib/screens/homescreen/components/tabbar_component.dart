import 'package:flutter/material.dart';
import 'package:watts_clone/consts/strings.dart';

Widget tabbarWidget() {
  return TabBar(
    indicator: const BoxDecoration(),
    unselectedLabelColor: Colors.grey.shade700,
    labelColor: Colors.white,
    labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    tabs: const [
      Tab(
        text: chats,
      ),
      Tab(
        text: status,
      ),
      Tab(
        text: camera,
      ),
    ],
  );
}
