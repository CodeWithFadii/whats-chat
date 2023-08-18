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
  DrawerWidget({super.key});
  final languageC = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {
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
              ListView(
                shrinkWrap: true,
                children: List.generate(
                  drawerIconList.length,
                  (index) {
                    return ListTile(
                        onTap: () {
                          if (index == 0) {
                            Get.to(() => ProfileScreen());
                          }
                        },
                        leading:
                            Icon(drawerIconList[index], color: white, size: 27),
                        title:
                            drawerTextList[index].text.white.size(16).make());
                  },
                ),
              ),
              10.heightBox,
              const Divider(height: 1, color: white),
              10.heightBox,
              ListTile(
                leading: const Icon(Icons.language, color: white),
                trailing: DropdownButton(
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.more_horiz_outlined, color: white),
                  items: ['English', 'Spanish', 'Urdu', 'French']
                      .map(
                        (e) => DropdownMenuItem<String>(
                          child: e.text.black.size(16).make(),
                        ),
                      )
                      .toList(),
                  onChanged: languageChangeMethod,
                ),
                //Language
                title: locale.language.text.white.size(16).make(),
              ),
              10.heightBox,
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.people, color: white),
                //invite friend
                title: locale.invitefriend.text.white.size(16).make(),
              ),

              const Spacer(),
              ListTile(
                onTap: () async {
                  await firebaseAuth.signOut();
                  Get.rawSnackbar(
                      //logged out
                      message: locale.loggedout,
                      duration: const Duration(seconds: 4));
                  Get.offAll(() => const WelcomeScreen());
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

  void languageChangeMethod(value) {
    switch (value) {
      case 'English':
        languageC.locale.value = const Locale('eg');
        break;
      case 'Spanish':
        languageC.locale.value = const Locale('es');
        break;
      case 'Urdu':
        languageC.locale.value = const Locale('ur');
        break;
      case 'French':
        languageC.locale.value = const Locale('fr');
    }
  }
}
