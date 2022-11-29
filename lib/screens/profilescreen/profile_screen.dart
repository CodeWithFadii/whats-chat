import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/screens/homescreen/home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: black,
      appBar: AppBar(
          elevation: 0,
          title: 'Profile'.text.white.semiBold.size(23).make(),
          leading: const Icon(
            Icons.arrow_back,
            color: white,
          ).onTap(() {
            Get.off(() => HomeScreen(), transition: Transition.downToUp);
          })),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          children: [
            20.heightBox,
            CircleAvatar(
              backgroundColor: white,
              radius: 75,
              child: Stack(
                children: const [
                  Image(image: AssetImage(logoImage)),
                  Positioned(
                    right: 0,
                    bottom: 20,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: white,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            30.heightBox,
            const Divider(height: 1, color: white),
            20.heightBox,
            ListTile(
              leading: const Icon(Icons.people, size: 27, color: white),
              title: TextFormField(
                style: const TextStyle(color: white),
                cursorColor: white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: white,
                  ),
                  label: 'Name'.text.white.semiBold.maxLines(2).size(20).make(),
                  isDense: true,
                ),
              ),
              subtitle: aboutText.text.color(grey).make(),
            ),
            10.heightBox,
            ListTile(
              leading: const Icon(Icons.info, size: 27, color: white),
              title: TextFormField(
                style: const TextStyle(color: white),
                cursorColor: white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: white,
                  ),
                  label: 'About'.text.white.semiBold.size(20).make(),
                  isDense: true,
                ),
              ),
            ),
            10.heightBox,
            ListTile(
              leading: const Icon(Icons.phone, size: 27, color: white),
              title: TextFormField(
                readOnly: true,
                style: const TextStyle(color: white),
                cursorColor: white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: 'Phone'.text.white.semiBold.size(20).make(),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
