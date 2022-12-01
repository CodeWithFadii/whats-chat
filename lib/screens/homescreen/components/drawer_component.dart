import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/screens/otherscreens/welcome_screen.dart';
import 'package:watts_clone/screens/profilescreen/profile_screen.dart';

import '../../../consts/auth_const.dart';

Widget drawerWidget() {
  return Drawer(
    backgroundColor: black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.keyboard_return,
              color: white,
            ).onTap(() {
              Get.back();
            }),
            title: 'Settings'.text.white.size(22).make(),
          ),
          10.heightBox,
          const CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(isUser),
          ),
          20.heightBox,
          'User Name'.text.white.size(20).make(),
          20.heightBox,
          const Divider(
            height: 1,
            color: white,
          ),
          20.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(drawerIconList.length, (index) {
              return ListTile(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Get.off(() =>  ProfileScreen(),
                            transition: Transition.downToUp);
                        break;
                      default:
                    }
                  },
                  leading: Icon(drawerIconList[index], color: white, size: 27),
                  title: drawerTextList[index].text.white.size(16).make());
            }),
          ),
          10.heightBox,
          const Divider(height: 1, color: white),
          10.heightBox,
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.people, color: white),
            title: 'invite friend'.text.white.size(16).make(),
          ),
          const Spacer(),
          ListTile(
            onTap: () async {
              await firebaseAuth.signOut();
               Get.rawSnackbar(message: 'Logged out',duration: const Duration(seconds: 4));
              Get.offAll(() =>const WelcomeScreen());
            },
            leading: const Icon(Icons.logout, color: white),
            title: 'Logout'.text.white.size(16).make(),
          ),
          20.heightBox
        ],
      ),
    ),
  );
}
