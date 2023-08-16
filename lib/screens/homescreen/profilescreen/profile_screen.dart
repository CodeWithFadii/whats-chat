import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/home_controller.dart';
import 'package:watts_clone/controller/profile_controller.dart';
import 'package:watts_clone/screens/homescreen/home_screen.dart';
import 'package:watts_clone/screens/homescreen/profilescreen/image_toast.dart';

class ProfileScreen extends StatelessWidget {
  final profileController = Get.put(ProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: black,
      appBar: AppBar(
          elevation: 0,
          // profile
          title: locale?.profile.text.white.semiBold.size(23).make(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () async {
                  if (profileController.imgSrc.isEmpty) {
                    await profileController.updateProfile(context);
                    HomeController.instance.getuserData();
                  } else {
                    await profileController.storeImage();
                    // ignore: use_build_context_synchronously
                    await profileController.updateProfile(context);
                    HomeController.instance.getuserData();
                  }
                },
                //save
                child: locale!.save.text.color(white).size(20).make(),
              ),
            )
          ],
          leading: const Icon(
            Icons.arrow_back,
            color: white,
          ).onTap(() {
            Get.offAll(() => HomeScreen(), transition: Transition.downToUp);
          })),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        /////Future Builder
        child: Column(
          /////returning column
          children: [
            Obx(() {
              return profileController.updateProfileProgress.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: black,
                      radius: 95,
                      child: Stack(
                        children: [
                          //if the new user registered
                          profileController.imgSrc.isEmpty &&
                                  HomeController.instance.imgurl.value == ''
                              //show this image
                              ? Image.network(isUser)
                                  .box
                                  .roundedFull
                                  .clip(Clip.hardEdge)
                                  .make()
                              //if the user selected image from gallery
                              : profileController.imgSrc.isNotEmpty
                                  //show image selected by the user
                                  ? Image.file(
                                      File(profileController.imgSrc.value),
                                    ).box.roundedFull.clip(Clip.hardEdge).make()
                                  //if the user is already store a image show him his pic
                                  : Image.network((HomeController
                                          .instance.imgurl.value))
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
                                Get.dialog(ImageToast());
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
              leading: const Icon(Icons.people, size: 27, color: white),
              title: TextFormField(
                controller: profileController.nameC,
                style: const TextStyle(
                    color: white, fontSize: 20, fontWeight: FontWeight.w600),
                cursorColor: white,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(
                      Icons.edit,
                      color: white,
                    ),
                    //name
                    label: locale.name.text
                        .color(grey)
                        .maxLines(2)
                        .size(20)
                        .make(),
                    isDense: true),
              ),
              // This is not username
              subtitle: locale.thisisnotusername.text.color(grey).make(),
            ),
            10.heightBox,
            ListTile(
              leading: const Icon(Icons.info, size: 27, color: white),
              title: TextFormField(
                controller: profileController.aboutC,
                style: const TextStyle(color: white, fontSize: 17),
                cursorColor: white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: white,
                  ),
                  //about
                  label: locale.about.text.color(grey).semiBold.size(20).make(),
                  isDense: true,
                ),
              ),
            ),
            10.heightBox,
            ListTile(
              leading: const Icon(Icons.phone, size: 27, color: white),
              title: TextFormField(
                controller: profileController.phonenumberC,
                readOnly: true,
                style: const TextStyle(color: white, fontSize: 18),
                cursorColor: white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  //phone
                  label: locale.phone.text.color(grey).semiBold.size(20).make(),
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
