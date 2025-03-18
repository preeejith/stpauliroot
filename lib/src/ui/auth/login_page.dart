import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/auth/auth_controller.dart';
import 'package:iroots/src/ui/auth/forgot_pass_page.dart';
import 'package:iroots/src/ui/auth/sign_up_page.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:new_version_plus/new_version_plus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    if (kReleaseMode) {
      basicStatusCheck();
    }

    super.initState();
  }

  basicStatusCheck() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    if (Platform.isIOS
        ? remoteConfig.getBool("force_update_required_ios")
        : remoteConfig.getBool("force_update_required")) {
      final versionForce = Platform.isIOS
          ? remoteConfig.getString("force_update_ios_version")
          : remoteConfig.getString("force_update_current_version");
      final newVersion = NewVersionPlus(
        forceAppVersion: versionForce,
        iOSId: appBundle,
        androidId: appBundle,
      );
      final version = await newVersion.getVersionStatus();

      if (Platform.isAndroid) {
        if (version?.localVersion != versionForce) {
          newVersion.showUpdateDialog(
            context: context,
            versionStatus: version!,
            launchModeVersion: LaunchModeVersion.external,
            allowDismissal: false,
            dialogText:
                "Please install now the new version. We made improvements to functionality that will enhance your experience. ",
            updateButtonText: "Upgrade",
            dialogTitle:
                "Please install now the new version. We made improvements to functionality that will enhance your experience. ",
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthController(),
      builder: (logic) => Scaffold(
        backgroundColor: const Color(0xff1575FF),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                slider1,
                fit: BoxFit.fitWidth,
                height: Get.height,
                width: Get.width,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppUtil.widgetText(
                        text: "Sign In",
                        textFontWeight: FontWeight.bold,
                        fontSize: 20,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 15),
                      AppUtil.widgetText(
                        text: "Email/UserName",
                        textFontWeight: FontWeight.w400,
                        fontSize: 16,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      ConstClass.widgetTextField(
                        prefixIcon: const Icon(Icons.email),
                        controllerEmail: logic.controllerEmail,
                        hint: "Enter your email",
                        maxLength: 50,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      AppUtil.widgetText(
                        text: "Password",
                        textFontWeight: FontWeight.w400,
                        fontSize: 16,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      ConstClass.widgetTextField(
                        prefixIcon: const Icon(Icons.password),
                        controllerEmail: logic.controllerPassword,
                        hint: "Enter your password",
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        isPassword: true,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppUtil.widgetText(
                              text: "Remember me",
                              textFontWeight: FontWeight.w400,
                              fontSize: 14,
                              textColor: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(() => const ForgotPassPage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppUtil.widgetText(
                                text: "Forgot Password",
                                textFontWeight: FontWeight.w400,
                                fontSize: 14,
                                textColor: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Obx(() => logic.showProgress.value
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: Get.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  logic.login();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: AppUtil.widgetText(
                                    textAlign: TextAlign.center,
                                    text: "LOGIN",
                                    fontSize: 15,
                                    textFontWeight: FontWeight.w500,
                                    textColor: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => const SignupPage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AppUtil.widgetText(
                            text: "Don't have an account? create",
                            fontSize: 15,
                            textFontWeight: FontWeight.w400,
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
