import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/profile_controller.dart';

const listofIcon = <IconData>[Icons.camera, Icons.browse_gallery];

getprofileText(AppLocalizations? locale) {
  List strings = [
    locale!.camera,
    locale.gallery,
  ];
  return strings;
}

class ImageToast extends StatelessWidget {
  ImageToast({super.key});
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    List textList = getprofileText(locale);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //select image
            locale!.selectimage.text.bold.size(20).black.make(),
            const Divider(color: white, height: 1),
            ListView(
              shrinkWrap: true,
              children: List.generate(
                2,
                (index) => ListTile(
                  onTap: () {
                    switch (index) {
                      case 0:
                        //for camera
                        profileController.pickImage(
                            context, ImageSource.camera);
                        break;
                      case 1:
                        //for gallery
                        profileController.pickImage(
                            context, ImageSource.gallery);
                        break;
                      default:
                    }
                  },
                  leading: Icon(
                    //list of icons created top
                    listofIcon[index],
                    color: grey,
                  ),
                  //list of text created top
                  title: Text(textList[index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
