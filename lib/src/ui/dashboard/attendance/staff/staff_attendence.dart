import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/common/app_data.dart';
import 'package:iroots/src/controller/attendance/staff/staff_attendance_controller.dart';
import 'package:iroots/src/controller/dashboard/dashBoard_controller.dart';
import 'package:iroots/src/controller/home/staff/staff_home_controller.dart';
import 'package:iroots/src/modal/home/staff/staffDetails.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/update_staff_attendence.dart';
import 'package:iroots/src/ui/dashboard/attendance/staff/view_attendence.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

//mestudentAttendance
class StaffAttendanceScreen extends StatefulWidget {
  final bool? fromAdmin;
  final StaffDetail? staffDetail;

  const StaffAttendanceScreen({
    super.key,
    this.fromAdmin,
    this.staffDetail,
  });

  @override
  State<StaffAttendanceScreen> createState() => _StaffAttendanceScreenState();
}

class _StaffAttendanceScreenState extends State<StaffAttendanceScreen> {
  final DateTime _selectedDate = DateTime.now();
  final GetStorage box = Get.put(GetStorage());
  final staffHomeWorkController = Get.put(StaffHomeController());

  String? accessToken;

  @override
  void initState() {
    accessToken = box.read("accessToken");
    // TODO: implement initState
    // fetchStaffDetails();
    super.initState();
  }

  //   Future<void> fetchStaffDetails() async {
  //   _showProgress();

  //   Map<String, String>? credentials = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $accessToken',
  //   };

  //   try {
  //     final response = await http.get(
  //         Uri.parse("${baseUrlName}UserCredentials/GetStaffDetails"),
  //         headers: credentials);

  //     if (response.statusCode == 200) {
  //       var loginResponse = staffDetailsModalFromMap(response.body);
  //       if (loginResponse.responseCode.toString() == "200") {
  //         if (loginResponse.data!.isNotEmpty) {
  //           if (loginResponse.data!.isNotEmpty) {
  //             staffDetail.value = loginResponse.data![0];
  //           }
  //         }
  //         _hideProgress();
  //       } else if (loginResponse.responseCode == "500") {
  //         AppUtil.snackBar("Something went wrong");
  //         _hideProgress();
  //       } else {
  //         // AppUtil.snackBar(loginResponse.msg!);
  //         _hideProgress();
  //       }
  //     } else if (response.statusCode == 401) {
  //       _hideProgress();
  //       AppUtil.showAlertDialog(onPressed: () {
  //         Get.back();
  //         box.remove('accessToken');
  //         box.remove('isUserLogin');
  //         box.remove('userRole');
  //         Get.offAll(() => const LoginPage());
  //       });
  //     } else {
  //       AppUtil.snackBar('Something went wrong');
  //       _hideProgress();
  //     }
  //   } catch (error) {
  //     AppUtil.snackBar('$error');
  //     _hideProgress();
  //   }
  // }
  //   final AdminCoScholasticController con =
  // Future<void> _refresh() async {
  //   await Future.delayed(
  //       const Duration(seconds: 2)); // Simulating network request
  //   DashBoardController();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StaffAttendanceController(),
      // initState: ,
      builder: (logic) => Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: ConstClass.dashBoardColor,
              title: AppUtil.customText(
                text: "Student Attendance",
                style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16),
              ),
              actions: [
                // InkWell(
                //   child: Icon(Icons.refresh),
                //   onTap: () {
                //     _refresh();
                //   },
                // ),
              ]),
          body: SingleChildScrollView(
            child: Container(
              color: const Color(0xffF1F5F9),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customDropDown(
                      "Select Staff",
                      //  ""
                      logic.staffHomeWorkController.staffDetail == null
                          ? ""
                          : logic.staffHomeWorkController.staffDetail.value
                                  .name ??
                              "",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customDropDown(
                        "Select Class",
                        // "X33"
                        logic.staffHomeWorkController.dataItemName == ""
                            ? ""
                            : logic.staffHomeWorkController.dataItemName
                                .toString()

                        // logic.staffHomeWorkController.staffDetail == null
                        //   ? ""
                        //   : logic.staffHomeWorkController.staffDetail.value
                        //           .gender ??
                        //       "",
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    customDropDown(
                        "Select Section",
                        logic.staffHomeWorkController.staffSectionModel == null
                            ? ""
                            : logic.staffHomeWorkController.staffSectionModel!
                                .data![0].dataListItemName
                                .toString()
                        // logic.staffHomeWorkController.staffSection
                        //         ?.dataListItemName ??
                        // ""

                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppUtil.customText(
                      text: "Select Date",
                      style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    customOutlinedButton(
                        OutlinedButton.styleFrom(
                          side: const BorderSide(
                              width: 1.0, color: Color(0xff94A3B8)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppUtil.customText(
                                text: logic.formatDate(),
                                style: const TextStyle(
                                    color: Color(0xff0F172A),
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              SvgPicture.asset(
                                "assets/icons/calendar_icon.svg",
                                height: 20,
                                width: 20,
                              )
                            ],
                          ),
                        ), () {
                      logic.pickDateDialog(context);
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      if (logic.showProgress.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return SizedBox(
                          width: Get.width,
                          child: customOutlinedButton(
                              OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1.0, color: Color(0xff94A3B8)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                child: AppUtil.customText(
                                  text: "Show",
                                  style: const TextStyle(
                                      color: Color(0xff1575FF),
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ), () {
                            logic.showStudentAttendance(
                                logic.staffHomeWorkController.dataItemId
                                    .toString(),
                                logic.staffHomeWorkController
                                            .staffSectionModel ==
                                        null
                                    ? ""
                                    : logic
                                        .staffHomeWorkController
                                        .staffSectionModel!
                                        .data![0]
                                        .dataListItemId
                                        .toString());
                          }),
                        );
                      }
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      if (logic.isFirstTime.value) {
                        return const SizedBox();
                      } else if (logic.isDataFound.value) {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 255),
                          child: Scrollbar(
                            controller: logic.verticalScrollController,
                            thickness: 8,
                            radius: const Radius.circular(8),
                            interactive: true,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              controller: logic.verticalScrollController,
                              scrollDirection: Axis.vertical,
                              child: Scrollbar(
                                controller: logic.horizontalScrollController,
                                thickness: 8,
                                radius: const Radius.circular(8),
                                interactive: true,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: logic.horizontalScrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Scrollable(
                                    viewportBuilder: (BuildContext context,
                                        ViewportOffset position) {
                                      return DataTable(
                                        border: TableBorder.all(),
                                        columns: List<DataColumn>.generate(
                                          10,
                                          (index) => DataColumn(
                                              label: index == 5
                                                  ? IconButton(
                                                      onPressed: () {
                                                        logic
                                                            .markAllFullAttendance();
                                                      },
                                                      icon: logic.fullAttendance !=
                                                                  null &&
                                                              logic.fullAttendance!
                                                                      .markFullDayAbsent ==
                                                                  "True"
                                                          ? const Icon(
                                                              Icons.check_box)
                                                          : const Icon(Icons
                                                              .check_box_outline_blank),
                                                      color:
                                                          ConstClass.themeColor,
                                                    )
                                                  : index == 7
                                                      ? IconButton(
                                                          onPressed: () {
                                                            logic
                                                                .markAllHalfAttendance();
                                                          },
                                                          icon: logic.halfAttendance !=
                                                                      null &&
                                                                  logic.halfAttendance!
                                                                          .markHalfDayAbsent ==
                                                                      "True"
                                                              ? const Icon(Icons
                                                                  .check_box)
                                                              : const Icon(Icons
                                                                  .check_box_outline_blank),
                                                          color: ConstClass
                                                              .themeColor,
                                                        )
                                                      : index == 9
                                                          ? IconButton(
                                                              onPressed: () {
                                                                logic
                                                                    .markAllOthersAttendance();
                                                              },
                                                              icon: logic.othersAttendance !=
                                                                          null &&
                                                                      logic.othersAttendance!
                                                                              .others ==
                                                                          "True"
                                                                  ? const Icon(Icons
                                                                      .check_box)
                                                                  : const Icon(Icons
                                                                      .check_box_outline_blank),
                                                              color: ConstClass
                                                                  .themeColor,
                                                            )
                                                          : AppUtil.customText(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              text:
                                                                  getColumnName(
                                                                      index),
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff0F172A),
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12),
                                                            )),
                                        ),
                                        rows: logic.dummyList
                                            .asMap()
                                            .map((index, item) {
                                              return MapEntry(
                                                  index,
                                                  DataRow(
                                                    cells: [
                                                      datacell("${index + 1}"),
                                                      datacell(
                                                          item.studentName),
                                                      datacell(item.className),
                                                      datacell(
                                                          item.sectionName),
                                                      datacell("A"),
                                                      DataCell(IconButton(
                                                        onPressed: () {
                                                          logic
                                                              .markFullAttendance(
                                                                  item);
                                                        },
                                                        icon: item.markFullDayAbsent ==
                                                                "True"
                                                            ? const Icon(
                                                                Icons.check_box)
                                                            : const Icon(Icons
                                                                .check_box_outline_blank),
                                                        color: ConstClass
                                                            .themeColor,
                                                      )),
                                                      datacell("H"),
                                                      DataCell(IconButton(
                                                        onPressed: () {
                                                          logic
                                                              .markHalfAttendance(
                                                                  item);
                                                        },
                                                        icon: item.markHalfDayAbsent ==
                                                                "True"
                                                            ? const Icon(
                                                                Icons.check_box)
                                                            : const Icon(Icons
                                                                .check_box_outline_blank),
                                                        color: ConstClass
                                                            .themeColor,
                                                      )),
                                                      datacell("O"),
                                                      DataCell(IconButton(
                                                        onPressed: () {
                                                          logic
                                                              .markOtherAttendance(
                                                                  item);
                                                        },
                                                        icon: item.others ==
                                                                "True"
                                                            ? const Icon(
                                                                Icons.check_box)
                                                            : const Icon(Icons
                                                                .check_box_outline_blank),
                                                        color: ConstClass
                                                            .themeColor,
                                                      )),
                                                    ],
                                                  ));
                                            })
                                            .values
                                            .toList(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (!logic.showProgress.value) {
                        return Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: AppUtil.noDataFound("No Data Found"),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                    Obx(() {
                      if (logic.isDataFound.value) {
                        return const SizedBox(
                          height: 24,
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                    SizedBox(
                      width: Get.width,
                      child: customOutlinedButton(
                          OutlinedButton.styleFrom(
                            backgroundColor: ConstClass.themeColor,
                            side: BorderSide(
                                width: 1.5, color: ConstClass.themeColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: AppUtil.customText(
                              text: "Update Students Attendence",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ), () {
                        Get.to(() => const UpdateStaffAttendanceScreen());
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: customOutlinedButton(
                          OutlinedButton.styleFrom(
                            side: BorderSide(
                                width: 1.5, color: ConstClass.themeColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: AppUtil.customText(
                              text: "View Students Attendance",
                              style: const TextStyle(
                                  color: Color(0xff1575FF),
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ), () {
                        Get.to(() => const ViewAttendanceScreen());
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      if (!logic.isDataFound.value) {
                        return const SizedBox();
                      } else if (logic.saveAttenShowProgress.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return SizedBox(
                          width: Get.width,
                          child: customOutlinedButton(
                              OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1.5, color: Color(0xff0DB166)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/save_icon.svg",
                                      height: 16,
                                      width: 16,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AppUtil.customText(
                                      text: "Save",
                                      style: const TextStyle(
                                          color: Color(0xff0DB166),
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ), () {
                            logic.saveAttendance();
                          }),
                        );
                      }
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  String getColumnName(int index) {
    switch (index) {
      case 0:
        return 'S.no';
      case 1:
        return 'Student Name';
      case 2:
        return 'Class';
      case 3:
        return 'Section';
      case 4:
        return 'Mark Full Day Present';
      case 5:
        return '';
      case 6:
        return 'Mark Half Day Present';
      case 7:
        return '';
      case 8:
        return 'Other';
      case 9:
        return '';
      default:
        return '';
    }
  }

  Widget customOutlinedButton(
      ButtonStyle buttonStyle, Widget widget, Function() onPressed) {
    return OutlinedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: widget,
    );
  }

  DataCell datacell(String? text) {
    return DataCell(AppUtil.customText(
      textAlign: TextAlign.center,
      text: text,
      style: const TextStyle(
          color: Color(0xff334155),
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
          fontSize: 12),
    ));
  }

  Widget customDropDown(
    String? title,
    String? buttonValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppUtil.customText(
          text: title,
          style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
        const SizedBox(
          height: 2,
        ),
        SizedBox(
          width: Get.width,
          child: customOutlinedButton(
              OutlinedButton.styleFrom(
                side: const BorderSide(width: 1, color: Color(0xff94A3B8)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppUtil.customText(
                      text: buttonValue,
                      style: const TextStyle(
                          color: Color(0xff0F172A),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    SvgPicture.asset(
                      "assets/icons/arrowdown_icon.svg",
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
              () {}),
        )
      ],
    );
  }
}
