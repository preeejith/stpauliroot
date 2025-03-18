import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/ui/dashboard/dashboard_screen.dart';
import 'package:iroots/src/ui/slider/slider_page.dart';

class SplashController extends GetxController {
  GetStorage box = Get.put(GetStorage());

  @override
  void onInit() {
    _navigate();
    super.onInit();
  }

  void _navigate() {
    bool isUserLogin = box.read('isUserLogin') ?? false;
    bool isSliderShow = box.read('isSliderShow') ?? false;

    Future.delayed(3.seconds, () {
      if (isUserLogin) {
        Get.offAll(() => const DashBoardPageScreen());
      } else if (isSliderShow) {
        Get.offAll(() => const LoginPage());
      } else {
        Get.offAll(() => const SliderPage());
      }
    });
  }
}
