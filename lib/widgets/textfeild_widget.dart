import 'package:flutter/material.dart';

import '../consts/app_theme.dart';

class TextFeildWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String prefixText;
  final IconData icon;
  final TextInputType textInputType;
  TextFeildWidget(
      {super.key,
      this.labelText = 'Phone Number',
      required this.prefixText,
      this.icon = Icons.phone,
      required this.hintText,  this.textInputType = TextInputType.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: TextField(
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          prefixText: prefixText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
