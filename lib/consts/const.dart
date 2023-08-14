import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
