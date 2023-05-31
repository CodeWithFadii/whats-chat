import 'package:flutter/material.dart';

import '../consts/app_theme.dart';

class TextFeildWidget extends StatelessWidget {
  final TextEditingController textEditingController;
   final String labelText;
  final String? Function(String?)? validator;
  final String hintText;
  final String prefixText;
  final IconData icon;
  final TextInputType textInputType;
  const TextFeildWidget(
      {super.key,
      required this.validator,
      this.labelText = 'Phone Number',
      required this.textEditingController,
      required this.prefixText,
      this.icon = Icons.phone,
      required this.hintText,
      this.textInputType = TextInputType.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: TextFormField(
        validator: validator,
        controller: textEditingController,
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
