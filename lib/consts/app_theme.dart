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
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
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
    bodyLarge: TextStyle(fontFamily: "WorkSans"),
    bodyMedium: TextStyle(fontFamily: "WorkSans"),
    displayLarge: TextStyle(fontFamily: "WorkSans"),
    displayMedium: TextStyle(fontFamily: "WorkSans"),
    displaySmall: TextStyle(fontFamily: "WorkSans"),
    headlineMedium: TextStyle(fontFamily: "WorkSans"),
    headlineSmall: TextStyle(fontFamily: "WorkSans"),
    titleLarge: TextStyle(fontFamily: "WorkSans"),
    titleMedium: TextStyle(fontFamily: "WorkSans"),
    titleSmall: TextStyle(fontFamily: "WorkSans"),
    labelLarge: TextStyle(fontFamily: "WorkSans"),
    bodySmall: TextStyle(fontFamily: "WorkSans"),
    labelSmall: TextStyle(fontFamily: "WorkSans"),
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
