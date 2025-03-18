import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/home/staff/staff_home_controller.dart';
import 'package:iroots/src/modal/attendance/showStudentAttendanceModalClass.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceByStaffModalClass.dart';
import 'package:iroots/src/modal/home/staff/staffDetails.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class StaffAttendanceController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  final staffHomeWorkController = Get.put(StaffHomeController());

  final String _currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String? _currentDay;
  String _selectedDateFromCalender =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  Rx<StaffDetail> staffDetail = StaffDetail().obs;
  List<StudentAttendanceByStaffDatum> dummyList = [];
  StudentAttendanceByStaffDatum? fullAttendance;
  StudentAttendanceByStaffDatum? halfAttendance;
  StudentAttendanceByStaffDatum? othersAttendance;
  RxBool showProgress = false.obs;
  RxBool saveAttenShowProgress = false.obs;
  RxBool isDataFound = false.obs;
  RxBool isFirstTime = true.obs;
  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();
  DateTime _selectedDate = DateTime.now();

  String? accessToken;

  @override
  void onInit() {
    accessToken = box.read("accessToken");
    // Get.put(StaffHomeController());
    // showStudentAttendance();

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

  void showStudentAttendance(String? classId, String? sectionId) {
    DateTime selectedDate =
        DateFormat('dd/MM/yyyy').parse(_selectedDateFromCalender);
    DateTime currentDate = DateFormat('dd/MM/yyyy').parse(_currentDate);
    _currentDay = DateFormat('EEEE')
        .format(DateFormat('dd/MM/yyyy').parse(_selectedDateFromCalender));

    if (selectedDate.isAfter(currentDate)) {
      AppUtil.snackBar("Please select a past or today's date.");
      return;
    }

    _showStudentAtten(classId, sectionId);

    // _studentMarkAttendance();
  }

  _studentMarkAttendance() {
    isFirstTime.value = true;
  }

  Future<void> _showStudentAtten(String? classId, String? sectionId) async {
    isFirstTime.value = false;
    _showProgress();
//attendancedatashowing
    try {
      Map<String, String> credentials = {};

      // Map<String, String> credentials = {
      //   "classId": "615",
      //   "sectionId": "23",
      //   "toDate": ConstClass.currentDate,
      // };
      // Map<String, String> credentials = {
      //   // "classId":
      //   //     staffHomeWorkController.staffClass!.dataListItemId.toString(),
      //   // "sectionId":
      //   //     staffHomeWorkController.staffSection!.dataListItemId.toString(),
      //   // "toDate": _selectedDateFromCalender,
      //   "attendanceId": "723408",
      //   "classId": "207",
      //   "sectionId": "24",
      //   "className": "Class-Nursery",
      //   "sectionName": "GREEN",
      //   "markFullDayAbsent": "false",
      //   "markHalfDayAbsent": "true",
      //   "studentRegisterId": "2426",
      //   "studentName": "VINAYAK MANDOR",
      //   "createdDate": "04/02/2025",
      //   "day": "Monday",
      //   "createdBy": "admin",
      //   "others": "False"
      // };

      String jsonCredentials = jsonEncode(credentials);

      http.Response response = await http.get(
        Uri.parse(
            "${baseUrlName}Student/GetStudentDetailsByClassSection?ClassId=$classId&SectionId=$sectionId"
            // "${baseUrlName}Attendance/StudentAttendenceForCreation"

            ),
        // "${baseUrlName}Attendance/EditStudentAttendance"),
        //https://stpaulapi.lumensof.in/api/Student/GetStudentDetailsByClassSection?ClassId=615&SectionId=23
        // "${baseUrlName}Student/GetStudentDetailsByClassSection?ClassId=615&SectionId=23"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        // body: jsonCredentials,
      );

      log("${baseUrlName}Student/GetStudentDetailsByClassSection?ClassId=$classId&SectionId=$sectionId");
      log(jsonCredentials.toString());
      if (response.statusCode == 200) {
        var useridcreated = box.read("userId");
        var studentAttendance =
            showStudentAttendanceModalClassFromJson(response.body);
        if (studentAttendance.responseCode == "200" &&
            studentAttendance.data!.isNotEmpty) {
          List<ShowStudentAttendanceDatum> studentAttendanceDatList = [];
          studentAttendanceDatList.clear();
          dummyList.clear();

          studentAttendanceDatList.addAll(studentAttendance.data!);
          dummyList.addAll(studentAttendanceDatList
              .where((student) => student.isApplyforTc != true)
              .map((student) => StudentAttendanceByStaffDatum(
                    className: student.datumClass,
                    classId: student.classId,
                    markFullDayAbsent: "False",
                    markHalfDayAbsent: "False",
                    others: "False",
                    createdBy: useridcreated.toString(),
                    createdDate: _selectedDateFromCalender,
                    attendanceId: 0,
                    day: _currentDay,
                    sectionId: student.sectionId,
                    sectionName: student.section == null
                        ? ""
                        : student.section.toString(),
                    studentName: student.name,
                    studentRegisterId: student.studentId,
                  ))
              .toList());

// Sorting dummyList based on studentName in alphabetical order
          dummyList.sort((a, b) => a.studentName!
              .toLowerCase()
              .compareTo(b.studentName!.toLowerCase()));
          //march4
          // studentAttendanceDatList.addAll(studentAttendance.data!);
          // dummyList.addAll(studentAttendanceDatList
          //     .where((student) => student.isApplyforTc != true)
          //     .map((student) => StudentAttendanceByStaffDatum(
          //           className: student.datumClass,
          //           classId: student.classId,
          //           markFullDayAbsent: "False",
          //           markHalfDayAbsent: "False",
          //           others: "False",
          //           createdBy: useridcreated.toString(),
          //           createdDate: _selectedDateFromCalender,
          //           attendanceId: 0,
          //           day: _currentDay,
          //           sectionId: student.sectionId,
          //           sectionName: student.section == null
          //               ? ""
          //               : student.section.toString(),
          //           studentName: student.name,
          //           studentRegisterId: student.studentId,
          //         ))
          //     .toList());
//////2222
          // for (var myData in studentAttendanceDatList) {
          //   dummyList.add(StudentAttendanceByStaffDatum(
          //       className: myData.datumClass,
          //       classId: myData.classId,
          //       markFullDayAbsent: "False",
          //       markHalfDayAbsent: "False",
          //       others: "False",
          //       createdBy: useridcreated.toString(),
          //       createdDate: _selectedDateFromCalender,
          //       attendanceId: 0,
          //       day: _currentDay,
          //       sectionId: myData.sectionId,
          //       sectionName: myData.section.toString(),
          //       studentName: myData.name,
          //       studentRegisterId: myData.studentId));
          // }

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
//createdbychange
    try {
      String jsonCredentials = jsonEncode(dummyList);
      final response = await http.post(
        // Uri.parse("${baseUrlName}Attendance/SaveStudentAttendance"),
        Uri.parse("${baseUrlName}Attendance/StudentAttendance"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonCredentials,
      );
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      print("svsgbegbegb${response.statusCode}");
      print(responseJson['responseCode'].toString());
      if (response.statusCode == 200) {
        print("wgergerge${response.body}");
        // print(response.body['']);

        // var studentAttendance =
        //     studentAttendanceByStaffModalClassFromJson(response.body);

        print("wgergerge${responseJson['responseCode'].toString()}");

        if (responseJson['responseCode'].toString() == "201") {
          saveAttenShowProgress.value = false;
          // Get.back();
          AppUtil.snackBar("Add attendance successfully");
        } else if (responseJson['responseCode'].toString() == "500") {
          saveAttenShowProgress.value = false;
          AppUtil.snackBar("Something went wrong");
        } else if (responseJson['responseCode'].toString() == "400") {
          saveAttenShowProgress.value = false;
          AppUtil.snackBar("Something went wrong.Please try again later.");
        } else {
          saveAttenShowProgress.value = false;
          AppUtil.snackBar(responseJson['responseCode'].toString());
          print("sdgwegeg${responseJson['responseCode'].toString()}");
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
      print("sdgwegeg$error");
    }
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
