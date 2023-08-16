import 'package:flutter/material.dart';

import 'const.dart';

const kfriendBuble = BorderRadius.only(
  topLeft: Radius.circular(20),
  bottomLeft: Radius.circular(20),
  bottomRight: Radius.circular(20),
);
const kuserBuble = BorderRadius.only(
  topRight: Radius.circular(20),
  bottomLeft: Radius.circular(20),
  bottomRight: Radius.circular(20),
);
final  ktextfielddeco = InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    suffixIcon: const Icon(Icons.attach_file),
    prefixIcon: const Icon(Icons.emoji_emotions),
    filled: true,
    fillColor: white,);
