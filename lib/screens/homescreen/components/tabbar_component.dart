import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabbarWidget extends StatelessWidget {
  const TabbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return TabBar(
      indicator: const BoxDecoration(),
      unselectedLabelColor: Colors.grey.shade700,
      labelColor: Colors.white,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      tabs:  [
        Tab(
          // chats
          text: locale!.chats,
        ),
        Tab(
          //status
          text: locale.status,
        ),
        Tab(
          //camera
          text: locale.camera,
        ),
      ],
    );
  }
}
