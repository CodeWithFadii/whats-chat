import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/controller/chat_controller.dart';
import 'package:watts_clone/screens/homescreen/components/tabbarview/status_component.dart';
import 'tabbarview/chat_component.dart';

class TabViewWidget extends StatelessWidget {
  TabViewWidget({super.key});
  final chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
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
                  : ChatInfoWidget(),
            ),
          ),
          Container(
            color: Colors.white,
            child: const StatusWidget(),
          ),
          Container(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
