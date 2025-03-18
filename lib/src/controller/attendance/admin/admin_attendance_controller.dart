import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/dashboard/dashBoard_controller.dart';
import 'package:iroots/src/modal/attendance/classModalClass.dart';
import 'package:iroots/src/modal/attendance/showStudentAttendanceModalClass.dart';
import 'package:iroots/src/modal/attendance/staffModalClass.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceByStaffModalClass.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class AdminAttendanceController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  final dashBoardController = Get.put(DashBoardController());
  StaffData? selectedStaff;
  final String _currentDay = DateFormat('EEEE').format(DateTime.now());
  StudentAttendanceByStaffDatum? fullAttendance;
  StudentAttendanceByStaffDatum? halfAttendance;
  StudentAttendanceByStaffDatum? othersAttendance;
  String _selectedDateFromCalender =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  List<StudentAttendanceByStaffDatum> dummyList = [];
  RxBool showProgress = false.obs;
  RxBool saveAttenShowProgress = false.obs;
  RxBool isDataFound = false.obs;
  RxBool isFirstTime = true.obs;
  RxBool isstaffdropDownProgress = false.obs;
  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  DateTime _selectedDate = DateTime.now();
  String className = "Select Class";
  String sectionName = "Select Section";
  String? classId;
  String? sectionId;
  String? accessToken;

  @override
  void onInit() {
    accessToken = box.read("accessToken");
    showStudentAttendance();
    super.onInit();
  }

  String formatDate() {
    return DateFormat('dd-MMM-yyyy').format(_selectedDate);
  }

  void pickDateDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      _selectedDate = pickedDate;
      _selectedDateFromCalender =
          DateFormat('dd/MM/yyyy').format(_selectedDate);
      update();
    });
  }

  Future<void> getClass() async {
    try {
      final response = await http.get(
          Uri.parse(
              "${baseUrlName}UserCredentials/GetStaffClass?staffId=${selectedStaff!.staffId}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          });
      if (response.statusCode == 200) {
        var classResponse = classModalClassFromJson(response.body);
        if (classResponse.responseCode == "200" &&
            classResponse.data.isNotEmpty) {
          className = classResponse.data[0].dataListItemName;
          classId = classResponse.data[0].dataListItemId.toString();
          getSection();
        } else {
          className = "Select Class";
          classId = "0";
          sectionName = "Select Section";
          sectionId = "0";
        }
      }
    } catch (error) {
      debugPrint("$error");
    }
    update();
  }

  Future<void> getSection() async {
    try {
      final response = await http.get(
          Uri.parse(
              "${baseUrlName}UserCredentials/GetClassSection?staffId=${selectedStaff!.staffId}&classId=$classId"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          });

      if (response.statusCode == 200) {
        var sectionResponse = classModalClassFromJson(response.body);
        if (sectionResponse.responseCode == "200" &&
            sectionResponse.data.isNotEmpty) {
          sectionName = sectionResponse.data[0].dataListItemName;
          sectionId = sectionResponse.data[0].dataListItemId.toString();
        }
      }
    } catch (error) {
      debugPrint("$error");
    }
    update();
  }

  void showStudentAttendance() {
    if (selectedStaff == null) {
      AppUtil.snackBar('Please select staff');
      return;
    }
    _showStudentAtten();
  }

  Future<void> _showStudentAtten() async {
    isFirstTime.value = false;
    _showProgress();

    try {
      Map<String, String> credentials = {
        "classId": classId.toString(),
        "sectionId": sectionId.toString(),
        "toDate": _selectedDateFromCalender,
      };

      String jsonCredentials = jsonEncode(credentials);
      http.Response response = await http.post(
        Uri.parse("${baseUrlName}Attendance/StudentAttendenceForCreation"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonCredentials,
      );

      if (response.statusCode == 200) {
        var studentAttendance =
            showStudentAttendanceModalClassFromJson(response.body);
        if (studentAttendance.responseCode == "201" &&
            studentAttendance.data!.isNotEmpty) {
          List<ShowStudentAttendanceDatum> studentAttendanceDatList = [];
          studentAttendanceDatList.clear();
          dummyList.clear();
          studentAttendanceDatList.addAll(studentAttendance.data!);
          for (var myData in studentAttendanceDatList) {
            dummyList.add(StudentAttendanceByStaffDatum(
                className: myData.datumClass,
                classId: myData.classId,
                markFullDayAbsent: "False",
                markHalfDayAbsent: "False",
                others: "False",
                createdBy: selectedStaff!.staffId.toString(),
                createdDate: ConstClass.currentDate,
                attendanceId: 0,
                day: _currentDay,
                sectionId: 0,
                sectionName: myData.sectionId.toString(),
                studentName: myData.name,
                studentRegisterId: myData.sectionId));
          }

          isDataFound.value = true;
          _hideProgress();
        } else if (studentAttendance.responseCode == "500") {
          _hideProgress();
          isDataFound.value = false;
          AppUtil.snackBar("Something went wrong");
        } else {
          _hideProgress();
          isDataFound.value = false;
        }
      } else if (response.statusCode == 401) {
        _hideProgress();
        AppUtil.showAlertDialog(onPressed: () {
          Get.back();
          box.remove('accessToken');
          box.remove('isUserLogin');
          box.remove('userRole');
          Get.offAll(() => const LoginPage());
        });
      } else {
        _hideProgress();
        isDataFound.value = false;
        AppUtil.snackBar('Something went wrong');
      }
    } catch (error) {
      _hideProgress();
      isDataFound.value = false;
      AppUtil.snackBar('$error');
    }

    update();
  }

  Future<void> saveAttendance() async {
    saveAttenShowProgress.value = true;

    try {
      String jsonCredentials = jsonEncode(dummyList);
      final response = await http.post(
        Uri.parse("${baseUrlName}Attendance/SaveStudentAttendance"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonCredentials,
      );
      if (response.statusCode == 200) {
        var studentAttendance =
            studentAttendanceByStaffModalClassFromJson(response.body);

        if (studentAttendance.responseCode == "201") {
          saveAttenShowProgress.value = false;
          Get.back();
          AppUtil.snackBar("Add attendance successfully");
        } else if (studentAttendance.responseCode == "500") {
          saveAttenShowProgress.value = false;
          AppUtil.snackBar("Something went wrong");
        } else {
          AppUtil.snackBar(studentAttendance.msg!);
          saveAttenShowProgress.value = false;
        }
      } else if (response.statusCode == 401) {
        saveAttenShowProgress.value = false;
        AppUtil.showAlertDialog(onPressed: () {
          Get.back();
          box.remove('accessToken');
          box.remove('isUserLogin');
          box.remove('userRole');
          Get.offAll(() => const LoginPage());
        });
      } else {
        saveAttenShowProgress.value = false;

        AppUtil.snackBar('Something went wrong');
      }
    } catch (error) {
      saveAttenShowProgress.value = false;
      AppUtil.snackBar('$error');
    }

    update();
  }

  void _showProgress() {
    showProgress.value = true;
  }

  void _hideProgress() {
    showProgress.value = false;
  }

  void markAllFullAttendance() {
    for (var allAttendance in dummyList) {
      allAttendance.markFullDayAbsent =
          (allAttendance.markFullDayAbsent == "False") ? "True" : "False";
      fullAttendance = allAttendance;
    }

    update();
  }

  void markAllHalfAttendance() {
    for (var allAttendance in dummyList) {
      allAttendance.markHalfDayAbsent =
          (allAttendance.markHalfDayAbsent == "False") ? "True" : "False";
      halfAttendance = allAttendance;
    }

    update();
  }

  void markAllOthersAttendance() {
    for (var allAttendance in dummyList) {
      allAttendance.others =
          (allAttendance.others == "False") ? "True" : "False";
      othersAttendance = allAttendance;
    }

    update();
  }

  void markFullAttendance(StudentAttendanceByStaffDatum item) {
    item.markFullDayAbsent =
        (item.markFullDayAbsent == "False") ? "True" : "False";
    update();
  }

  void markHalfAttendance(StudentAttendanceByStaffDatum item) {
    item.markHalfDayAbsent =
        (item.markHalfDayAbsent == "False") ? "True" : "False";
    update();
  }

  void markOtherAttendance(StudentAttendanceByStaffDatum item) {
    item.others = (item.others == "False") ? "True" : "False";
    update();
  }
}
