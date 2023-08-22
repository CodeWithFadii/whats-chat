import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/controller/chat_controller.dart';
import 'package:watts_clone/widgets/alluserscard.dart';

class AllUsers extends StatelessWidget {
  final chatC = Get.find<ChatController>();
  final User? user = firebaseAuth.currentUser;
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
        child: Obx(
          () {
            return chatC.getChatIDloading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : StreamBuilder(
                    stream: firebaseFirestore
                        .collection(collectionUser)
                        .where('id', isNotEqualTo: user!.uid)
                        .snapshots(),
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
                              children: snapshot.data!.docs.mapIndexed(
                                (currentValue, index) {
                                  var doc = snapshot.data!.docs[index];
                                  return AllUsersCard(doc: doc, chatC: chatC);
                                },
                              ).toList(),
                            );
                    },
                  );
          },
        ),
      ),
    );
  }
}
