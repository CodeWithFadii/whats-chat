import 'package:flutter/material.dart';
import 'package:watts_clone/screens/homescreen/components/tabbarview/status_component.dart';

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
          color: Colors.white,
          child: statusWidget(),
        ),
        Container(
          color: Colors.green,
        ),
      ],
    ),
  );
}
