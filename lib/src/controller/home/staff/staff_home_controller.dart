import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceModalClass.dart';
import 'package:iroots/src/modal/dashboardModalClass.dart';
import 'package:iroots/src/modal/home/staff/staffDetails.dart';
import 'package:iroots/src/modal/home/staff/staffsectionmodel.dart';
import 'package:iroots/src/service/handler/api_handler.dart';
import 'package:iroots/src/service/handler/api_url.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/ui/dashboard/admin/admin_coscholastic/admin_coscholastic_screen.dart';
import 'package:iroots/src/ui/dashboard/admin/fill_marks/admin_fill_marks.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/staff_attendence.dart';
import 'package:iroots/src/ui/dashboard/homework/staff/staff_homework.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/network_info.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:table_calendar/table_calendar.dart';

class StaffHomeController extends GetxController {
  final GetStorage box = Get.put(GetStorage());

  String staffId = "";
  String dataItemName = "";
  String? dataItemId = "";
  Rx<StaffDetail> staffDetail = StaffDetail().obs;

  // Staff? staffClass;
  StaffClassModel? staffClassmodel;
  StaffSectionModel? staffSectionModel;
  // StaffDetails? staffDetails;
  // Staff? staffSection;
  DateTime? rangeStart;
  Datum? studentAttendanceData;
  DateTime? rangeEnd;
  RxBool isAttendanceDataFound = false.obs;
  DateTime? selectedDay;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<RangeSelectionMode> rangeSelectionMode = RangeSelectionMode.toggledOn.obs;
  RxBool showProgress = false.obs;
  String? currentDate;
  String? currentYear;
  String? accessToken;

  Map<String, double> graphData = {};

  @override
  void onInit() {
    accessToken = box.read("accessToken");
    // log()
    currentYear = DateTime.now().year.toString();
    currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    fetchStaffDetails();

    super.onInit();
  }

  final List<DashBoardModal> staffAcademicList = [
    DashBoardModal(
      title: "Fill Attendance",
      // image: "assets/icons/academicIcons/academics_attendance_icon.svg",
      image: "assets/new/attendance1.png",
    ),
    DashBoardModal(
      title: "Fill Marks",
      // image: "assets/icons/staff_icons/staff_fill_marks_icon.svg",
      image: "assets/new/exam1.png",
    ),
    DashBoardModal(
      title: "Fill Co-Scholastic",
      // image: "assets/icons/academicIcons/academics_fill_co_scholastic.svg",
      image: "assets/new/library1.png",
    ),
    DashBoardModal(
      title: "Homework",
      // image: "assets/icons/academicIcons/academics_home_icon.svg",
      image: "assets/new/homework1.png",
    ),
    DashBoardModal(
      title: "Time Table",
      // image: "assets/icons/academicIcons/academics_time_table_icon.svg",
      image: "assets/new/timetable1.png",
    ),
    DashBoardModal(
      title: "Payroll",
      image: "assets/new/payment1.png",
      // image: "assets/icons/staff_icons/staff_payroll_icon.svg",
    ),
  ];

  final colorList = <Color>[
    Colors.green,
    Colors.red,
  ];
//fillcolasticpage
  void onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.to(() => StaffAttendanceScreen(
              fromAdmin: false,
              staffDetail: staffDetail.value,
            ));
        break;
      case 1:
        Get.to(() => AdminFillMarksScreen(
              fromAdmin: false,
              staffDetail: staffDetail.value,
            ));

        break;
      case 2:
        Get.to(() => AdminCoScholasticScreen(
              fromAdmin: false,
              staffDetail: staffDetail.value,
            ));
        break;
      case 3:
        Get.to(() => const StaffHomeworkScreen());
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

  Future<void> fetchStaffDetails() async {
    http.Response response;
    _showProgress();

    try {
      response = await ApiHandler.get(
        url: '${ApiUrls.baseUrl}UserCredentials/GetStaffDetails',
        token: accessToken.toString(),
      );

      var decoded = jsonDecode(response.body);

      // log(decoded);

      // http.Response response = await ApiHandler.get(
      //   url: ApiUrls.baseUrl + ApiUrls.getStaffDetails,
      //   token: "$accessToken",
      // );
      // http.Response response = await ApiHandler.get(
      //   url: ApiUrls.baseUrl + ApiUrls.getStaffDetails,
      //   token: "$accessToken",
      // );

      //   var decoded = jsonDecode(response.body);

      log("${baseUrlName}UserCredentials/GetStaffDetails");
      if (response.statusCode == 200) {
        var loginResponse = staffDetailsModalFromMap(response.body);
        if (loginResponse.responseCode.toString() == "200") {
          if (loginResponse.data!.isNotEmpty) {
            if (loginResponse.data!.isNotEmpty) {
              staffDetail.value = loginResponse.data![0];
            }
          }

//fetching the dropdown data
          staffClassmodel =
              await _getstaffclass(loginResponse.data![0].staffid.toString());
          if (staffClassmodel != null) {
            for (int i = 0; i < staffClassmodel!.data!.length; i++) {
              if (staffClassmodel!.data![i].isClassTeacher == true) {
                dataItemName =
                    staffClassmodel!.data![i].dataListItemName.toString();
                dataItemId =
                    staffClassmodel!.data![i].dataListItemId.toString();
              }
            }
          }

          if (staffClassmodel != null) {
            staffSectionModel = await _getstaffSection(
                loginResponse.data![0].staffid.toString(), dataItemId);
            print("dnhj");
            if (staffSectionModel != null) {
              print(staffSectionModel!.data![0].dataListId);
            }
          }
          _hideProgress();
        } else if (loginResponse.responseCode == "500") {
          AppUtil.snackBar("Something went wrong");
          _hideProgress();
        } else {
          // AppUtil.snackBar(loginResponse.msg!);
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
        AppUtil.snackBar('Something went wrong');
        _hideProgress();
      }
    } catch (error) {
      AppUtil.snackBar('$error');
      _hideProgress();
    }
  }

//  getClassList({required bool showLoader}) async {
//     try {
//       bool connection = await NetworkInfo(
//         connectivity: Connectivity(),
//       ).isConnected();
//       if (connection) {
//         if (showLoader) {
//           isLoading.value = true;
//         } else {
//           showLoading.value = true;
//         }
//         batchController.clear();
//         classController.clear();
//         sectionController.clear();
//         termController.clear();
//         selectedClass = ClassModel().obs;
//         classList.clear();
//         sectionList.clear();
//         selectedSection = SectionModel().obs;
//         selectedTerm = TermModel().obs;
//         termList.clear();
//         subject.clear();
//         studentList.clear();

//         http.Response response = await ApiHandler.post(
//           url:
//               '${ApiUrls.baseUrl}${ApiUrls.getClass}?staff_Id=${selectedStaff.value.stafId.toString()}',
//           token: accessToken.value,
//         );

//         var decoded = jsonDecode(response.body);
//         if (response.statusCode == 200 ||
//             response.statusCode == 201 ||
//             response.statusCode == 202 ||
//             response.statusCode == 203 ||
//             response.statusCode == 204) {
//           var decoded = getClassModelFromMap(response.body);
//           for (var element in decoded.data!) {
//             classList.add(element);
//           }
//           showLoading.value = false;
//           isLoading.value = false;
//         } else if (response.statusCode == 401) {
//           // LocalStorage.clearData();
//           showLoading.value = false;
//           isLoading.value = false;

//           Get.offAll(() => const LoginPage());
//           toast(decoded['msg'], false);
//         } else {
//           isLoading.value = false;
//           showLoading.value = false;

//           toast(decoded['msg'], false);
//         }
//       } else {
//         isLoading.value = false;
//         showLoading.value = false;
//         toast("No Internet Connection!", false);
//       }
//     } catch (e) {
//       isLoading.value = false;
//       showLoading.value = false;
//       toast(e.toString(), false);
//     }
//   }

  void _showProgress() {
    showProgress.value = true;
  }

  _getstaffclass(String? staffId) async {
    // staffClassmodel

    final String url =
        'https://stpaulapi.lumensof.in/api/Exam/GetClassList?staff_Id=$staffId';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        // body: jsonEncode({'staff_Id': staffId}),
      );

      if (response.statusCode == 200) {
        return StaffClassModel.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  _getstaffSection(String? staffId, String? classId) async {
    // staffClassmodel
//edit2
    final String url =
        'https://stpaulapi.lumensof.in/api/Exam/GetSectionList?staffId=$staffId&classId=$classId';
    // https: //stmarysapi.lumensof.in/api/Exam/GetSectionList?staffId=105&classId=615

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        // body: jsonEncode({'staff_Id': staffId}),
      );

      if (response.statusCode == 200) {
        return StaffSectionModel.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  void _hideProgress() {
    showProgress.value = false;
  }
}
