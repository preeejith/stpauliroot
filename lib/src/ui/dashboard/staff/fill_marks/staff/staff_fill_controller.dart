import 'dart:convert';

// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/src/service/handler/api_handler.dart';
import 'package:iroots/src/service/handler/api_url.dart';
import 'package:iroots/src/service/model/get_staff_model.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/app_snackbar.dart';
import 'package:iroots/src/utility/network_info.dart';
import 'package:http/http.dart' as http;

class StaffFillController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  RxString accessToken = "".obs;
  RxString userId = "".obs;
  RxBool isLoading = false.obs;

  /// Staff

  RxList<StaffModel> staffList = <StaffModel>[].obs;
  Rx<StaffModel> selectedStaff = StaffModel().obs;

  getStaffList() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        isLoading.value = true;
        staffList.clear();

        http.Response response = await ApiHandler.get(
          url: ApiUrls.baseUrl + ApiUrls.getStaffList,
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getStaffModelFromMap(response.body);
          for (var element in decoded.data!) {
            staffList.add(element);
          }
          if (staffList.isNotEmpty) {
            if (staffList
                .where((e) => e.stafId.toString() == userId.value)
                .isNotEmpty) {
              selectedStaff.value = staffList
                  .firstWhere((e) => e.stafId.toString() == userId.value);
            }
          }
          isLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          isLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['message'], false);
        } else {
          isLoading.value = false;

          toast(decoded['message'], false);
        }
      } else {
        isLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      isLoading.value = false;
      toast(e.toString(), false);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getData();
  }

  getData() async {
    accessToken.value = await box.read("accessToken");
    userId.value =
        (await box.read("userId")) != null ? await box.read("userId") : "";
    getStaffList();
  }
}
