// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../consts/app_theme.dart';


class TextRichWidget extends StatelessWidget {
  VoidCallback onTap;
  final String firstText;
  final String secondText;
  TextRichWidget({
    Key? key,
    required this.onTap,
     this.firstText = 'New to Logistics?',
     this.secondText = ' Register Now',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:  Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: firstText,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            TextSpan(
              text: secondText,
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
