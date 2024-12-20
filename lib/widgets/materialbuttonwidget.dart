import 'package:flutter/material.dart';

import '../consts/app_theme.dart';

class MaterialbuttonWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Color textcolor;
  final VoidCallback onPressed;
  final double width;
  const MaterialbuttonWidget(
      {super.key,
      required this.onPressed,
      this.color = kPrimaryColor,
      this.text = 'Continue',
      this.textcolor = Colors.white,
      this.width = 250});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 6,
      color: color,
      minWidth: width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      height: 50,
      child: Text(
        text,
        style: TextStyle(color: textcolor),
      ),
    );
  }
}
