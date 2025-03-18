import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/splash/splash_controller.dart';
import 'package:iroots/src/utility/const.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (logic) => Scaffold(
        backgroundColor: ConstClass.themeColor,
        body: Center(
          child: CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(appIcon),
            // child: Image.asset(
            //   appIcon,
            //   width: 200,
            //   height: 200,
            //   // color: Colors.white,
            // ),
          ),
        ),
      ),
    );
  }
}
