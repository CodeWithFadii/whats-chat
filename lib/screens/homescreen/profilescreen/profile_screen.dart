import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/profile_controller.dart';
import 'package:watts_clone/screens/homescreen/home_screen.dart';
import 'package:watts_clone/screens/homescreen/profilescreen/image_toast.dart';
import 'package:watts_clone/services/profile_service.dart';

class ProfileScreen extends StatelessWidget {
  var profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: black,
      appBar: AppBar(
          elevation: 0,
          title: 'Profile'.text.white.semiBold.size(23).make(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () async {
                  if (profileController.imgSrc.isEmpty) {
                    profileController.updateProfile(context);
                  } else {
                    await profileController.storeImage();
                    profileController.updateProfile(context);
                  }
                },
                child: 'Save'.text.color(white).size(20).make(),
              ),
            )
          ],
          leading: const Icon(
            Icons.arrow_back,
            color: white,
          ).onTap(() {
            Get.to(() => HomeScreen(), transition: Transition.downToUp);
          })),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        /////Future Builder
        child: FutureBuilder(
          future: ProfileService.getProfileData(user!.uid),
          builder:
              ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //if the future builder fetches data from firebase then show to user
                //otherwise show indicator
            if (snapshot.hasData) {
              // store data comming from internet in var
              //assign it to controllers
              var data = snapshot.data!.docs[0];
              profileController.nameC.text = data['username'];
              profileController.aboutC.text = data['about'];
              profileController.phonenumberC.text = data['phonenumber'];
              //using getx to show indicator when user's pic is uploaded
              return GetX<ProfileController>(builder: (controller) {
                return controller.updateProfileProgress.value
                    ? const Center(child: CircularProgressIndicator(color: white,backgroundColor: black,))
                    : Column(
                        /////returning column
                        children: [
                          Obx(() {
                            return CircleAvatar(
                              backgroundColor: black,
                              radius: 95,
                              child: Stack(
                                children: [
                                  //if the new user registered
                                  profileController.imgSrc.isEmpty &&
                                          data['img_url'] == ''
                                          //show this image
                                      ? Image.network(isUser)
                                      //if the user selected image from gallery
                                      : profileController.imgSrc.isNotEmpty
                                      //show image selected by the user
                                          ? Image.file(
                                              File(profileController
                                                  .imgSrc.value),
                                            )
                                              .box
                                              .roundedFull
                                              .clip(Clip.hardEdge)
                                              .make()
                                              //if the user is already store a image show him his pic
                                          : Image.network((data['img_url']))
                                              .box
                                              .roundedFull
                                              .clip(Clip.hardEdge)
                                              .make(),
                                  Positioned(
                                    right: 0,
                                    bottom: 20,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: white,
                                      child: const Icon(
                                        Icons.camera_alt_rounded,
                                        color: black,
                                      ).onTap(() {
                                        Get.dialog(imagetoastWidget(context));
                                      }),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                          30.heightBox,
                          const Divider(height: 1, color: white),
                          20.heightBox,
                          ListTile(
                            leading: const Icon(Icons.people,
                                size: 27, color: white),
                            title: TextFormField(
                              controller: profileController.nameC,
                              style: const TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              cursorColor: white,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: const Icon(
                                    Icons.edit,
                                    color: white,
                                  ),
                                  label: 'Name'
                                      .text
                                      .color(grey)
                                      .maxLines(2)
                                      .size(20)
                                      .make(),
                                  isDense: true),
                            ),
                            subtitle: aboutText.text.color(grey).make(),
                          ),
                          10.heightBox,
                          ListTile(
                            leading:
                                const Icon(Icons.info, size: 27, color: white),
                            title: TextFormField(
                              controller: profileController.aboutC,
                              style:
                                  const TextStyle(color: white, fontSize: 17),
                              cursorColor: white,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: const Icon(
                                  Icons.edit,
                                  color: white,
                                ),
                                label: 'About'
                                    .text
                                    .color(grey)
                                    .semiBold
                                    .size(20)
                                    .make(),
                                isDense: true,
                              ),
                            ),
                          ),
                          10.heightBox,
                          ListTile(
                            leading:
                                const Icon(Icons.phone, size: 27, color: white),
                            title: TextFormField(
                              controller: profileController.phonenumberC,
                              readOnly: true,
                              style:
                                  const TextStyle(color: white, fontSize: 18),
                              cursorColor: white,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                label: 'Phone'
                                    .text
                                    .color(grey)
                                    .semiBold
                                    .size(20)
                                    .make(),
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      );
              });
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: white,
                color: black,
              ));
            }
          }),
        ),
      ),
    );
  }
}
