import 'dart:convert';

// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/src/service/handler/api_handler.dart';
import 'package:iroots/src/service/handler/api_url.dart';
import 'package:iroots/src/service/model/get_batch_model.dart';
import 'package:iroots/src/service/model/get_class_model.dart';
import 'package:iroots/src/service/model/get_section_model.dart';
import 'package:iroots/src/service/model/get_term_model.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/app_snackbar.dart';
import 'package:iroots/src/utility/network_info.dart';
import 'package:http/http.dart' as http;

class AdminReportCardController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showLoading = false.obs;
  RxString accessToken = "".obs;
  final GetStorage box = Get.put(GetStorage());

  /// Class

  RxList<ClassModel> classList = <ClassModel>[].obs;
  Rx<ClassModel> selectedClass = ClassModel().obs;
  TextEditingController classController = TextEditingController();

  getClassList({required bool showLoader}) async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        if (showLoader) {
          isLoading.value = true;
        } else {
          showLoading.value = true;
        }
        batchController.clear();
        classController.clear();
        sectionController.clear();
        termController.clear();
        selectedClass = ClassModel().obs;
        classList.clear();
        sectionList.clear();
        selectedSection = SectionModel().obs;
        selectedTerm = TermModel().obs;
        termList.clear();
        // subject.clear();
        // studentList.clear();

        http.Response response = await ApiHandler.post(
          url: '${ApiUrls.baseUrl}${ApiUrls.getClass}?staff_Id=',
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getClassModelFromMap(response.body);
          for (var element in decoded.data!) {
            classList.add(element);
          }
          showLoading.value = false;
          isLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          showLoading.value = false;
          isLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          isLoading.value = false;
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        isLoading.value = false;
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      isLoading.value = false;
      showLoading.value = false;
      toast(e.toString(), false);
    }
  }

  /// Section

  RxList<SectionModel> sectionList = <SectionModel>[].obs;
  Rx<SectionModel> selectedSection = SectionModel().obs;
  TextEditingController sectionController = TextEditingController();

  getSectionList() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        batchController.clear();
        sectionController.clear();
        termController.clear();
        selectedSection = SectionModel().obs;
        showLoading.value = true;
        sectionList.clear();
        selectedTerm = TermModel().obs;
        termList.clear();
        // subject.clear();
        // studentList.clear();

        http.Response response = await ApiHandler.get(
          url:
              '${ApiUrls.baseUrl}${ApiUrls.getSection}?classId=${selectedClass.value.dataListItemId.toString()}',
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getSectionModelFromMap(response.body);
          for (var element in decoded.data!) {
            sectionList.add(element);
          }
          showLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          showLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      showLoading.value = false;
      toast(e.toString(), false);
    }
  }

  /// Get Term

  RxList<TermModel> termList = <TermModel>[].obs;
  Rx<TermModel> selectedTerm = TermModel().obs;
  TextEditingController termController = TextEditingController();

  getTermList() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        batchController.clear();
        termController.clear();
        showLoading.value = true;
        selectedTerm = TermModel().obs;
        termList.clear();
        // subject.clear();
        // studentList.clear();

        http.Response response = await ApiHandler.get(
          url: '${ApiUrls.baseUrl}${ApiUrls.getTerm}',
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getTermModelFromMap(response.body);
          for (var element in decoded.data!) {
            termList.add(element);
          }
          showLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          showLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      showLoading.value = false;
      toast(e.toString(), false);
    }
  }

  /// Get Batch

  RxList<BatchModel> batchList = <BatchModel>[].obs;
  Rx<BatchModel> selectedBatch = BatchModel().obs;
  TextEditingController batchController = TextEditingController();

  getBatchList() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        batchController.clear();
        showLoading.value = true;
        selectedBatch = BatchModel().obs;
        batchList.clear();
        // subject.clear();
        // studentList.clear();
        http.Response response = await ApiHandler.get(
          url: '${ApiUrls.baseUrl}${ApiUrls.getBatch}',
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getBatchModelFromMap(response.body);
          for (var element in decoded.data!) {
            batchList.add(element);
          }
          showLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          showLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      showLoading.value = false;
      toast(e.toString(), false);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getData();
  }

  getData() {
    accessToken.value = box.read("accessToken");
    // if (fromAdmin) {
    //   getStaffList();
    // } else {
    // selectedStaff = StaffModel(
    //   stafId: staffId?.staffid ?? "",
    //   name: staffId?.name ?? "",
    // ).obs;
    getClassList(showLoader: true);
    // }
  }
}
