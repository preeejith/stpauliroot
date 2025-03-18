import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/attendance/admin/admin_attendance_controller.dart';
import 'package:iroots/src/ui/dashboard/attendance/admin/admin_view_attendence.dart';
import 'package:iroots/src/ui/dashboard/attendance/admin/update_admin_attendence.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class AdminAttendanceScreen extends StatelessWidget {
  const AdminAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AdminAttendanceController(),
      builder: (logic) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ConstClass.dashBoardColor,
            title: AppUtil.customText(
              text: "Student Attendance",
              style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: const Color(0xffF1F5F9),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUtil.customDropDown(
                        logic,
                        "Select Staff",
                        "Please Select Staff",
                        logic.dashBoardController.adminStaffDataList,
                        (newValue) {
                      logic.selectedStaff = newValue;
                      logic.getClass();
                    }, logic.selectedStaff),
                    const SizedBox(
                      height: 10,
                    ),
                    AppUtil.customDropDown1("Select Class", logic.className),
                    const SizedBox(
                      height: 10,
                    ),
                    AppUtil.customDropDown1(
                        "Select Section", logic.sectionName),
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
                            logic.showStudentAttendance();
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
                                                                  fontSize:
                                                                      12),
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
                        Get.to(() => const UpdateAdminAttendanceScreen());
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
      /* onPressed: () {
        logic.pickDateDialog(context);
      },*/
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
}
