import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/bloc/bloclocalstorage/prefmanager.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/dashboard/dashBoard_controller.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceModalClass.dart';
import 'package:iroots/src/modal/dashboardModalClass.dart';
import 'package:iroots/src/modal/home/student/studentDetails.dart';
import 'package:iroots/src/modal/selection_popup_model.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/ui/dashboard/attendance/student/student_attendence.dart';
import 'package:iroots/src/ui/dashboard/attendance/student/studentattendance.dart';
import 'package:iroots/src/ui/dashboard/homework/student/student_homework.dart';
import 'package:iroots/src/ui/dashboard/payment/student_payment.dart';
import 'package:iroots/src/ui/dashboard/result/showstudentgrade.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:path/path.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentHomeController extends GetxController {
  final GetStorage box = Get.put(GetStorage());

  Student? studentData;
  Datum? studentAttendanceData;

  DateTime? rangeStart;
  DateTime? rangeEnd;
  RxBool isAttendanceDataFound = false.obs;
  DateTime? selectedDay;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<RangeSelectionMode> rangeSelectionMode = RangeSelectionMode.toggledOn.obs;
  SelectionPopupModel? selectedStaff;
  SelectionPopupModel? selectedClass;
  SelectionPopupModel? selectedSelection;
  RxBool showProgress = false.obs;
  Student? studentsData;
  String? currentDate;
  String? currentYear;
  String? accessToken;
  var namestudent = "";
  String? studentnamedashboard = "";
  Map<String, double> graphData = {};
  String? userRole;

  @override
  void onInit() {
    userRole = box.read("userRole");
    studentsData = Get.arguments;
    accessToken = box.read("accessToken");
    currentYear = DateTime.now().year.toString();

    currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());

    userRole == "Student" ? fetchStudentDetails() : "";
    super.onInit();

    _fetchstudentName();
  }

  _fetchstudentName() async {
    studentnamedashboard = await PrefManager.getName();
  }

  final List<DashBoardModal> studentAcademicList = [
    DashBoardModal(
      title: "Payment",
      // image: "assets/icons/academicIcons/academics_payment_icon.svg"),
      image: "assets/new/payment1.png",
    ),
    DashBoardModal(
      title: "Attendance",
      // image: "assets/icons/academicIcons/academics_attendance_icon.svg"),
      image: "assets/new/attendance1.png",
    ),
    DashBoardModal(
      title: "Result",
      // image: "assets/icons/academicIcons/academics_result_icon.svg"),
      image: "assets/new/exam1.png",
    ),
    DashBoardModal(
      title: "Homework",
      image: "assets/new/homework1.png",
    ),
    // image: "assets/icons/academicIcons/academics_home_icon.svg"),
    DashBoardModal(
      title: "Library",
      image: "assets/new/library1.png",
    ),
    // image: "assets/icons/academicIcons/academics_library_icon.svg"),
    DashBoardModal(
      title: "Time Table",
      image: "assets/new/timetable1.png",
    ),
    // image: "assets/icons/academicIcons/academics_time_table_icon.svg")
  ];

  final colorList = <Color>[
    Colors.green,
    Colors.red,
  ];

  void onItemTapped(int index, context) {
    switch (index) {
      case 0:
        Get.to(() => const PaymentScreen());
        break;
      case 1:
        Get.to(() => const StudentsAttendence(), arguments: studentData);
        // Get.to(() => const StudentAttendanceScreen(), arguments: studentData);
        break;
      case 3:
        Get.to(() => const StudentHomeworkScreen(), arguments: studentData);
        break;
      case 2:
        // Navigator.push(context,
        //     (MaterialPageRoute(builder: (context) => StudentGradeCard())));
        Get.to(() => const StudentGradeCard(), arguments: studentData);
        break;
      default:
        break;
    }
  }

  List<dynamic> getEventsForDay(DateTime day) {
    if (day.month == 1 && day.day == 26) {
      return ['Republic Day'];
    } else if (day.month == 8 && day.day == 15) {
      return ['Independence Day'];
    } else {
      return [];
    }
  }

//studentdatafetch
  Future<void> fetchStudentDetails() async {
    _showProgress();
    namestudent = await PrefManager.getName();
    try {
      String? sstudntId = "";
      String? classsId = "";
      String? sessionId = "";
      String jsonString1 = await PrefManager.getAdditionalInfo();

      String jsonstring2 = jsonString1;

      List<dynamic> studentList = jsonDecode(jsonstring2);

      sstudntId = studentList[0]["ApplicationNumber"].toString();
      classsId = studentList[0]["ClassId"].toString();
      sessionId = studentList[0]["SectionId"].toString();
      // Student? studentsData;
      // studentsData = Get.arguments;
      // print(studentsData!.classId.toString());
      // print("sgtwt3twtg${accessToken}");
      // log(accessToken);
      debugPrint(accessToken.toString());
      final response = await http.get(
        Uri.parse(
            "${baseUrlName}Student/GetStudentDetailsByClassSection?ClassId=$classsId&SectionId=$sessionId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var loginResponse = studentDetailsFromJson(response.body);

        var decodedResponse = jsonDecode(response.body);

        print("swgbsjdbjs$decodedResponse");

        if (loginResponse.responseCode == "200" &&
            loginResponse.data.isNotEmpty) {
          studentData = loginResponse.data[0]!;
          _sendDeviceToken(loginResponse.data[0]!.studentId);
          _getStudentAttendance();
        } else if (loginResponse.responseCode == "500") {
          _hideProgress();
          AppUtil.snackBar("Something went wrong");
        } else {
          _hideProgress();
          // AppUtil.snackBar(loginResponse.msg!);
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
        AppUtil.snackBar('Something went wrong');
      }
    } catch (error) {
      _hideProgress();
      AppUtil.snackBar('$error');
    }
  }

  Future<void> _getStudentAttendance() async {
    try {
      //viewattendnaceroute
      Map<String, String> credentials = {
        'classId': studentData!.classId.toString(),
        'sectionId': studentData!.sectionId.toString(),
        'fromDate': "01/01/$currentYear",
        'toDate': ConstClass.currentDate,
        'studentId': studentData!.studentId.toString(),
      };
      String jsonCredentials = jsonEncode(credentials);
      print("sdbhrgber$jsonCredentials");
      final response = await http.post(
        Uri.parse("${baseUrlName}Attendance/ViewStudentAttendance"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonCredentials,
      );
      print("jsonCredentials${response.statusCode}");
      if (response.statusCode == 200) {
        var studentAttendance = studentAttendanceFromJson(response.body);
        if (studentAttendance.responseCode == "200" &&
            studentAttendance.data.isNotEmpty) {
          studentAttendanceData = studentAttendance.data[0];

          graphData["${studentAttendanceData!.attendancePer} Present"] =
              double.parse(
                  studentAttendanceData!.attendancePer!.replaceFirst("%", ""));
          studentAttendanceData!.absentPer == null
              ? ""
              : graphData["${studentAttendanceData!.absentPer} Absent"] =
                  double.parse(
                      studentAttendanceData!.absentPer!.replaceFirst("%", ""));

          isAttendanceDataFound.value = true;
          _hideProgress();
        } else if (studentAttendance.responseCode == "500") {
          isAttendanceDataFound.value = false;
          AppUtil.snackBar("Something went wrong");
          _hideProgress();
        } else {
          isAttendanceDataFound.value = false;
          _hideProgress();
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
        isAttendanceDataFound.value = false;
        AppUtil.snackBar('Something went wrong');
        _hideProgress();
      }
    } catch (error) {
      print("sbsegebwe$error");
      isAttendanceDataFound.value = false;
      AppUtil.snackBar('$error');
      _hideProgress();
    }

    update();
  }

  void _hideProgress() {
    showProgress.value = false;
  }

  void _showProgress() {
    showProgress.value = true;
  }

  Future<void> _sendDeviceToken(int? studentId) async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();

      Map<String, String> credentials = {
        'userId': studentId.toString(),
        'token': token!,
      };

      String jsonCredentials = jsonEncode(credentials);
      print("gwgeggerg$jsonCredentials");

      final response = await http.post(
        Uri.parse("${baseUrlName}UserCredentials/SendDeviceTokenData"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonCredentials,
      );
      print("sgegegegege${response.statusCode}");
      if (response.statusCode == 200) {}
    } catch (error) {
      print("sbsegebwe$error");
      isAttendanceDataFound.value = false;
    }
  }
}
