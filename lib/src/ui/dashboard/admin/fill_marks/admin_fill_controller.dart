import 'dart:convert';

// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/src/modal/home/staff/staffDetails.dart';
import 'package:iroots/src/service/handler/api_handler.dart';
import 'package:iroots/src/service/handler/api_url.dart';
import 'package:iroots/src/service/model/get_batch_model.dart';
import 'package:iroots/src/service/model/get_class_model.dart';
import 'package:iroots/src/service/model/get_fill_marks_model.dart';
import 'package:iroots/src/service/model/get_section_model.dart';
import 'package:iroots/src/service/model/get_staff_model.dart';
import 'package:iroots/src/service/model/get_term_model.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/ui/dashboard/dashboard_screen.dart';
import 'package:iroots/src/utility/app_snackbar.dart';
import 'package:iroots/src/utility/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/src/utility/util.dart';

class AdminFillController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  final ScrollController horizontalScrollController = ScrollController();
  final ScrollController verticalScrollController = ScrollController();
  RxBool isLoading = false.obs;
  RxBool showLoading = false.obs;
  RxBool isNotesOpen = true.obs;

  RxString accessToken = "".obs;

  /// Staff

  RxList<StaffModel> staffList = <StaffModel>[].obs;
  Rx<StaffModel> selectedStaff = StaffModel().obs;
  TextEditingController staffController = TextEditingController();

  getStaffList() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        isLoading.value = true;
        staffList.clear();
        staffController.clear();
        classController.clear();
        sectionController.clear();
        termController.clear();
        batchController.clear();
        selectedClass = ClassModel().obs;
        classList.clear();
        sectionList.clear();
        selectedSection = SectionModel().obs;
        selectedTerm = TermModel().obs;
        termList.clear();
        selectedBatch = BatchModel().obs;
        batchList.clear();
        subject.clear();
        studentList.clear();
        http.Response response = await ApiHandler.get(
          url: ApiUrls.baseUrl + ApiUrls.getStaffList,
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getStaffModelFromMap(response.body);
          for (var element in decoded.data!) {
            staffList.add(element);
          }
          isLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          isLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          isLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        isLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      isLoading.value = false;
      toast(e.toString(), false);
    }
  }

  /// Class

  RxList<ClassModel> classList = <ClassModel>[].obs;
  Rx<ClassModel> selectedClass = ClassModel().obs;
  TextEditingController classController = TextEditingController();

  getClassList({required bool showLoader}) async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        if (showLoader) {
          isLoading.value = true;
        } else {
          showLoading.value = true;
        }
        showLoading.value = true;
        classController.clear();
        sectionController.clear();
        termController.clear();
        batchController.clear();
        selectedClass = ClassModel().obs;
        classList.clear();
        sectionList.clear();
        selectedSection = SectionModel().obs;
        selectedTerm = TermModel().obs;
        termList.clear();
        selectedBatch = BatchModel().obs;
        batchList.clear();
        subject.clear();
        studentList.clear();
        http.Response response = await ApiHandler.post(
          url:
              '${ApiUrls.baseUrl}${ApiUrls.getClass}?staff_Id=${selectedStaff.value.stafId.toString()}',
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getClassModelFromMap(response.body);
          for (var element in decoded.data!) {
            classList.add(element);
          }
          showLoading.value = false;
          isLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          isLoading.value = false;
          showLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['message'], false);
        } else {
          showLoading.value = false;
          isLoading.value = false;

          toast(decoded['message'], false);
        }
      } else {
        showLoading.value = false;
        isLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      showLoading.value = false;
      isLoading.value = false;
      toast(e.toString(), false);
    }
  }

  /// Section

  RxList<SectionModel> sectionList = <SectionModel>[].obs;
  Rx<SectionModel> selectedSection = SectionModel().obs;
  TextEditingController sectionController = TextEditingController();

  getSectionList() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        sectionController.clear();
        termController.clear();
        batchController.clear();
        selectedSection = SectionModel().obs;
        showLoading.value = true;
        sectionList.clear();
        selectedTerm = TermModel().obs;
        termList.clear();
        selectedBatch = BatchModel().obs;
        batchList.clear();
        subject.clear();
        studentList.clear();
        http.Response response = await ApiHandler.get(
          url:
              '${ApiUrls.baseUrl}${ApiUrls.getSection}?staffId=${selectedStaff.value.stafId.toString()}&classId=${selectedClass.value.dataListItemId.toString()}',
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getSectionModelFromMap(response.body);
          for (var element in decoded.data!) {
            sectionList.add(element);
          }
          showLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          showLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      showLoading.value = false;
      toast(e.toString(), false);
    }
  }

  /// Get Term

  RxList<TermModel> termList = <TermModel>[].obs;
  Rx<TermModel> selectedTerm = TermModel().obs;
  TextEditingController termController = TextEditingController();

  getTermList() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        termController.clear();
        batchController.clear();
        showLoading.value = true;
        selectedTerm = TermModel().obs;
        termList.clear();
        subject.clear();
        studentList.clear();

        http.Response response = await ApiHandler.get(
          url: '${ApiUrls.baseUrl}${ApiUrls.getTerm}',
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getTermModelFromMap(response.body);
          for (var element in decoded.data!) {
            termList.add(element);
          }
          showLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          showLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      showLoading.value = false;
      toast(e.toString(), false);
    }
  }

  /// Get Batch

  RxList<BatchModel> batchList = <BatchModel>[].obs;
  Rx<BatchModel> selectedBatch = BatchModel().obs;
  TextEditingController batchController = TextEditingController();

  getBatchList() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        batchController.clear();
        showLoading.value = true;
        selectedBatch = BatchModel().obs;
        batchList.clear();
        subject.clear();
        studentList.clear();
        http.Response response = await ApiHandler.get(
          url: '${ApiUrls.baseUrl}${ApiUrls.getBatch}',
          token: accessToken.value,
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          var decoded = getBatchModelFromMap(response.body);
          for (var element in decoded.data!) {
            batchList.add(element);
          }
          showLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          showLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      showLoading.value = false;
      toast(e.toString(), false);
    }
  }

  /// Show Data

  RxList<SubjectNames> subject = <SubjectNames>[].obs;
  RxList<Student> studentList = <Student>[].obs;

  showData() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        showLoading.value = true;
        subject.clear();
        studentList.clear();
        http.Response response = await ApiHandler.postBody(
            url: '${ApiUrls.baseUrl}${ApiUrls.frillMark}',
            token: accessToken.value,
            body: {
              "classId": selectedClass.value.dataListItemId.toString(),
              "sectionId": selectedSection.value.dataListItemId.toString(),
              "testId": "0",
              "termId": selectedTerm.value.termId.toString(),
              "staffId": selectedStaff.value.stafId.toString(),
              "batchId": selectedBatch.value.batchId.toString()
            });

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          List<SubjectNames> subject1 = [];
          var decoded = getFillMarksModelFromMap(response.body);

          /// Subject Name

          for (var e in decoded.data!.headerData!) {
            if (e.testName.toString() != "null" &&
                e.testName.toString() != "") {
              subject1.add(e);
            }
          }
          subject.value = subject1.toList();

          subject.insert(
              subject.length,
              SubjectNames(
                  testName: "                  Remark                  "));

          /// Student

          for (var e1 in decoded.data!.data!) {
            List<Subject> data = [];
            for (var e in subject1) {
              data.add(Subject(
                enabled: e1.studentTestObtMarks!
                        .where((test) =>
                            test.testId.toString() == e.testId.toString())
                        .isNotEmpty
                    ? e1.studentTestObtMarks!
                            .firstWhere((test) =>
                                test.testId.toString() == e.testId.toString())
                            .isElective ??
                        true
                    : true,
                isOptional: e1.studentTestObtMarks!
                        .where((test) =>
                            test.testId.toString() == e.testId.toString())
                        .isNotEmpty
                    ? e1.studentTestObtMarks!
                            .firstWhere((test) =>
                                test.testId.toString() == e.testId.toString())
                            .isOptional ??
                        true
                    : true,
                name: e.testName.toString(),
                controller: TextEditingController(
                    text: e1.studentTestObtMarks!
                            .where((test) =>
                                test.testId.toString() == e.testId.toString())
                            .isNotEmpty
                        ? e1.studentTestObtMarks!
                                .firstWhere((test) =>
                                    test.testId.toString() ==
                                    e.testId.toString())
                                .obtainedMarks
                                .toString()
                                .isNotNullOrEmpty
                            ? int.parse(double.parse(e1.studentTestObtMarks!
                                        .firstWhere((test) =>
                                            test.testId.toString() ==
                                            e.testId.toString())
                                        .obtainedMarks
                                        .toString())
                                    .toStringAsFixed(0))
                                .toStringAsFixed(0)
                            : ""
                        : ""),
                id: e.testId.toString(),
              ));
            }
            studentList.add(
              Student(
                name: e1.studentName.toString(),
                id: e1.studentId.toString(),
                subject: data,
                remarkController: TextEditingController(
                  text: e1.studentTestObtMarks!.isNotEmpty
                      ? e1.studentTestObtMarks!
                              .where((ts) =>
                                  ts.testName!
                                      .toLowerCase()
                                      .contains("remark") ==
                                  true)
                              .isNotEmpty
                          ? e1.studentTestObtMarks!
                                  .firstWhere((ts) =>
                                      ts.testName!
                                          .toLowerCase()
                                          .contains("remark") ==
                                      true)
                                  .remark
                                  .toString()
                                  .isNotNullOrEmpty
                              ? e1.studentTestObtMarks!
                                  .firstWhere((ts) =>
                                      ts.testName!
                                          .toLowerCase()
                                          .contains("remark") ==
                                      true)
                                  .remark
                                  .toString()
                              : ""
                          : ""
                      : "",
                ),
              ),
            );
          }

          showLoading.value = false;
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          showLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      showLoading.value = false;
      toast(e.toString(), false);
    }
  }

  /// Submit Data

  submitData() async {
    try {
      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        showLoading.value = true;
        List<Map> dataList = [];
        for (var e in studentList) {
          List<Map> obtainedMarks = [];
          for (var e1 in e.subject) {
            obtainedMarks.add({
              'obtainedMarks': e1.controller.text.trim().isNotNullOrEmpty
                  ? int.parse(e1.controller.text.trim()) > 100
                      ? "100"
                      : int.parse(e1.controller.text.trim()) < -1
                          ? "-1"
                          : int.parse(e1.controller.text.trim()).toString()
                  : 0,
              "testId": e1.id.toString(),
              // "recordIdfk": e1..toString(),
            });
          }

          Map d = {
            "studentID": e.id.toString(),
            "classID": selectedClass.value.dataListItemId.toString(),
            "sectionId": selectedSection.value.dataListItemId.toString(),
            "termID": selectedTerm.value.termId.toString(),
            "boardID": "0",
            "remark": e.remarkController.value.text,
            "batchId": selectedBatch.value.batchId.toString(),
            "staffId": selectedStaff.value.stafId.toString(),
            "obtainedMarkData": obtainedMarks
          };

          dataList.add(d);
        }

        http.Response response = await http.post(
          Uri.parse('${ApiUrls.baseUrl}${ApiUrls.saveFillMark}'),
          headers: {
            'Authorization': 'Bearer ${accessToken.value}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(dataList),
        );

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          showLoading.value = false;
          if (decoded['responseCode'] == "200" ||
              decoded['responseCode'] == "201" ||
              decoded['responseCode'] == "202" ||
              decoded['responseCode'] == "203" ||
              decoded['responseCode'] == "204") {
            toast(decoded['msg'], true);
            // Get.offAll(() => const DashBoardPageScreen());
          } else {
            toast(decoded['msg'], false);
          }
        } else if (response.statusCode == 401) {
          // LocalStorage.clearData();
          showLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      showLoading.value = false;
      toast(e.toString(), false);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  getData({
    required bool fromAdmin,
    StaffDetail? staffId,
  }) {
    accessToken.value = box.read("accessToken");
    if (fromAdmin) {
      getStaffList();
    } else {
      selectedStaff = StaffModel(
        stafId: staffId?.staffid ?? "",
        name: staffId?.name ?? "",
      ).obs;
      getClassList(showLoader: true);
    }
  }
}

class Student {
  final String id;
  final String name;
  final List<Subject> subject;
  final TextEditingController remarkController;

  Student({
    required this.id,
    required this.name,
    required this.subject,
    required this.remarkController,
  });
}

class Subject {
  final String id;
  final String name;
  final bool enabled;
  final bool isOptional;
  final TextEditingController controller;

  Subject({
    required this.id,
    required this.name,
    required this.enabled,
    required this.isOptional,
    required this.controller,
  });
}
