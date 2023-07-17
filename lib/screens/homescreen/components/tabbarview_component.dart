import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/controller/chat_controller.dart';
import 'package:watts_clone/screens/homescreen/components/tabbarview/status_component.dart';

import 'tabbarview/chat_component.dart';

Widget tabbarViewWidget() {
  final chatController = Get.put(ChatController());
  return Expanded(
    child: TabBarView(
      children: [
        Obx(
          () => Container(
            color: Colors.white,
            child: chatController.getChatIDloading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : chatInfoWidget(),
          ),
        ),
        Container(
          color: Colors.white,
          child: statusWidget(),
        ),
        Container(
          color: Colors.white,
        ),
      ],
    ),
  );
}
