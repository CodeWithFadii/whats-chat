import 'package:flutter/material.dart';

import '../consts/app_theme.dart';


class TextFeildWidget extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData icon;
  final controller;
  const TextFeildWidget(
      {super.key,
      required this.controller,
      this.hintText = 'Phone Number',
      this.obscureText = false,
      this.icon = Icons.phone});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: 'Phone Number',
          prefixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
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
          hintText: hintText,
          hintStyle: const TextStyle(
            color: kgreyColor,
          ),
        ),
      ),
    );
  }
}
