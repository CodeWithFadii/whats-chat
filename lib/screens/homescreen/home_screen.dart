import 'package:flutter/material.dart';
import 'components/appbar_component.dart';
import 'components/tabbar_component.dart';
import 'components/tabbarview_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              appBarWidget(),
              Expanded(
                child: Column(
                  children: [
                    tabbarWidget(),
                    tabbarViewWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
