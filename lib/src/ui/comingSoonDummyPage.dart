import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/coming_soon_controller.dart';
import 'package:iroots/src/utility/const.dart';

class ComingSoonDummyPage extends StatelessWidget {
  const ComingSoonDummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ComingSoonController(),
      builder: (logic) => Scaffold(
        backgroundColor: ConstClass.themeColor,
        body: Center(
          child: Image.asset(
            "assets/comingSoon.png",
          ),
        ),
      ),
    );
  }
}
