import 'dart:convert';
import 'dart:developer';

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
import 'package:iroots/src/service/model/get_scholastic_model.dart';
import 'package:iroots/src/service/model/get_section_model.dart';
import 'package:iroots/src/service/model/get_staff_model.dart';
import 'package:iroots/src/service/model/get_term_model.dart';
import 'package:iroots/src/ui/auth/login_page.dart';
import 'package:iroots/src/ui/dashboard/dashboard_screen.dart';
import 'package:iroots/src/utility/app_snackbar.dart';
import 'package:iroots/src/utility/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/src/utility/util.dart';
import 'package:path/path.dart';

class AdminCoScholasticController extends GetxController {
  final GetStorage box = Get.put(GetStorage());
  RxBool isLoading = false.obs;
  RxBool showLoading = false.obs;
  final ScrollController horizontalScrollController = ScrollController();
  final ScrollController verticalScrollController = ScrollController();
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
        selectedClass = ClassModel().obs;
        classList.clear();
        sectionList.clear();
        selectedSection = SectionModel().obs;
        selectedTerm = TermModel().obs;
        termList.clear();
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
        batchController.clear();
        classController.clear();
        sectionController.clear();
        termController.clear();
        selectedClass = ClassModel().obs;
        classList.clear();
        sectionList.clear();
        selectedSection = SectionModel().obs;
        selectedTerm = TermModel().obs;
        termList.clear();
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
          showLoading.value = false;
          isLoading.value = false;

          Get.offAll(() => const LoginPage());
          toast(decoded['msg'], false);
        } else {
          isLoading.value = false;
          showLoading.value = false;

          toast(decoded['msg'], false);
        }
      } else {
        isLoading.value = false;
        showLoading.value = false;
        toast("No Internet Connection!", false);
      }
    } catch (e) {
      isLoading.value = false;
      showLoading.value = false;
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
        batchController.clear();
        sectionController.clear();
        termController.clear();
        selectedSection = SectionModel().obs;
        showLoading.value = true;
        sectionList.clear();
        selectedTerm = TermModel().obs;
        termList.clear();
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
        batchController.clear();
        termController.clear();
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

  /// Get Data

  RxList<SubjectData> subject = <SubjectData>[].obs;
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
            url: '${ApiUrls.baseUrl}${ApiUrls.coScholasticArea}',
            token: accessToken.value,
            body: {
              "classId": selectedClass.value.dataListItemId.toString(),
              "sectionId": selectedSection.value.dataListItemId.toString(),
              "termId": selectedTerm.value.termId.toString(),
              "batchId": selectedBatch.value.batchId.toString(),
            });

        var decoded = jsonDecode(response.body);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202 ||
            response.statusCode == 203 ||
            response.statusCode == 204) {
          List<SubjectData> subject1 = [];
          var decoded = getCoScholasticModelFromMap(response.body);

          /// Subject Name

          for (var e in decoded.data!.headerData!) {
            if (e.title.toString() != "null" && e.title.toString() != "") {
              subject1.add(e);
            }
          }
          subject.value = subject1.toList();

          subject.insert(0, SubjectData(title: "Student Name"));
          subject.insert(0, SubjectData(title: "S.No"));
          subject.insert(subject.length, SubjectData(title: "Clear All"));

          /// Student

          for (var e1 in decoded.data!.data!) {
            List<Subject> data = [];
            for (var e in subject1) {
              data.add(Subject(
                name: e.title.toString(),
                value: e.id.toString().obs,
                id: e1.coscholastiStuentObtDatas!
                        .where((test) =>
                            test.coscholasticId.toString() == e.id.toString())
                        .isNotEmpty
                    ? e1.coscholastiStuentObtDatas!
                        .firstWhere((test) =>
                            test.coscholasticId.toString() == e.id.toString())
                        .coscholasticId
                        .toString()
                    : "",
              ));
            }
            studentList.add(
              Student(
                  name: e1.studentName.toString(),
                  id: e1.studentId.toString(),
                  subject: data),
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
//fillcoscholasticapicall
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
            // obtainedMarks.add({
            //   "coscholasticID": e1.id.toString(),
            //   "obtainedGrade": e1.value.value.toString().isNotNullOrEmpty
            //       ? e1.value.value.toString()
            //       : "",
            //   "id": 0,
            //   "batchId": selectedBatch.value.batchId.toString(),
            // });
            //applyedchanged
            obtainedMarks.add({
              "coscholasticID": e1.id.toString(),
              "obtainedGrade":
                  double.tryParse(e1.value.value.toString()) != null
                      ? null
                      : e1.value.value.toString().isNotNullOrEmpty
                          ? e1.value.value.toString()
                          : "",
              "id": 0,
              "batchId": selectedBatch.value.batchId.toString(),
            });
          }

          Map d = {
            "studentID": e.id.toString(),
            "classID": selectedClass.value.dataListItemId.toString(),
            "sectionId": selectedSection.value.dataListItemId.toString(),
            "termID": selectedTerm.value.termId.toString(),
            "boardID": "0",
            "coscholasticData": obtainedMarks
          };

          dataList.add(d);
        }

        http.Response response = await http.post(
          Uri.parse('${ApiUrls.baseUrl}${ApiUrls.saveCoScholastic}'),
          headers: {
            'Authorization': 'Bearer ${accessToken.value}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(dataList),
        );
        log(jsonEncode(dataList));
        print("jdsb");
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
            log(decoded['msg']);
            // Navigator.pop(context);
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

  getData({required bool fromAdmin, StaffDetail? staffId}) {
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

  Student({
    required this.id,
    required this.name,
    required this.subject,
  });
}

class Subject {
  final String id;
  RxString value;
  final String name;

  Subject({
    required this.id,
    required this.value,
    required this.name,
  });
}
