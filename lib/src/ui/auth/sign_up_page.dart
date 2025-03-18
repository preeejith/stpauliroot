import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/auth/auth_controller.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthController(),
      builder: (logic) => SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff75beec),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/slider3.png",
                  fit: BoxFit.fitWidth,
                  height: Get.height,
                  width: Get.width,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: AppUtil.widgetText(
                              text: "Sign Up",
                              textFontWeight: FontWeight.bold,
                              fontSize: 20,
                              textColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: AppUtil.widgetText(
                                  text: "Name",
                                  textFontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  textColor: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ConstClass.widgetTextField(
                                prefixIcon: const Icon(Icons.person),
                                controllerEmail: logic.controllerName,
                                hint: "Enter your name",
                                maxLength: 50,
                                keyboardType: TextInputType.name),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: AppUtil.widgetText(
                                  text: "Email",
                                  textFontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  textColor: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ConstClass.widgetTextField(
                                prefixIcon: const Icon(Icons.email),
                                controllerEmail: logic.controllerEmail,
                                hint: "Enter your email ID",
                                maxLength: 50,
                                keyboardType: TextInputType.emailAddress),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: AppUtil.widgetText(
                                  text: "Password",
                                  textFontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  textColor: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ConstClass.widgetTextField(
                                prefixIcon: const Icon(Icons.password),
                                controllerEmail: logic.controllerPassword,
                                hint: "Enter your Password",
                                maxLength: 50,
                                keyboardType: TextInputType.visiblePassword),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() => logic.showProgress.value
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    width: Get.width,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        logic.register();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: AppUtil.widgetText(
                                            textAlign: TextAlign.center,
                                            text: "REGISTER",
                                            fontSize: 15,
                                            textFontWeight: FontWeight.w500,
                                            textColor: Colors.white),
                                      ),
                                    ),
                                  )),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.off(() => const LoginPage());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: AppUtil.widgetText(
                                    text: "Already have an account? Login",
                                    fontSize: 15,
                                    textFontWeight: FontWeight.w400,
                                    textColor: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
