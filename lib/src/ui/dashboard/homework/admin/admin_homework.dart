import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/modal/homework/getHomeworkModalClass.dart';
import 'package:iroots/src/ui/dashboard/homework/admin/admin_create_homework.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

import '../../../../controller/homework/admin/admin_homework_controller.dart';

class AdminHomeworkScreen extends StatelessWidget {
  const AdminHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AdminHomeWorkController(),
        builder: (logic) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ConstClass.dashBoardColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppUtil.customText(
                      text: "Homework",
                      style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: SvgPicture.asset(
                        "assets/icons/homework_icons/icon_homework_filter.svg",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xff1575FF),
                onPressed: () {
                  Get.to(() => const AdminCreateHomeworkScreen());
                },
                // isExtended: true,
                child: const Icon(Icons.add),
              ),
              body: SingleChildScrollView(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        AppUtil.customDropDown(
                            logic,
                            "Select Class",
                            "Please Select Class",
                            logic.dashBoardController.adminClassDataList,
                            (newValue) {
                          logic.selectedClass = newValue;
                        }, logic.selectedClass),
                        const SizedBox(
                          height: 10,
                        ),
                        AppUtil.customDropDown(
                            logic,
                            "Select Section",
                            "Please Select Section",
                            logic.dashBoardController.adminSectionDataList,
                            (newValue) {
                          logic.selectedSection = newValue;
                        }, logic.selectedSection),
                        const SizedBox(
                          height: 10,
                        ),
                        AppUtil.customDropDown(
                            logic,
                            "Select Subject",
                            "Please Select Subject",
                            logic.dashBoardController.adminCourseDataList,
                            (newValue) {
                          logic.selectedCourse = newValue;
                        }, logic.selectedCourse),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          if (logic.showProgress.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return SizedBox(
                              width: Get.width,
                              child: AppUtil.customOutlinedButton(
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
                                logic.showHomeWork();
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
                          } else if (logic.isHomeWorkDataFound.value) {
                            return ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: logic.getHomeworkDataList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {},
                                    child: buildHomeworkWidget(
                                        logic.getHomeworkDataList[index]));
                              },
                            );
                          } else {
                            return AppUtil.noDataFound(
                                "No Homework Data Found");
                          }
                        })
                      ],
                    )),
              ),
            ));
  }

  Widget rowTextWidget(String titleKey, String? titleValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppUtil.customText(
          text: titleKey,
          style: const TextStyle(
              color: Color(0xff64748B),
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
              fontSize: 12),
        ),
        AppUtil.customText(
          text: titleValue,
          style: const TextStyle(
              color: Color(0xff334155),
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 12),
        ),
      ],
    );
  }

  Widget buildHomeworkWidget(GetHomeWorkData homeworkModal) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF1F5F9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: homeworkModal.subjectName != null
                      ? AppUtil.customText(
                          text: homeworkModal.subjectName,
                          style: TextStyle(
                              color: ConstClass.themeColor,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 10),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            AppUtil.customText(
              text: homeworkModal.newAssignment,
              style: const TextStyle(
                  color: Color(0xff0F172A),
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            ),
            rowTextWidget("Last Submission Date", homeworkModal.submittedDate),
            const SizedBox(
              height: 5,
            ),
            rowTextWidget("Class Name", homeworkModal.className),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  /*Widget buildHomeworkWidget(StaffHomeworkModal homeworkModal) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF1F5F9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: AppUtil.customText(
                    text: homeworkModal.subjectName,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ConstClass.themeColor,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 10.),
                  ),
                ),
                homeworkModal.completed == 0
                    ? const SizedBox()
                    : homeworkModal.completed == 1
                        ? allCompletedRowWidget()
                        : notsubmitRowWidget()
              ],
            ),
            SizedBox(
              height: 5,
            ),
            AppUtil.customText(
              text: homeworkModal.topicName,
              style: TextStyle(
                  color: const Color(0xff0F172A),
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 14.),
            ),
            SizedBox(
              height: 5,
            ),
            rowTextWidget("Last Submission Date", homeworkModal.lastSubDate),
            SizedBox(
              height: 5,
            ),
            rowTextWidget("Class Name", homeworkModal.className),
            SizedBox(
              height: 5,
            ),
            rowTextWidget("Student(s)", homeworkModal.students),
          ],
        ),
      ),
    );
  }*/

  Widget notsubmitRowWidget() {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/homework_icons/icon_not_sub.svg",
          height: 12,
          width: 12,
        ),
        const SizedBox(
          width: 5,
        ),
        AppUtil.customText(
          text: "2 Stud. not submitted",
          style: const TextStyle(
              color: Color(0xffE11D48),
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
              fontSize: 10),
        )
      ],
    );
  }
}

Widget allCompletedRowWidget() {
  return Row(
    children: [
      SvgPicture.asset(
        "assets/icons/homework_icons/completed_checkBox.svg",
        height: 12,
        width: 12,
      ),
      const SizedBox(
        width: 5,
      ),
      AppUtil.customText(
        text: "All Completed",
        style: const TextStyle(
            color: Color(0xff0DB166),
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
            fontSize: 10),
      )
    ],
  );
}
