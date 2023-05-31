import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/screens/homescreen/chatscreen/chat_screen.dart';
import 'package:watts_clone/services/profile_service.dart';

import '../../../controller/home_controller.dart';

class AllUsers extends StatelessWidget {
  final controller = Get.put(HomeController());

  AllUsers({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: 'All Users'.text.bold.size(22).make()),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: StreamBuilder(
          // from profile service
          stream: ProfileService.getallUsers(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return !snapshot.hasData
                ? const Center(child: CircularProgressIndicator())
                : GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 200),
                    children:
                        snapshot.data!.docs.mapIndexed((currentValue, index) {
                      var doc = snapshot.data!.docs[index];
                      return Card(
                        shadowColor: black,
                        color: white,
                        elevation: 6,
                        child: Column(
                          children: [
                            14.heightBox,
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(doc['img_url'] == ''
                                  ? isUser
                                  : doc['img_url']),
                            ),
                            10.heightBox,
                            '${doc['username']}'
                                .text
                                .black
                                .semiBold
                                .size(20)
                                .make(),
                            8.heightBox,
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ChatScreen(),
                                    transition: Transition.downToUp,
                                    arguments: [
                                      doc['username'],
                                      doc['id'],
                                    ]);
                              },
                              child: Chip(
                                label: 'Chat Now'.text.make(),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  );
          },
        ),
      ),
    );
  }
}
