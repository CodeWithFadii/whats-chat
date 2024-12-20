import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_clone/consts/const.dart';
import 'package:watts_clone/consts/strings.dart';
import 'package:watts_clone/controller/home_controller.dart';
import 'package:watts_clone/screens/homescreen/allusers/allusers_screen.dart';
import 'package:watts_clone/screens/homescreen/components/drawer_component.dart';
import 'components/appbar_component.dart';
import 'components/tabbar_component.dart';
import 'components/tabbarview_component.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          drawer:  DrawerWidget(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: grey,
            onPressed: () {
              Get.to(() => AllUsers(), transition: Transition.downToUp);
            },
            child: const Icon(
              Icons.message,
              color: white,
            ),
          ),
          backgroundColor: black,
          body: Column(
            children: [
              AppBarWidget(
                keyGlobal: scaffoldKey,
              ),
              Expanded(
                child: Column(
                  children: [
                    const TabbarWidget(), 
                    TabViewWidget(),
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
