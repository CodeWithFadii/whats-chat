import 'package:flutter/material.dart';

import 'const.dart';

const kfriendBuble = BorderRadius.only(
  topLeft: Radius.circular(25),
  bottomLeft: Radius.circular(25),
  bottomRight: Radius.circular(25),
);
const kuserBuble = BorderRadius.only(
  topRight: Radius.circular(25),
  bottomLeft: Radius.circular(25),
  bottomRight: Radius.circular(25),
);
final  ktextfielddeco = InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    suffixIcon: const Icon(Icons.attach_file),
    prefixIcon: const Icon(Icons.emoji_emotions),
    filled: true,
    fillColor: white,
    hintText: 'Enter your message here...');
