import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/controller/home_controller.dart';
import 'package:watts_clone/screens/homescreen/components/chatbubble_component.dart';


class ChatInfoWidget extends StatelessWidget {
   ChatInfoWidget({super.key});
final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    
    return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    child: StreamBuilder(
      stream: controller.getReminderMessages(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return !snapshot.hasData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text(
                      'No Chats Available',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  )
                : ListView(
                    children: snapshot.data!.docs.mapIndexed(
                      (currentValue, index) {
                        var docs = snapshot.data!.docs[index];
                        return ChatBubbleComponent(
                          docs: docs,
                        );
                      },
                    ).toList(),
                  );
      }),
    ),
  );
  }
}