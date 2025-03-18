import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/dashboard/dashBoard_controller.dart';
import 'package:iroots/src/modal/attendance/staffModalClass.dart';
import 'package:iroots/src/modal/attendance/studentAttendanceModalClass.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

import '../../../modal/attendance/showStudentAttendanceModalClass.dart';

class AdminViewAttendanceController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  StaffData? selectedAdminStudent;
  StaffData? selectedAdminClass;
  StaffData? selectedAdminSection;
  RxBool showProgress = false.obs;
  final dashBoardController = Get.put(DashBoardController());

  RxBool saveAttenShowProgress = false.obs;
  RxBool isFirstTime = true.obs;
  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  List<StaffData> adminStudentDataList = [];
  DateTime _selectedDate = DateTime.now();
  Datum? studentData;
  List<Datum?> studentListData = [];
  List<Attendance?> attendance = [];
  RxBool isAttandanceDataFound = false.obs;
  String? selectedAssignmentDate =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  String? selectedSubmissionDate =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  List<String> allBetweenDates = [];
  bool isAdminStudent = false;
  String? accessToken;

  String formatDate() {
    return DateFormat('dd-MMM-yyyy').format(_selectedDate);
  }


  @override
  void onInit() {
    accessToken = box.read("accessToken");
    super.onInit();
  }

  void pickDateDialog(BuildContext context, int index) {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      _selectedDate = pickedDate;
      if (index == 0) {
        selectedAssignmentDate = DateFormat('dd/MM/yyyy').format(_selectedDate);
      } else {
        selectedSubmissionDate = DateFormat('dd/MM/yyyy').format(_selectedDate);
      }
      update();
    });
  }

  Future<void> getAdminStudents() async {
    isAdminStudent = true;

    if (selectedAdminClass != null && selectedAdminSection != null) {
      try {
        Map<String, String> credentials = {
          "classId": selectedAdminClass!.staffId.toString(),
          "sectionId": selectedAdminSection!.staffId.toString(),
          "toDate": ConstClass.currentDate,
        };

        /* Map<String, String> credentials = {
        "classId": "198",
        "sectionId": "23",
        "toDate": _currentDate,
      };
*/
        String jsonCredentials = jsonEncode(credentials);
        final response = await http.post(
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
            adminStudentDataList.clear();
            adminStudentDataList.add(StaffData(
              staffName: 'All Students',
              username: 'Dummy Username',
              password: 'Dummy Password',
              description: 'Dummy Description',
              staffId: 0,
            ));
            for (var myData in studentAttendance.data!) {
              adminStudentDataList.add(StaffData(
                  staffName: myData.name,
                  username: myData.section,
                  password: myData.parentEmail,
                  description: myData.category,
                  staffId: myData.studentId));
            }
            isAdminStudent = false;
          } else {
            isAdminStudent = false;
          }
        } else {
          isAdminStudent = false;
        }
      } catch (error) {
        isAdminStudent = false;
        AppUtil.snackBar('$error');
      }
    } else {
      isAdminStudent = false;
    }

    update();
  }

  void showStudentAttendance() {
    if (selectedAdminClass == null) {
      AppUtil.snackBar('Please select Class');
      return;
    }

    if (selectedAdminSection == null) {
      AppUtil.snackBar('Please select section');
      return;
    }

    if (selectedAdminStudent == null) {
      AppUtil.snackBar('Please select student');
      return;
    }

    DateTime assignmentDate =
        DateFormat('dd/MM/yyyy').parse(selectedAssignmentDate!);
    DateTime submissionDate =
        DateFormat('dd/MM/yyyy').parse(selectedSubmissionDate!);

    if (assignmentDate.isAfter(submissionDate)) {
      AppUtil.snackBar('End date cannot be less than the start date');
      return;
    }

    _showStudentAttendance();
  }

  void _showProgress() {
    showProgress.value = true;
  }

  void _hideProgress() {
    showProgress.value = false;
  }

  Future<void> _showStudentAttendance() async {
    isFirstTime.value = false;
    _showProgress();

    allBetweenDates.clear();
    allBetweenDates.addAll(getAllFormattedDatesBetween(
        selectedAssignmentDate!, selectedSubmissionDate!));

    try {
      Map<String, String> credentials = {
        "classId": selectedAdminClass!.staffId.toString(),
        "sectionId": selectedAdminSection!.staffId.toString(),
        'fromDate': selectedAssignmentDate!,
        'toDate': selectedSubmissionDate!,
        'studentId': selectedAdminStudent!.staffId.toString(),
      };

      /*Map<String, String> credentials = {
        "classId": "414",
        "sectionId": "421",
        "fromDate": "15/06/2023",
        "toDate": "05/07/2023",
        "studentId": "1658"
      };*/

      String jsonCredentials = jsonEncode(credentials);

      print("sgsgwgwgwg$jsonCredentials");

      final response = await http.post(
        Uri.parse("${baseUrlName}Attendance/ViewStudentAttendance"),
         headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        body: jsonCredentials,
      );

      print("sgsgwgwgwg${response.statusCode}");

      if (response.statusCode == 200) {
        studentListData.clear();
        attendance.clear();

        var studentAttendance = studentAttendanceFromJson(response.body);
        if (studentAttendance.responseCode == "200" &&
            studentAttendance.data.isNotEmpty) {
          studentData = studentAttendance.data[0];
          print("sdgfsgsgvgevsdf${studentData!.totalAttendedDays}");

          studentListData.addAll(studentAttendance.data);
          attendance.addAll(studentData!.attendance);
          _hideProgress();
          isAttandanceDataFound.value = true;
        } else if (studentAttendance.responseCode == "500") {
          _hideProgress();
          isAttandanceDataFound.value = false;
          AppUtil.snackBar("Something went wrong");
        } else {
          _hideProgress();
          isAttandanceDataFound.value = false;
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
        isAttandanceDataFound.value = false;
        AppUtil.snackBar('Something went wrong');
      }
    } catch (error) {
      _hideProgress();
      isAttandanceDataFound.value = false;
      AppUtil.snackBar('$error');
    }
    update();
  }

  List<String> getAllFormattedDatesBetween(String startDate, String endDate) {
    List<String> dates = [];
    DateTime currentStartDate = DateFormat('dd/MM/yyyy').parse(startDate);
    DateTime currentEndDate = DateFormat('dd/MM/yyyy').parse(endDate);

    while (currentStartDate.isBefore(currentEndDate) ||
        currentStartDate.isAtSameMomentAs(currentEndDate)) {
      dates.add(DateFormat('dd/MM/yyyy').format(currentStartDate));
      currentStartDate = currentStartDate.add(const Duration(days: 1));
    }

    return dates;
  }

  Future<void> exportData() async {
    /* String formattedDateTime =
        DateFormat('yyyyMMddTHHmmss').format(DateTime.now());

    var excel = Excel.createExcel();

    var sheet = excel['Sheet1'];

    List<List<dynamic>> data = [
      [
        "S. no.",
        "Student Name",
        "Class",
        "Section",
        for (var date in allBetweenDates) date.split("/").first.trim(),
        "Attendance %"
      ],
      for (var index = 0; index < studentListData.length; index++)
        buildDataRow(index, studentListData[index]!),
    ];

    for (var row in data) {
      print("sgehehehehe${row}");

      sheet.appendRow(row);
    }

    final directory = await getApplicationDocumentsDirectory();

    final folderPath = join(directory.path, 'Nirmala Convent S.S. School');
    final folder = Directory(folderPath);
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    final filePath = join(folderPath,
        '${staffClass!.dataListItemName}_${staffSection!.dataListItemName}_$formattedDateTime.xlsx');

    List<int>? fileBytes = excel.save();

    if (fileBytes != null) {
      var file = File(filePath);
      file.createSync(recursive: true);
      //await file.writeAsBytes(excel.encode()!);
      await file.writeAsBytes(fileBytes);
    }

    print('Excel file created successfully at: $filePath');*/
  }

  List<dynamic> buildDataRow(int index, Datum logic) {
    return [
      index + 1,
      logic.studentName,
      logic.attendance[0]!.className,
      logic.attendance[0]!.sectionName,
      for (var attendance in logic.attendance)
        attendance!.markFullDayAbsent != null ? 'Absent' : 'Present',
      logic.attendancePer,
    ];
  }
}
