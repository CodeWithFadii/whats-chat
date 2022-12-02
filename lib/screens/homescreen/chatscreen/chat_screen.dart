import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/strings.dart';
import '../../../consts/const.dart';

class ChatScreen extends StatelessWidget {
   const ChatScreen({super.key, required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back,
        ).onTap(() {
          Get.back();
        }),
        actions: [
          const Icon(
            Icons.list,
            size: 30,
          ),
          20.widthBox,
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text.rich(TextSpan(children: [
                    TextSpan(
                      text: '$userName\n',
                      style: const TextStyle(
                          color: black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(
                      text: 'Last seen',
                      style: TextStyle(
                        color: grey,
                        fontSize: 16,
                      ),
                    )
                  ])),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 21,
                        backgroundColor: black,
                        child: Icon(
                          Icons.video_call_outlined,
                          color: white,
                        ),
                      ),
                      10.widthBox,
                      const CircleAvatar(
                        radius: 21,
                        backgroundColor: black,
                        child: Icon(
                          Icons.phone,
                          color: white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            10.heightBox,
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Directionality(
                    textDirection:
                        index.isOdd ? TextDirection.rtl : TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundImage: NetworkImage(
                                  index.isEven ? isUser : logoImage),
                            ),
                            10.widthBox,
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: index.isEven ? black : grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    'Hello this is first message from here for you....'
                                        .text
                                        .color(index.isEven ? white : black)
                                        .size(16)
                                        .make(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              color: black,
              height: 65,
              child: Row(
                children: [
                  7.widthBox,
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: const Icon(Icons.attach_file),
                        prefixIcon: const Icon(Icons.emoji_emotions),
                        filled: true,
                        fillColor: white,
                        hintText: 'Enter your message here...'),
                  )),
                  10.widthBox,
                  const CircleAvatar(
                    radius: 19,
                    backgroundColor: white,
                    child: Icon(
                      Icons.send,
                      color: black,
                    ),
                  ),
                  7.widthBox,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
