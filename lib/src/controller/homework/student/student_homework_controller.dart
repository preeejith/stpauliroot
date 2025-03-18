import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/dashboard/dashBoard_controller.dart';
import 'package:iroots/src/modal/home/student/studentDetails.dart';
import 'package:iroots/src/modal/homework/getHomeworkModalClass.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class StudentHomeWorkController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  

  List<GetHomeWorkData> getHomeworkDataList = [];
  RxBool homeWorkProgress = false.obs;
  RxBool isHomeWorkDataFound = false.obs;
  Student? studentsData;

  String? accessToken;





  @override
  void onInit() {
    accessToken = box.read("accessToken");

    studentsData = Get.arguments;

    getHomeWork();
    super.onInit();
  }

  Future<void> getHomeWork() async {
    homeWorkProgress.value = true;

    print(
        "gdsgegdsge${studentsData!.classId}  ====== ${studentsData!.sectionId}");

    try {
      final response = await http.get(
          Uri.parse(
              "${baseUrlName}Student/GetAllAssignmentDetails?classid=${studentsData!.classId}&sectionid=${studentsData!.sectionId}"),
           headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          });

      if (response.statusCode == 200) {
        var homeWorkResponse = getHomeWorkModalClassFromJson(response.body);
        if (homeWorkResponse.responseCode == "200" &&
            homeWorkResponse.data!.isNotEmpty) {
          getHomeworkDataList.clear();
          for (var res in homeWorkResponse.data!) {
            getHomeworkDataList.add(res);
          }
          isHomeWorkDataFound.value = true;
          homeWorkProgress.value = false;
        } else if (homeWorkResponse.responseCode == "500") {
          homeWorkProgress.value = false;
          isHomeWorkDataFound.value = false;
          AppUtil.snackBar("Something went wrong");
        } else {
          homeWorkProgress.value = false;
          isHomeWorkDataFound.value = false;
        }
      } else if (response.statusCode == 401) {
        isHomeWorkDataFound.value = false;
        homeWorkProgress.value = false;
        AppUtil.showAlertDialog(onPressed: () {
          Get.back();
          box.remove('accessToken');
          box.remove('isUserLogin');
          box.remove('userRole');
          Get.offAll(() => const LoginPage());
        });
      } else {
        homeWorkProgress.value = false;
        isHomeWorkDataFound.value = false;
        AppUtil.snackBar('Something went wrong');
      }
    } catch (error) {
      isHomeWorkDataFound.value = false;
      homeWorkProgress.value = true;
      AppUtil.snackBar('$error');
    }
    update();
  }
}
