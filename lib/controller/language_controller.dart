import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var locale = const Locale('ur').obs;

  changeLanguage(Locale languageValue) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (languageValue == const Locale('en')) {
      locale.value = languageValue;
      sp.setString('language_value', 'en');
    }
    if (languageValue == const Locale('es')) {
      locale.value = languageValue;
      sp.setString('language_value', 'es');
    }
    if (languageValue == const Locale('fr')) {
      locale.value = languageValue;
      sp.setString('language_value', 'fr');
    } else {
      locale.value = languageValue;
      sp.setString('language_value', 'ur');
    }
  }

  void assignLanguage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String language = sp.getString('language_value') ?? '';

    if (language.isNotEmpty) {
      locale.value = Locale(language);
    }
  }

  @override
  void onInit() {
    super.onInit();
    assignLanguage();
  }
}
