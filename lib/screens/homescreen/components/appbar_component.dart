import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/home_controller.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.keyGlobal});

  final GlobalKey<ScaffoldState> keyGlobal;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              keyGlobal.currentState!.openDrawer();
            },
            child: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "$appname\n",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  //connecting lives
                  text: locale!.connectinglives,
                  style: TextStyle(fontSize: 17, color: grey.shade700),
                ),
              ],
            ),
          ),
          Obx(
            () {
              return CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    HomeController.instance.imgurl.value == ''
                        ? isUser
                        : HomeController.instance.imgurl.value),
                radius: 27,
              );
            },
          )
        ],
      ),
    );
  }
}
