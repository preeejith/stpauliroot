import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/bloc/bloclocalstorage/prefmanager.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/notification/new_notification_controller.dart';
import 'package:iroots/src/modal/attendance/classModalClass.dart';
import 'package:iroots/src/modal/attendance/staffModalClass.dart';
import 'package:iroots/src/modal/homework/courseModalClass.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/utility/const.dart';

class DashBoardController extends GetxController {
  final PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  String? userRole;
  final notificationController = Get.put(NewNotificationController());
  List<StaffData> adminClassDataList = [];
  List<StaffData> adminSectionDataList = [];
  List<StaffData> adminCourseDataList = [];
  List<StaffData> adminStaffDataList = [];
  final GetStorage box = Get.put(GetStorage());
  String? accessToken;
  int? userId;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Map<String, String>? credentials;

  @override
  void onInit() {
    print("Sgsgsgssgfwege}");
    userRole = box.read("userRole");
    accessToken = box.read("accessToken");
    userId = box.read("userId");
    credentials = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    debugPrint("AccessToken $accessToken");
    _getFirebaseToken();
    userRole == "Administrator" ? _getAdminClasses() : "";
    _getAdminSections();
    _getAdminCourse();
    _getAdminStaff();
    // notificationController.fetchNotifications();
    super.onInit();
  }

  changePage(int page) {
    selectedIndex = page;
    update();
  }

  changeScreen(int index) {
    pageController.jumpToPage(index);
    update();
  }

  Future<void> logOut() async {
    box.remove('accessToken');
    box.remove('isUserLogin');
    box.remove('userRole');
    await PrefManager.clearToken();
    Get.offAll(() => const LoginPage());
  }

  Future<void> _getAdminClasses() async {
    try {
      //issue1area
      final response = await http.get(
          Uri.parse("${baseUrlName}UserCredentials/GetClass"),
          headers: credentials);

      print("sdfghfhjfb${response.statusCode}");

      if (response.statusCode == 200) {
        var adminClassResponse = classModalClassFromJson(response.body);

        if (adminClassResponse.responseCode == "200" &&
            adminClassResponse.data.isNotEmpty) {
          for (var adminClass in adminClassResponse.data) {
            adminClassDataList.add(StaffData(
              staffName: adminClass.dataListItemName,
              username: adminClass.dataListName,
              password: adminClass.dataListId,
              description: '',
              staffId: adminClass.dataListItemId,
            ));
          }
        }
      }
    } catch (error) {
      debugPrint("$error");
    }
    update();
  }

  Future<void> _getAdminSections() async {
    try {
      final response = await http.get(
          Uri.parse("${baseUrlName}UserCredentials/GetSection"),
          headers: credentials);

      if (response.statusCode == 200) {
        var adminSectionResponse = classModalClassFromJson(response.body);
        if (adminSectionResponse.responseCode == "200" &&
            adminSectionResponse.data.isNotEmpty) {
          for (var adminSection in adminSectionResponse.data) {
            adminSectionDataList.add(StaffData(
              staffName: adminSection.dataListItemName,
              username: adminSection.dataListName,
              password: adminSection.dataListId,
              description: '',
              staffId: adminSection.dataListItemId,
            ));
          }
        }
      }
    } catch (error) {
      debugPrint("$error");
    }
    update();
  }

  Future<void> _getAdminCourse() async {
    try {
      final response = await http.get(
          Uri.parse("${baseUrlName}UserCredentials/GetSubjects"),
          headers: credentials);

      if (response.statusCode == 200) {
        var classResponse = courseModalClassFromJson(response.body);
        if (classResponse.responseCode == "200" &&
            classResponse.data.isNotEmpty) {
          for (var attenClass in classResponse.data) {
            adminCourseDataList.add(StaffData(
                staffName: attenClass.subjectName,
                username: "",
                password: "",
                description: attenClass.isElective.toString(),
                staffId: attenClass.subjectId));
          }
        }
      }
      update();
    } catch (error) {
      debugPrint("$error");
    }
  }

  Future<void> _getAdminStaff() async {
    try {
      final response = await http.get(
          Uri.parse("${baseUrlName}UserCredentials/GetStaff"),
          headers: credentials);

      if (response.statusCode == 200) {
        var staffResponse = staffModalClassFromJson(response.body);
        if (staffResponse.responseCode == "200" &&
            staffResponse.data.isNotEmpty) {
          adminStaffDataList.addAll(staffResponse.data);
        }
      }
    } catch (error) {
      debugPrint("$error");
    }
    update();
  }

  Future<void> _getFirebaseToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    print("sgwergheg$token");
  }
}
