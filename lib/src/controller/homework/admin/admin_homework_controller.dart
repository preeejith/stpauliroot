import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/dashboard/dashBoard_controller.dart';
import 'package:iroots/src/modal/attendance/staffModalClass.dart';
import 'package:iroots/src/modal/homework/createHomeWorkModalClass.dart';
import 'package:iroots/src/modal/homework/getHomeworkModalClass.dart';
import 'package:iroots/src/modal/selection_popup_model.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class AdminHomeWorkController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  
  StaffData? selectedClass;
  StaffData? selectedSection;
  StaffData? selectedCourse;
  RxBool showProgress = false.obs;
  RxBool isHomeWorkDataFound = false.obs;
  RxBool isFirstTime = true.obs;
  final dashBoardController = Get.put(DashBoardController());

  TextEditingController homeworkTitle = TextEditingController();
  TextEditingController homeworkInstructions = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  SelectionPopupModel? selectedSelection;
  String? selectedAssignmentDate =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  String? selectedSubmissionDate =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  List<GetHomeWorkData> getHomeworkDataList = [];
  String? accessToken;

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

  void createHomeWork() {
    DateTime assignmentDate =
        DateFormat('dd/MM/yyyy').parse(selectedAssignmentDate!);
    DateTime submissionDate =
        DateFormat('dd/MM/yyyy').parse(selectedSubmissionDate!);

    if (homeworkTitle.text.isEmpty) {
      AppUtil.snackBar('Please enter homework title');
      return;
    }

    if (selectedClass == null) {
      AppUtil.snackBar('Please select class');
      return;
    }

    if (selectedSection == null) {
      AppUtil.snackBar('Please select section');
      return;
    }

    if (selectedCourse == null) {
      AppUtil.snackBar('Please select Subject');
      return;
    }

    if (assignmentDate.isAfter(submissionDate)) {
      AppUtil.snackBar(
          'Assignment date cannot be greater than submission date');
      return;
    }

    _createHomeWork();
  }

  void _showProgress() {
    showProgress.value = true;
  }

  void _hideProgress() {
    showProgress.value = false;
  }

  Future<void> _createHomeWork() async {
    _showProgress();
    try {
      Map<String, String> credentials = {
        "assignmentId": "0",
        "className": selectedClass?.staffName ?? "",
        "classId": selectedClass?.staffId.toString() ?? "",
        "sectionName": selectedSection?.staffName ?? "",
        "sectionId": selectedSection?.staffId.toString() ?? "",
        "subjectName": selectedCourse?.staffName ?? "",
        "subjectId": selectedCourse?.staffId.toString() ?? "",
        "newAssignment": homeworkTitle.text,
        "assignmentDate": selectedAssignmentDate ?? "",
        "submittedDate": selectedSubmissionDate ?? "",
        "createdDate": selectedAssignmentDate ?? ""
      };

      String jsonCredentials = jsonEncode(credentials);

      final response = await http.post(
        Uri.parse("${baseUrlName}Student/AddAssignment"),
         headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        body: jsonCredentials,
      );

      if (response.statusCode == 200) {
        var studentAttendance = createHomeWorkModalClassFromJson(response.body);
        if (studentAttendance.responseCode == "201") {
          _hideProgress();
          Get.back();
          AppUtil.snackBar("Homework created successfully");
        } else if (studentAttendance.responseCode == "500") {
          _hideProgress();
          AppUtil.snackBar("Something went wrong");
        } else {
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
        _hideProgress();
        AppUtil.snackBar('Something went wrong');
      }
    } catch (error) {
      _hideProgress();
      AppUtil.snackBar('$error');
    }
  }

  void showHomeWork() {
    if (selectedClass == null) {
      AppUtil.snackBar('Please select class');
      return;
    }

    if (selectedSection == null) {
      AppUtil.snackBar('Please select section');
      return;
    }

    if (selectedCourse == null) {
      AppUtil.snackBar('Please select Subject');
      return;
    }

    _showHomeWork();
  }

  Future<void> _showHomeWork() async {
    _showProgress();

    print(
        "Sgdsdgsd${selectedClass!.staffId} == ${selectedSection!.staffId} == ${selectedCourse!.staffId}");

    try {
      final response = await http.get(
          Uri.parse(
              "${baseUrlName}Student/GetAllAssignmentDetails?classid=${selectedClass!.staffId}&sectionid=${selectedSection!.staffId}&subjectid=${selectedCourse!.staffId}"),
          // "${ConstClass.BASEURL}Student/GetAllAssignmentDetails?classid=414&sectionid=421&subjectid=8"),
           headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          });
      if (response.statusCode == 200) {
        var homeWorkResponse = getHomeWorkModalClassFromJson(response.body);
        if (homeWorkResponse.responseCode == "200" &&
            homeWorkResponse.data!.isNotEmpty) {
          getHomeworkDataList.clear();
          getHomeworkDataList.addAll(homeWorkResponse.data!);
          isHomeWorkDataFound.value = true;
          _hideProgress();
        } else if (homeWorkResponse.responseCode == "500") {
          _hideProgress();
          isHomeWorkDataFound.value = false;
          AppUtil.snackBar("Something went wrong");
        } else {
          _hideProgress();
          isHomeWorkDataFound.value = false;
        }
      } else if (response.statusCode == 401) {
        isHomeWorkDataFound.value = false;
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
        isHomeWorkDataFound.value = false;
        AppUtil.snackBar('Something went wrong');
      }
    } catch (error) {
      isHomeWorkDataFound.value = false;
      _hideProgress();
      AppUtil.snackBar('$error');
    }
    update();
    isFirstTime.value = false;
  }
}
