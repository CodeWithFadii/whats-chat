import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watts_clone/consts/auth_const.dart';
import 'app_theme.dart';

List<String> listfeatures(AppLocalizations? locale) {
  final listOfFeatures = [
    locale!.fast,
    locale.powerful,
    locale.secure,
    locale.private,
    locale.unlimited,
    locale.synced,
    locale.reliable,
  ];
  return listOfFeatures;
}

const String logo = 'assets/images/logo.png';
const String splash = '/';
const isUser =
    'https://www.clipartmax.com/png/middle/424-4242023_fa-user-circle-icon.png';

const kloginStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 40,
);
const Color white = Colors.white;
const Color black = Colors.black;

const List<Locale> supportedLocals = [
  Locale('en'),
  Locale('es'),
  Locale('fr'),
  Locale('ur'),
];

const localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
getInitialLanguage() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  String language = sp.getString('language_value') ?? '';
  if (language.isNotEmpty) {
    Get.updateLocale(Locale(language));
  }
}

