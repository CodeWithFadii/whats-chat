import 'package:flutter/material.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: kPrimaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    fontFamily: "WorkSans",
    shadowColor: Theme.of(context).disabledColor,
    dividerColor: const Color(0xff707070),
    canvasColor: Colors.white,
    backgroundColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    errorColor: kErrorColor,
    textTheme: getTextTheme(),
    primaryTextTheme: getTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.light(
            primary: kPrimaryColor, secondary: kPrimaryColor)
        .copyWith(secondary: kPrimaryColor),
  );
}



TextTheme getTextTheme() {
  return const TextTheme(
    bodyText1: TextStyle(fontFamily: "WorkSans"),
    bodyText2: TextStyle(fontFamily: "WorkSans"),
    headline1: TextStyle(fontFamily: "WorkSans"),
    headline2: TextStyle(fontFamily: "WorkSans"),
    headline3: TextStyle(fontFamily: "WorkSans"),
    headline4: TextStyle(fontFamily: "WorkSans"),
    headline5: TextStyle(fontFamily: "WorkSans"),
    headline6: TextStyle(fontFamily: "WorkSans"),
    subtitle1: TextStyle(fontFamily: "WorkSans"),
    subtitle2: TextStyle(fontFamily: "WorkSans"),
    button: TextStyle(fontFamily: "WorkSans"),
    caption: TextStyle(fontFamily: "WorkSans"),
    overline: TextStyle(fontFamily: "WorkSans"),
  );
}

const kPrimaryColor = Colors.black;
// const kSecondaryColor = Color(0xFFFE9901);
// const kContentColorLightTheme = Color(0xFF1D1D35);
// const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kgreyColor = Colors.grey;
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
