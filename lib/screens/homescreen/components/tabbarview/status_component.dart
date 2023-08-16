import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightBox,
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(isUser),
            ),
            //my status
            title: locale!.mystatus.text.bold.size(19).make(),
            //Tap to add status
            subtitle: locale.taptoaddstatus.text.color(grey).make(),
          ),
          10.heightBox,
          const Divider(
            height: 1,
            color: black,
          ),
          10.heightBox,
          //recent updates
          locale.recentupdates.text.bold.size(19).make(),
          10.heightBox,
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 14,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: grey, width: 4)),
                    child: CircleAvatar(
                      radius: 27,
                      backgroundColor: Vx.randomColor,
                    ),
                  ),
                  //user name
                  title: locale.username.text.bold.size(19).make(),
                  subtitle:
                      '${locale.tuesday}, 6:30 PM'.text.color(grey).make(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
