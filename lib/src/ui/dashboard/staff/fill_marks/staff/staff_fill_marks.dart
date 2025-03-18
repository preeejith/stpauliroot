import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/ui/dashboard/reports/staff_report_card.dart';
import 'package:iroots/src/ui/dashboard/staff/fill_marks/staff/staff_fill_controller.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class StaffFillMarksScreen extends StatelessWidget {
  StaffFillMarksScreen({super.key});

  final StaffFillController con = Get.put(StaffFillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstClass.dashBoardColor,
        title: AppUtil.customText(
          text: "Fill Marks",
          style: const TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const StaffReportCardScreen());
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              child: SvgPicture.asset(
                color: Colors.white,
                "assets/icons/academicIcons/academics_home_icon.svg",
                height: 20,
                width: 20,
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => con.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  color: const Color(0xffF1F5F9),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customDropDown(
                            "Select Staff",
                            con.selectedStaff.value.name ?? "",
                          ),
                          // SizedBox(height: 10.h),
                          // customDropDown(
                          //   "Select Class",
                          //   logic.staffHomeWorkController.staffClass
                          //           ?.dataListItemName ??
                          //       "",
                          // ),
                          // SizedBox(height: 10.h),
                          // customDropDown(
                          //   "Select Section",
                          //   logic.staffHomeWorkController.staffSection
                          //           ?.dataListItemName ??
                          //       "",
                          // ),
                          // SizedBox(height: 10.h),
                          // customDropDown(
                          //   "Select Term",
                          //   logic.staffHomeWorkController.staffSection
                          //           ?.dataListItemName ??
                          //       "",
                          // ),
                          // SizedBox(height: 10.h),
                          // AppUtil.customText(
                          //   text: "Select Date",
                          //   style: TextStyle(
                          //     fontFamily: 'Open Sans',
                          //     fontWeight: FontWeight.w600,
                          //     fontSize: 14.sp,
                          //   ),
                          // ),
                          // SizedBox(height: 5.h),
                          // customOutlinedButton(
                          //     OutlinedButton.styleFrom(
                          //       side: const BorderSide(
                          //         width: 1.0,
                          //         color: Color(0xff94A3B8),
                          //       ),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(8.0),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: EdgeInsets.symmetric(
                          //         horizontal: 0.w,
                          //         vertical: 10.h,
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           AppUtil.customText(
                          //             text: logic.formatDate(),
                          //             style: TextStyle(
                          //               color: const Color(0xff0F172A),
                          //               fontFamily: 'Open Sans',
                          //               fontWeight: FontWeight.w400,
                          //               fontSize: 14.sp,
                          //             ),
                          //           ),
                          //           SvgPicture.asset(
                          //             "assets/icons/calendar_icon.svg",
                          //             height: 20.h,
                          //             width: 20.w,
                          //           )
                          //         ],
                          //       ),
                          //     ), () {
                          //   logic.pickDateDialog(context);
                          // }),
                          // SizedBox(height: 10.h),
                          // Obx(() {
                          //   if (logic.showProgress.value) {
                          //     return const Center(child: CircularProgressIndicator());
                          //   } else {
                          //     return SizedBox(
                          //       width: 1.sw,
                          //       child: customOutlinedButton(
                          //           OutlinedButton.styleFrom(
                          //             side: const BorderSide(
                          //               width: 1.0,
                          //               color: Color(0xff94A3B8),
                          //             ),
                          //             shape: RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.circular(8.0),
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsets.symmetric(
                          //               horizontal: 0.w,
                          //               vertical: 10.h,
                          //             ),
                          //             child: AppUtil.customText(
                          //               text: "Show",
                          //               style: TextStyle(
                          //                 color: const Color(0xff1575FF),
                          //                 fontFamily: 'Open Sans',
                          //                 fontWeight: FontWeight.w600,
                          //                 fontSize: 16.sp,
                          //               ),
                          //             ),
                          //           ), () {
                          //         logic.showStudentAttendance();
                          //       }),
                          //     );
                          //   }
                          // }),
                          // SizedBox(height: 10.h),
                          // _Note(
                          //   onTap: () {
                          //     logic.isDropDownOpen();
                          //   },
                          //   visible: logic.isNotesOpen,
                          // ),
                          // SizedBox(height: 10.h),
                          // Obx(() {
                          //   if (logic.isFirstTime.value) {
                          //     return const SizedBox();
                          //   } else if (logic.isDataFound.value) {
                          //     return ConstrainedBox(
                          //       constraints: BoxConstraints(maxHeight: 255.h),
                          //       child: Scrollbar(
                          //         controller: logic.verticalScrollController,
                          //         thickness: 8,
                          //         radius: const Radius.circular(8),
                          //         interactive: true,
                          //         thumbVisibility: true,
                          //         child: SingleChildScrollView(
                          //           controller: logic.verticalScrollController,
                          //           scrollDirection: Axis.vertical,
                          //           child: Scrollbar(
                          //             controller: logic.horizontalScrollController,
                          //             thickness: 8,
                          //             radius: const Radius.circular(8),
                          //             interactive: true,
                          //             thumbVisibility: true,
                          //             child: SingleChildScrollView(
                          //               controller: logic.horizontalScrollController,
                          //               scrollDirection: Axis.horizontal,
                          //               child: Scrollable(
                          //                 viewportBuilder: (BuildContext context,
                          //                     ViewportOffset position) {
                          //                   return DataTable(
                          //                     border: TableBorder.all(),
                          //                     columns: List<DataColumn>.generate(
                          //                       5,
                          //                       (index) => DataColumn(
                          //                           label: AppUtil.customText(
                          //                         textAlign: TextAlign.center,
                          //                         text: getColumnName(index),
                          //                         style: TextStyle(
                          //                           color: const Color(0xff0F172A),
                          //                           fontFamily: 'Open Sans',
                          //                           fontWeight: FontWeight.w600,
                          //                           fontSize: 12.sp,
                          //                         ),
                          //                       )),
                          //                     ),
                          //                     rows: logic.dummyList
                          //                         .asMap()
                          //                         .map((index, item) {
                          //                           return MapEntry(
                          //                             index,
                          //                             DataRow(
                          //                               cells: [
                          //                                 dataCell("${index + 1}"),
                          //                                 dataCell(item.studentName),
                          //                                 DataCell(
                          //                                   widgetTextField(
                          //                                     controllerEmail:
                          //                                         logic.controller,
                          //                                     hint: "",
                          //                                     maxLength: 50,
                          //                                     keyboardType:
                          //                                         TextInputType.text,
                          //                                   ),
                          //                                 ),
                          //                                 DataCell(
                          //                                   widgetTextField(
                          //                                     controllerEmail:
                          //                                         logic.controller,
                          //                                     hint: "",
                          //                                     maxLength: 50,
                          //                                     keyboardType:
                          //                                         TextInputType.text,
                          //                                   ),
                          //                                 ),
                          //                                 DataCell(
                          //                                   widgetTextField(
                          //                                     controllerEmail:
                          //                                         logic.controller,
                          //                                     hint: "",
                          //                                     maxLength: 50,
                          //                                     keyboardType:
                          //                                         TextInputType.text,
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           );
                          //                         })
                          //                         .values
                          //                         .toList(),
                          //                   );
                          //                 },
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   } else if (!logic.showProgress.value) {
                          //     return Padding(
                          //       padding: const EdgeInsets.all(50.0),
                          //       child: AppUtil.noDataFound("No Data Found"),
                          //     );
                          //   } else {
                          //     return const SizedBox();
                          //   }
                          // }),
                          // Obx(() {
                          //   if (logic.isDataFound.value) {
                          //     return SizedBox(height: 24.h);
                          //   } else {
                          //     return const SizedBox();
                          //   }
                          // }),
                          // SizedBox(
                          //   width: 1.sw,
                          //   child: customOutlinedButton(
                          //       OutlinedButton.styleFrom(
                          //         backgroundColor: ConstClass.themeColor,
                          //         side: BorderSide(
                          //           width: 1.5,
                          //           color: ConstClass.themeColor,
                          //         ),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(8.0),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: 0.w, vertical: 10.h),
                          //         child: AppUtil.customText(
                          //           text: "Save",
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //             fontFamily: 'Open Sans',
                          //             fontWeight: FontWeight.w600,
                          //             fontSize: 14.sp,
                          //           ),
                          //         ),
                          //       ),
                          //       () {}),
                          // ),
                          // SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  static Widget widgetTextField({
    required TextEditingController controllerEmail,
    required String hint,
    required TextInputType? keyboardType,
    required int maxLength,
    bool? isPassword,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: isPassword ?? false,
        controller: controllerEmail,
        decoration: InputDecoration(
          hintText: hint,
          counterText: '',
          contentPadding: const EdgeInsets.all(0),
          fillColor: Colors.white,
          filled: true,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff94A3B8),
              width: Get.width,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff94A3B8),
              width: Get.width,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        maxLength: maxLength,
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
        return 'English Lang UT-1\n(Theory,UT I)';
      case 3:
        return 'English Dctn Term\nII(Theory,TERM-II)';
      case 4:
        return 'English Writing Term\nII(Theory,TERM-II)';
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

  DataCell dataCell(String? text) {
    return DataCell(
      AppUtil.customText(
        textAlign: TextAlign.center,
        text: text,
        style: const TextStyle(
          color: Color(0xff334155),
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
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
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 2),
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
                        fontSize: 14,
                      ),
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

class _Note extends StatelessWidget {
  final void Function()? onTap;
  final bool visible;

  const _Note({
    this.onTap,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFFF1F2),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppUtil.customText(
                text: "Important Note:",
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset(
                  "assets/icons/${visible ? "arrow_down" : "arrow_up"}.svg",
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: visible,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppUtil.customText(
                  text: "• Absent mark will be indicated by '-1'.",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                AppUtil.customText(
                  text: "• Please enter only '-1' and digits.",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                AppUtil.customText(
                  text:
                      "• If the entered marks exceed the maximum marks,the input field will be outlined in red to indicate the exceeded value.",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                AppUtil.customText(
                  text:
                      "• For optional subjects, these marks correspond to the following grades: \n     • 1 - A \n     • 2 - B \n     • 3 - C \n     • 4 - D",
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
