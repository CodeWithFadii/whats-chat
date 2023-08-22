import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/home_controller.dart';
import 'package:watts_clone/controller/language_controller.dart';
import 'package:watts_clone/screens/otherscreens/welcome_screen.dart';
import 'package:watts_clone/screens/homescreen/profilescreen/profile_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print(user!.uid);
    final locale = AppLocalizations.of(context);
    return Drawer(
      backgroundColor: black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Obx(() {
          return Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.keyboard_return,
                  color: white,
                ).onTap(
                  () {
                    Get.back();
                  },
                ),
                //settings
                title: locale!.settings.text.white.size(22).make(),
              ),
              10.heightBox,
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    HomeController.instance.imgurl.value == ''
                        ? isUser
                        : HomeController.instance.imgurl.value),
              ),
              20.heightBox,
              //user name
              HomeController.instance.username.value.text.white.size(20).make(),
              20.heightBox,
              const Divider(
                height: 1,
                color: white,
              ),
              20.heightBox,
              ListTile(
                  onTap: () {
                    Get.to(() => ProfileScreen());
                  },
                  leading: Icon(drawerIconList[0], color: white, size: 27),
                  title: locale.account.text.white.size(16).make()),
              10.heightBox,
              const Divider(height: 1, color: white),
              10.heightBox,
              ListTile(
                leading: const Icon(Icons.language, color: white),
                trailing: PopupMenuButton(
                    position: PopupMenuPosition.under,
                    icon: const Icon(
                      Icons.more_horiz_outlined,
                      color: Colors.white,
                    ),
                    itemBuilder: (BuildContext context) {
                      return ['English', 'Spanish', 'Urdu', 'French']
                          .map(
                            (e) => PopupMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList();
                    },
                    onSelected: (value) {
                      LanguageController.changeLanguage(value);
                    }),
                //Language
                title: locale.language.text.white.size(16).make(),
              ),

              const Spacer(),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance
                      .signOut()
                      .then((value) => Get.offAll(() => const WelcomeScreen()));
                  Get.rawSnackbar(
                      //logged out
                      message: locale.loggedout,
                      duration: const Duration(seconds: 4));
                },
                leading: const Icon(Icons.logout, color: white),
                //logout
                title: locale.logout.text.white.size(16).make(),
              ),
              20.heightBox
            ],
          );
        }),
      ),
    );
  }
}
