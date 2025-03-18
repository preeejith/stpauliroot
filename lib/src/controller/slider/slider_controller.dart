import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/modal/slider_modal.dart';
import 'package:iroots/src/ui/auth/login_page.dart';

class SliderController extends GetxController {
  GetStorage box = Get.put(GetStorage());

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  final PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);
  RxInt currentPage = 0.obs;

  final List<SliderModal> imgList = [
    SliderModal(
      title: "Welcome to $appName",
      subtitle: "",
      image: slider1,
      titleColor: Colors.white,
      subTitleColor: Colors.white,
    ),
    SliderModal(
      title: "Welcome to $appName",
      subtitle: "",
      image: slider2,
      titleColor: Colors.white,
      subTitleColor: Colors.white,
    ),
    SliderModal(
      title: "Welcome to $appName",
      image: slider3,
      subtitle: "",
      titleColor: Colors.white,
      subTitleColor: Colors.white,
    ),
  ];

  void changeSlider(int page) {
    currentPage.value = page;
    update();
  }

  void skipButton() {
    Get.offAll(() => const LoginPage());
    box.write("isSliderShow", true);
  }

  void changePage() {
    int nextPage = pageController.page!.toInt() + 1;
    if (nextPage < 3) {
      pageController.animateToPage(nextPage,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    } else {
      Get.offAll(() => const LoginPage());
      box.write("isSliderShow", true);
    }
  }
}
