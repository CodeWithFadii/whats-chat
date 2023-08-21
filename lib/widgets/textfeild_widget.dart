import 'package:flutter/material.dart';

import '../consts/app_theme.dart';

class TextFeildWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String? hintText;
  final String? prefixText;
  final Widget icon;
  final TextInputType textInputType;
  const TextFeildWidget(
      {super.key,
      this.labelText = 'Phone Number',
      required this.textEditingController,
       this.prefixText,
      this.icon = const Icon(Icons.phone),
       this.hintText,
      this.textInputType = TextInputType.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon,
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
