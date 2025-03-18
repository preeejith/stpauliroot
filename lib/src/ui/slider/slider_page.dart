import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/src/utility/util.dart';

import '../../controller/slider/slider_controller.dart';
import 'custom_dot_indicator.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SliderController(),
      builder: (logic) => Scaffold(
        body: PageView.builder(
          controller: logic.pageController,
          itemCount: logic.imgList.length,
          onPageChanged: (int page) {
            logic.changeSlider(page);
          },
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  logic.imgList[index].image!,
                  fit: BoxFit.fitWidth,
                  width: Get.width,
                  height: Get.height,
                ),
                Positioned(
                  bottom: 230,
                  left: 20,
                  right: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppUtil.widgetText(
                        text: logic.imgList[index].title!,
                        textFontWeight: FontWeight.w700,
                        textColor: logic.imgList[index].titleColor,
                        fontSize: 22,
                      ),
                      const SizedBox(height: 15),
                      AppUtil.widgetText(
                        fontSize: 12,
                        text: logic.imgList[index].subtitle!,
                        textColor: logic.imgList[index].subTitleColor,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 80, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  logic.changePage();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(18),
                  decoration:  BoxDecoration(
                    color: const Color(0xff183dff),
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  width: Get.width,
                  child: AppUtil.widgetText(
                    textAlign: TextAlign.center,
                    text: "CONTINUE",
                    textFontWeight: FontWeight.w400,
                    textColor: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  logic.skipButton();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: AppUtil.widgetText(
                      textAlign: TextAlign.center,
                      text: "SKIP",
                      textFontWeight: FontWeight.w300,
                      textColor: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Obx(
                () => CustomPageViewIndicator(
                  itemCount: logic.imgList.length,
                  currentIndex: logic.currentPage.value,
                  indicatorSize: 10.0,
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
