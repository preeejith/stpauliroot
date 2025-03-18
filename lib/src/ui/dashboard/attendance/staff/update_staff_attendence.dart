import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/attendance/staff/update_staff_attendance_controller.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class UpdateStaffAttendanceScreen extends StatelessWidget {
  const UpdateStaffAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UpdateStaffAttendanceController(),
      builder: (logic) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ConstClass.dashBoardColor,
          title: AppUtil.customText(
            text: "Update Student Attendance",
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
                  customDropDown(
                    "Select Staff",
                    ""
                    // logic.staffHomeWorkController.staffDetails!.name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customDropDown("Select Class", ""

                      // logic.staffHomeWorkController.staffClass!.dataListItemName,
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  customDropDown("Select Section", ""
                      // logic.staffHomeWorkController.staffSection!
                      //     .dataListItemName,
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
                                                            ? const Icon(
                                                                Icons.check_box)
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
                                                            textAlign: TextAlign
                                                                .center,
                                                            text: getColumnName(
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
                                      rows: logic.studentAttendanceDatList
                                          .asMap()
                                          .map((index, item) {
                                            return MapEntry(
                                                index,
                                                DataRow(
                                                  cells: [
                                                    datacell("${index + 1}"),
                                                    datacell(item.studentName),
                                                    datacell(item.className),
                                                    datacell(item.sectionName),
                                                    datacell("A"),
                                                    DataCell(IconButton(
                                                      onPressed: () {
                                                        logic
                                                            .markFullAttendance(
                                                                item, index);
                                                      },
                                                      icon: item.markFullDayAbsent ==
                                                              "True"
                                                          ? const Icon(
                                                              Icons.check_box)
                                                          : const Icon(Icons
                                                              .check_box_outline_blank),
                                                      color:
                                                          ConstClass.themeColor,
                                                    )),
                                                    datacell("H"),
                                                    DataCell(IconButton(
                                                      onPressed: () {
                                                        logic
                                                            .markHalfAttendance(
                                                                item);
                                                      },
                                                      icon: item.markHalfDayAbsent! ==
                                                              "True"
                                                          ? const Icon(
                                                              Icons.check_box)
                                                          : const Icon(Icons
                                                              .check_box_outline_blank),
                                                      color:
                                                          ConstClass.themeColor,
                                                    )),
                                                    datacell("O"),
                                                    DataCell(IconButton(
                                                      onPressed: () {
                                                        logic
                                                            .markOtherAttendance(
                                                                item);
                                                      },
                                                      icon: item.others! ==
                                                              "True"
                                                          ? const Icon(
                                                              Icons.check_box)
                                                          : const Icon(Icons
                                                              .check_box_outline_blank),
                                                      color:
                                                          ConstClass.themeColor,
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: const Color(0xffF1F5F9),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Obx(() {
                if (!logic.isDataFound.value) {
                  return const SizedBox();
                } else if (logic.updateAttenShowProgress.value) {
                  return const SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  return SizedBox(
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
                                horizontal: 0, vertical: 12),
                            child: AppUtil.customText(
                              text: "Update Student Attendance",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )), () {
                      logic.updateAttendance();
                    }),
                  );
                }
              })),
        ),
      ),
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

  String getCellData(int rowIndex, int colIndex) {
    switch (colIndex) {
      case 0:
        return (rowIndex + 1).toString();
      case 1:
        return 'Student ${rowIndex + 1}';
      case 2:
        return 'A';
      case 4:
        return 'H';
      case 6:
        return 'Other';
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
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
