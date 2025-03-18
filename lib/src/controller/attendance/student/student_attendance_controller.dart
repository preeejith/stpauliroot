import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/dashboard/dashBoard_controller.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceModalClass.dart';
import 'package:iroots/src/modal/home/student/studentDetails.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class StudentAttendanceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  

  final List<String> yearTabs = [
    "2018-2019",
    "2019-2020",
    "2020-2021",
    "2021-2022",
    "2022-2023",
    "2023-2024",
    "2024-2025"
  ];

  final colorList = <Color>[
    Colors.green,
    Colors.red,
  ];

  String? fromYear = "2018";
  String? toYear = "2019";
  Student? studentsData;
  RxBool showProgress = false.obs;
  RxBool isDataFound = false.obs;
  final GetStorage box = Get.put(GetStorage());
  TabController? tabController;
  Datum? studentData;
  StudentAttendance? studentAttendance;
  Map<String, double> graphData = {};
  String? accessToken;

  @override
  void onInit() {
    accessToken = box.read("accessToken");

    studentsData = Get.arguments;
    getStudentAttendance();
    tabController = TabController(vsync: this, length: yearTabs.length);
    super.onInit();
  }

  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }

  Future<void> getStudentAttendance() async {
    _showProgress();

    try {
      Map<String, String> credentials = {
        'classId': studentsData!.classId.toString(),
        'sectionId': studentsData!.sectionId.toString(),
        'fromDate': "01/04/$fromYear",
        'toDate': "31/03/$toYear",
        'studentId': studentsData!.studentId.toString(),
      };

      String jsonCredentials = jsonEncode(credentials);

      final response = await http.post(
        Uri.parse("${baseUrlName}Attendance/ViewStudentAttendance"),
         headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        body: jsonCredentials,
      );

      if (response.statusCode == 200) {
        studentAttendance = studentAttendanceFromJson(response.body);
        if (studentAttendance!.responseCode == "200" &&
            studentAttendance!.data.isNotEmpty) {
          studentData = studentAttendance!.data[0];

          graphData.clear();
          graphData["${studentData!.attendancePer} Present"] =
              double.parse(studentData!.attendancePer!.replaceFirst("%", ""));
          graphData["${studentData!.absentPer} Absent"] =
              double.parse(studentData!.absentPer!.replaceFirst("%", ""));
          _hideProgress();
          isDataFound.value = true;
        } else if (studentAttendance!.responseCode == "500") {
          _emptyGraphData();
          _hideProgress();
          isDataFound.value = false;
          AppUtil.snackBar("Something went wrong");
        } else {
          _emptyGraphData();
          _hideProgress();
          isDataFound.value = false;
        }
      } else if (response.statusCode == 401) {
        _emptyGraphData();
        _hideProgress();
        AppUtil.showAlertDialog(onPressed: () {
          Get.back();
          box.remove('accessToken');
          box.remove('isUserLogin');
          box.remove('userRole');
          Get.offAll(() => const LoginPage());
        });
      } else {
        _emptyGraphData();
        _hideProgress();
        isDataFound.value = false;
        AppUtil.snackBar('Something went wrong');
      }
    } catch (error) {
      _emptyGraphData();
      _hideProgress();
      isDataFound.value = false;
      AppUtil.snackBar('$error');
    }
  }

  void getCurrentYear(int index) {
    fromYear = yearTabs[index].split('-')[0].trim();
    toYear = yearTabs[index].split('-')[1].trim();
    getStudentAttendance();
  }

  void _showProgress() {
    showProgress.value = true;
  }

  void _hideProgress() {
    showProgress.value = false;
  }

  void _emptyGraphData() {
    graphData.clear();
    graphData[""] = 0;
  }
}
