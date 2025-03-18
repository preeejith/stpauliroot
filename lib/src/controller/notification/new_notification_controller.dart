import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/home/student/student_home_controller.dart';
import 'package:iroots/src/modal/notification/notification_modal_class.dart';
import 'package:iroots/src/ui/dashboard/attendance/student/student_attendence.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class NewNotificationController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  int? userId;
  List<NotificationDatum>? notificationList = [];
  RxBool isDataFound = false.obs;
  RxBool notificationProgress = false.obs;
  String? accessToken;
  final studentHomeController = Get.put(StudentHomeController());

/*  final StreamController<int> _notificationCountController =
      StreamController<int>();

  Stream<int> get notificationCountStream =>
      _notificationCountController.stream;*/

  RxInt? notificationCount = 0.obs;

  @override
  void onInit() {
    print("sghsghergyhere}");

    accessToken = box.read("accessToken");
    userId = box.read("userId");
    newFetchNotifications();
    super.onInit();
  }

  Future<void> newFetchNotifications() async {
    // if (userId != null) {
    //   notificationProgress.value = true;
    //   final response = await http.get(
    //     Uri.parse("${baseUrlName}Notification/GetNotifications?UserId=$userId"),
    //   );
    //   if (response.statusCode == 200) {
    //     var notificationResponse =
    //         notificationModalClassFromJson(response.body);
    //     if (notificationResponse.responseCode == "200" &&
    //         notificationResponse.data != null) {
    //       notificationList!.clear();
    //       notificationList!.addAll(notificationResponse.data!);
    //       isDataFound.value = true;
    //       notificationProgress.value = false;
    //     } else {
    //       isDataFound.value = false;
    //       notificationProgress.value = false;
    //     }
    //   } else {
    //     throw Exception('Failed to load notifications');
    //   }
    //   update();
    // }
  }

  Future<void> clickNotification(NotificationDatum notificationDatum) async {
    try {
      List<Map<String, dynamic>> credentials = [
        {
          "id": notificationDatum.id,
          "userId": notificationDatum.userId,
          "title": notificationDatum.title,
          "body": notificationDatum.body,
          "isRead": true,
        }
      ];

      String jsonCredentials = jsonEncode(credentials);

      print("sghsgsgs$jsonCredentials");

      final response = await http.post(
        Uri.parse("${baseUrlName}Notification/EditNotification"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonCredentials,
      );

      print("sghsgsgs$jsonCredentials");
      print("sghsgsgs${response.statusCode}");
      print("sghsgsgs${response.body}");
      if (response.statusCode == 200) {
        var notificationResponse =
            notificationModalClassFromJson(response.body);
        print("sghsgsgs${notificationResponse.responseCode}");
        if (notificationResponse.responseCode == "200") {
          // newFetchNotifications();
          // Get.to(() => const StudentAttendanceScreen(), arguments: studentHomeController.studentData);

          // Get.back();
        } else {
          AppUtil.snackBar("Something went wrong");
        }
      }
    } catch (error) {
      debugPrint(" sgehgee = $error");
    }
  }

  Future<void> fetchNotifications() async {
    if (userId != null) {
      final response = await http.get(
        Uri.parse("${baseUrlName}Notification/GetNotifications?UserId=$userId"),
      );
      print("sfgyeyheryh4e${response.statusCode}");

      if (response.statusCode == 200) {
        var loginResponse = notificationModalClassFromJson(response.body);
        print("sfgyeyheryh4e${loginResponse.responseCode}");

        if (loginResponse.responseCode == "200" && loginResponse.data != null) {
          notificationCount!.value = loginResponse.data!.length;
          //  _notificationCountController.sink.add(loginResponse.data!.length);
        }
      } else {
        throw Exception('Failed to load notifications');
      }
    }
  }
}
