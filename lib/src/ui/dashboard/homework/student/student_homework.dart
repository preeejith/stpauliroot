import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/homework/student/student_homework_controller.dart';
import 'package:iroots/src/modal/homework/getHomeworkModalClass.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class StudentHomeworkScreen extends StatelessWidget {
  const StudentHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: StudentHomeWorkController(),
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
              body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Obx(() {
                    if (logic.homeWorkProgress.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (logic.isHomeWorkDataFound.value) {
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getHomeworkDataList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {},
                              child: buildHomeworkWidget(
                                  logic.getHomeworkDataList[index]));
                        },
                      );
                    } else {
                      return AppUtil.noDataFound("No Homework Data Found");
                    }
                  })),
            ));
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
}
