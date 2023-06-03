import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/profile_controller.dart';

const listofIcon = <IconData>[Icons.camera, Icons.browse_gallery];
const listofText = ['Camera', 'Gallery'];

Widget imagetoastWidget(context) {
  var profileController = Get.put(ProfileController());
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          'Select Image'.text.bold.size(20).black.make(),
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
                      profileController.pickImage(context, ImageSource.camera);
                      break;
                    case 1:
                    //for gallery
                      profileController.pickImage(context, ImageSource.gallery);
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
                title: Text(listofText[index]),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
