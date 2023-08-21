import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController {
  // ignore: prefer_const_constructors

  static changeLanguage(String languageValue) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (languageValue == 'English') {
      Get.updateLocale(const Locale('en'));
      sp.setString('language_value', 'en');
    } else if (languageValue == 'Spanish') {
      Get.updateLocale(const Locale('es'));
      sp.setString('language_value', 'es');
    } else if (languageValue == 'French') {
      Get.updateLocale(const Locale('fr'));
      sp.setString('language_value', 'fr');
    } else {
      Get.updateLocale(const Locale('ur'));
      sp.setString('language_value', 'ur');
    }
  }

 

 
}
