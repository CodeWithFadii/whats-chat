import 'package:flutter/material.dart';

import 'tabbarview/chat_component.dart';

Widget tabbarViewWidget() {
  return Expanded(
    child: TabBarView(
      children: [
        Container(
          color: Colors.white,
          child: chatInfoWidget(),
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.green,
        ),
      ],
    ),
  );
}
