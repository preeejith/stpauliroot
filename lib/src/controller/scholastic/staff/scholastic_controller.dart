import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/home/staff/staff_home_controller.dart';
import 'package:iroots/src/modal/attendance/showStudentAttendanceModalClass.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceByStaffModalClass.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/util.dart';

enum Scholastic { radioA, radioB, radioC }

class ScholasticController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  RxBool showProgress = false.obs;
  final staffHomeWorkController = Get.put(StaffHomeController());
  final String _currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String? _currentDay;
  String _selectedDateFromCalender =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  List<StudentAttendanceByStaffDatum> dummyList = [];
  String? accessToken;
  DateTime _selectedDate = DateTime.now();
  RxBool isFirstTime = true.obs;
  RxBool isDataFound = false.obs;
  bool isNotesOpen = false;
  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();
  StudentAttendanceByStaffDatum? fullAttendance;
  StudentAttendanceByStaffDatum? halfAttendance;
  StudentAttendanceByStaffDatum? othersAttendance;

  Widget radioWidget(String radioTitle, Scholastic currentRadio,
      Null Function(dynamic newValue) radioChanged) {
    return Row(
      children: [
        Radio(
          value: Scholastic.radioA,
          groupValue: currentRadio,
          onChanged: radioChanged,
        ),
        AppUtil.customText(
          text: radioTitle,
          style: const TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  void onInit() {
    accessToken = box.read("accessToken");

    showStudentAttendance();
    super.onInit();
  }

  String formatDate() {
    return DateFormat('dd-MMM-yyyy').format(_selectedDate);
  }

  void showStudentAttendance() {
    DateTime selectedDate =
        DateFormat('dd/MM/yyyy').parse(_selectedDateFromCalender);
    DateTime currentDate = DateFormat('dd/MM/yyyy').parse(_currentDate);
    _currentDay = DateFormat('EEEE')
        .format(DateFormat('dd/MM/yyyy').parse(_selectedDateFromCalender));

    if (selectedDate.isAfter(currentDate)) {
      AppUtil.snackBar("Please select a past or today's date.");
      return;
    }

    _showStudentAtten();
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

  Future<void> _showStudentAtten() async {
    isFirstTime.value = false;
    _showProgress();

    try {
      Map<String, String> credentials = {};
      // Map<String, String> credentials = {
      //   "classId":
      //       staffHomeWorkController.staffClass!.dataListItemId.toString(),
      //   "sectionId":
      //       staffHomeWorkController.staffSection!.dataListItemId.toString(),
      //   "toDate": _selectedDateFromCalender,
      // };

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
                // createdBy:
                //     staffHomeWorkController.staffDetails!.stafId.toString(),
                createdDate: _selectedDateFromCalender,
                attendanceId: 0,
                day: _currentDay,
                sectionId: myData.sectionId,
                sectionName: myData.section.toString(),
                studentName: myData.name,
                studentRegisterId: myData.studentId));
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

  void _showProgress() {
    showProgress.value = true;
  }

  void _hideProgress() {
    showProgress.value = false;
  }

  void isDropDownOpen() {
    isNotesOpen = !isNotesOpen;
    update();
  }
}
