import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/home/staff/staff_home_controller.dart';
import 'package:iroots/src/modal/attendance/showStudentAttendanceModalClass.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceByStaffModalClass.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class StaffReportCardController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  final staffHomeWorkController = Get.put(StaffHomeController());

  final String _currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String? _currentDay;
  String _selectedDateFromCalender =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
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
        Uri.parse(
            "${baseUrlName}Attendance/StudentAttendenceForCreation"),
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

      print("svsgbegbegb${response.statusCode}");

      if (response.statusCode == 200) {
        print("wgergerge${response.body}");

        var studentAttendance =
            studentAttendanceByStaffModalClassFromJson(response.body);

        print("wgergerge${studentAttendance.responseCode}");

        if (studentAttendance.responseCode == "201") {
          saveAttenShowProgress.value = false;
          Get.back();
          AppUtil.snackBar("Add attendance successfully");
        } else if (studentAttendance.responseCode == "500") {
          saveAttenShowProgress.value = false;
          AppUtil.snackBar("Something went wrong");
        } else if (studentAttendance.responseCode == "400") {
          saveAttenShowProgress.value = false;
          AppUtil.snackBar("Something went wrong.Please try again later.");
        } else {
          saveAttenShowProgress.value = false;
          AppUtil.snackBar(studentAttendance.msg);
          print("sdgwegeg${studentAttendance.msg}");
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
      print("sdgwegeg${error}");
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

  showMoreBottomSheet() {
    return Get.bottomSheet(
      backgroundColor: Colors.white,
      SizedBox(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bottomSheetWidget(
                () {}, "assets/icons/report/icon_download.svg", "Download"),
            const Divider(
              color: Color(0xff94A3B8),
              thickness: 0.8,
            ),
            bottomSheetWidget(
                () {}, "assets/icons/report/icon_freezing.svg", "Freezing"),
            const Divider(
              color: Color(0xff94A3B8),
              thickness: 0.8,
            ),
            bottomSheetWidget(
                () {}, "assets/icons/report/icon_publish.svg", "Publish"),
          ],
        ),
      ),
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(width: 1, color: Colors.grey)),
      enableDrag: false,
    );
  }

  Widget bottomSheetWidget(void Function()? onTap, String icon, String title) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(
            width: 5,
          ),
          AppUtil.customText(
            textAlign: TextAlign.center,
            text: title,
            style: const TextStyle(
                color: Color(0xff1575FF),
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
