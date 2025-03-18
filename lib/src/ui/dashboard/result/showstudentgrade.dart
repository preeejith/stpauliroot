import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iroots/bloc/blocmodels/studentreportcardmodel.dart';
import 'package:iroots/src/ui/dashboard/feedetails/feedetails_screen.dart';
import 'package:iroots/src/utility/app_colors.dart';

import '../../../../bloc/mainbloc.dart';

//mestudentgradecard
class StudentGradeCard extends StatefulWidget {
  const StudentGradeCard({super.key});

  @override
  State<StudentGradeCard> createState() => _StudentGradeCardState();
}

class _StudentGradeCardState extends State<StudentGradeCard> {
  num term1therorytotalmark = 0;
  num term2therorytotalmark = 0;
  num term3therorytotalmark = 0;
  num term3practicsltotalmark = 0;
  num term3grandtotaltotalmark = 0;
  GradingCriteria gradeInfo = GradingCriteria();
  GradingCriteria gradeInfoterm2 = GradingCriteria();
  GradingCriteria gradeInfoterm3 = GradingCriteria();

  @override
  void initState() {
    // BlocProvider.of<MainBloc>(context).add(GetAdminExmPublishDetails());

    BlocProvider.of<MainBloc>(context).add(GetStudentGradeCard());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.contentColorBlue,
        title: Text(
          "Result",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return context.read<MainBloc>().studReportCardModel.studentData ==
                    null
                ? context.read<MainBloc>().term1exmhpn == false
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Center(child: Text("No Data Found")),
                      )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 19.0, bottom: 4),
                          child: InkWell(
                            child: Text(
                              "Performance Profile",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             FeeDetailsScreen()));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: const Color.fromARGB(255, 220, 232, 247),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundColor: Colors.blue,
                                        backgroundImage: AssetImage(
                                            "assets/images/studentimg.png"),
                                      ),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 3.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              context
                                                  .read<MainBloc>()
                                                  .studReportCardModel
                                                  .studentData!
                                                  .studentName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Text(context
                                                    .read<MainBloc>()
                                                    .studReportCardModel
                                                    .studentData!
                                                    .promotedClass
                                                    .toString()),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "  Roll No:${context.read<MainBloc>().studReportCardModel.studentData!.rollNo ?? "-"}"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Roll Number",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          context
                                                      .read<MainBloc>()
                                                      .studReportCardModel
                                                      .studentData!
                                                      .rollNo ==
                                                  null
                                              ? "-"
                                              : context
                                                  .read<MainBloc>()
                                                  .studReportCardModel
                                                  .studentData!
                                                  .rollNo
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Date of Birth",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          _formatDate(context
                                              .read<MainBloc>()
                                              .studReportCardModel
                                              .studentData!
                                              .dateOfBirth),
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(9.0),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Text(
                                  //         "Blood Group",
                                  //         style: TextStyle(
                                  //             color: Colors.blue,
                                  //             fontSize: 14,
                                  //             fontWeight: FontWeight.w500),
                                  //       ),
                                  //       Text(
                                  //         context
                                  //             .read<MainBloc>()
                                  //             .studReportCardModel
                                  //             .studentData!
                                  //             .batchID
                                  //             .toString(),
                                  //         style: TextStyle(
                                  //             color: Colors.blue,
                                  //             fontSize: 14,
                                  //             fontWeight: FontWeight.w500),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),

                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Emergency Contact",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "-",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Position in Class",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "12th",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Father’s Name",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          context
                                              .read<MainBloc>()
                                              .studReportCardModel
                                              .studentData!
                                              .fatherName
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Mother’s Name",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          context
                                              .read<MainBloc>()
                                              .studReportCardModel
                                              .studentData!
                                              .motherName
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Attendance",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                height: 40,
                                color: const Color.fromARGB(255, 182, 236, 184),
                                child: Center(child: Text("235 / 249 Days")),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                height: 40,
                                color: Color(0xff9f7ccbe5),
                                child: Center(child: Text("235 / 249 Days")),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // context
                      //             .read<MainBloc>()
                      //             .adminExmPublishDetailsModel
                      //             .data ==
                      //         null
                      //     ?

                      //     Text("Result Not Published")
                      //     :

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 14),
                              child: context
                                          .read<MainBloc>()
                                          .studReportCardModel
                                          .groupedSubjects ==
                                      null
                                  ? Text(
                                      "Term 1",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : context
                                              .read<MainBloc>()
                                              .studReportCardModel
                                              .groupedSubjects![0]
                                              .terms ==
                                          null
                                      ? Text(
                                          "Term 1",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : Text(
                                          context
                                              .read<MainBloc>()
                                              .studReportCardModel
                                              .groupedSubjects![0]
                                              .terms![0]
                                              .name
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                        )),
                          _termsubdata(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 14),
                            child: Text(
                              "Co-Scholastic Areas",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                          ),
                          _termsubdatacolastic(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 14),
                              child: context
                                          .read<MainBloc>()
                                          .studReportCardModelunit2
                                          .groupedSubjects ==
                                      null
                                  ? Text(
                                      "Term 2",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : context
                                              .read<MainBloc>()
                                              .studReportCardModelunit2
                                              .groupedSubjects![0]
                                              .terms ==
                                          null
                                      ? Text(
                                          "Term 2",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : Text(
                                          context
                                              .read<MainBloc>()
                                              .studReportCardModelunit2
                                              .groupedSubjects![0]
                                              .terms![0]
                                              .name
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                        )),
                          _termsubdataunit2(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 14),
                            child: Text(
                              "Co-Scholastic Areas",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                          ),
                          _termsubdataunit2coscholastic(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 14),
                              child: context
                                          .read<MainBloc>()
                                          .studReportCardModelunit3
                                          .groupedSubjects ==
                                      null
                                  ? Text(
                                      "Term 3",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : context
                                              .read<MainBloc>()
                                              .studReportCardModelunit3
                                              .groupedSubjects![0]
                                              .terms ==
                                          null
                                      ? Text(
                                          "Term 3",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : Text(
                                          context
                                              .read<MainBloc>()
                                              .studReportCardModelunit3
                                              .groupedSubjects![0]
                                              .terms![0]
                                              .name
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                        )),
                          _termsubdataunit3(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 14),
                            child: Text(
                              "Co-Scholastic Areas",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                          ),
                          _termsubdataunit3cosholastic(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 14, bottom: 18),
                            child: Row(
                              children: [
                                Text(
                                  "Result",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                ),
                                context
                                            .read<MainBloc>()
                                            .studReportCardModelunit3
                                            .obtainedPercent ==
                                        null
                                    ? Text(
                                        "-",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : Text(
                                        " : ${context.read<MainBloc>().studReportCardModelunit3.result}",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500),
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  _termsubdatacolastic() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return context
                    .read<MainBloc>()
                    .studReportCardModel
                    .coscholasticAreaData ==
                null
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      color: const Color.fromARGB(255, 201, 196, 196),
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Co-Scholastic Areas"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5.5,
                            ),
                            Text("Grade"),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                          context
                              .read<MainBloc>()
                              .studReportCardModel
                              .coscholasticAreaData!
                              .length, (index) {
                        return Container(
                          height: 35,
                          color: index % 2 != 0
                              ? const Color.fromARGB(255, 201, 196, 196)
                              : const Color.fromARGB(255, 234, 225, 225),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.9,
                                  child: Text(context
                                      .read<MainBloc>()
                                      .studReportCardModel
                                      .coscholasticAreaData![index]
                                      .name
                                      .toString()),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Text(context
                                      .read<MainBloc>()
                                      .studReportCardModel
                                      .coscholasticAreaData![index]
                                      .obtainedGrade
                                      .toString()),
                                ),
                                // context
                                //             .read<MainBloc>()
                                //             .studReportCardModel
                                //             .groupedSubjects![index]
                                //             .terms![0]
                                //             .name ==
                                //         "UT I"
                                //     ? Text(
                                //         "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].theoryMark}")
                                //     : Text("-"),
                                // context
                                //             .read<MainBloc>()
                                //             .studReportCardModel
                                //             .groupedSubjects![index]
                                //             .terms![0]
                                //             .name ==
                                //         "UT I"
                                //     ? Text(
                                //         "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].practicalMark == 0 ? "-" : context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].practicalMark}")
                                //     : Text("-"),
                                // context
                                //             .read<MainBloc>()
                                //             .studReportCardModel
                                //             .groupedSubjects![index]
                                //             .terms![0]
                                //             .name ==
                                //         "UT I"
                                //     ? Text(
                                //         "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].grade}/${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].totallMark}")
                                //     : Text("-"),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 201, 196, 196),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 234, 225, 225),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 201, 196, 196),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 234, 225, 225),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
      },
    );
  }

  _termsubdata() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return context.read<MainBloc>().studReportCardModel.groupedSubjects ==
                null
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      color: const Color.fromARGB(255, 201, 196, 196),
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subject"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 6.8,
                            ),
                            Column(
                              children: [
                                Text("Theory"),
                                // Text("(100)"),
                              ],
                            ),
                            // Text("Practical"),
                            Column(
                              children: [
                                Text("Total"),
                                context
                                            .read<MainBloc>()
                                            .studReportCardModel
                                            .groupedSubjects![0]
                                            .terms ==
                                        null
                                    ? Text("")
                                    : Text("("
                                        "${context.read<MainBloc>().studReportCardModel.groupedSubjects![0].terms![0].maximumMarks}"
                                        ")")
                              ],
                            ),
                            Text("Grade"),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Column(
                          children: List.generate(
                              context
                                  .read<MainBloc>()
                                  .studReportCardModel
                                  .groupedSubjects!
                                  .length, (index) {
                            term1therorytotalmark = context
                                .read<MainBloc>()
                                .studReportCardModel
                                .groupedSubjects!
                                .map((subject) =>
                                    subject.terms![0].theoryMark ?? 0)
                                .reduce((a, b) => a + b);

                            // Get the obtained percentage
                            final obtainedPercentage = context
                                .read<MainBloc>()
                                .studReportCardModel
                                .obtainedPercent;

// Get the grading criteria list
                            final gradingCriteria = context
                                .read<MainBloc>()
                                .studReportCardModel
                                .gradingCriteria;

// Find the matching grade
                            gradeInfo = gradingCriteria!.firstWhere(
                              (criteria) =>
                                  obtainedPercentage! >=
                                      (criteria.minimumPercentage ?? 0) &&
                                  obtainedPercentage <=
                                      (criteria.maximumPercentage ?? 100),
                              orElse: () => GradingCriteria(
                                  grade: "N/A",
                                  gradeDescription: "Not Available"),
                            );
                            return Container(
                              height: 35,
                              color: index % 2 != 0
                                  ? const Color.fromARGB(255, 201, 196, 196)
                                  : const Color.fromARGB(255, 234, 225, 225),
                              width: MediaQuery.of(context).size.width / 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(
                                        context
                                            .read<MainBloc>()
                                            .studReportCardModel
                                            .groupedSubjects![index]
                                            .subjectName
                                            .toString(),
                                        maxLines: 2,
                                      ),
                                    ),
                                    context
                                                .read<MainBloc>()
                                                .studReportCardModel
                                                .groupedSubjects![index]
                                                .terms![0]
                                                .name ==
                                            "UT I"
                                        ? Text(
                                            "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].theoryMark}")
                                        : Text("-"),
                                    // context
                                    //             .read<MainBloc>()
                                    //             .studReportCardModel
                                    //             .groupedSubjects![index]
                                    //             .terms![0]
                                    //             .name ==
                                    //         "UT I"
                                    //     ? Text(
                                    //         "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].practicalMark == 0 ? "-" : context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].practicalMark}")
                                    //     : Text("-"),
                                    context
                                                .read<MainBloc>()
                                                .studReportCardModel
                                                .groupedSubjects![index]
                                                .terms![0]
                                                .name ==
                                            "UT I"
                                        ? Text(
                                            "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].totallMark}")
                                        : Text("-"),
                                    context
                                                .read<MainBloc>()
                                                .studReportCardModel
                                                .groupedSubjects![index]
                                                .terms![0]
                                                .name ==
                                            "UT I"
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 6.0),
                                            child: Text(
                                                "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].grade}"),
                                          )
                                        : Text("-"),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        Container(
                          height: 35,
                          color: const Color.fromARGB(255, 201, 196, 196),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Text(
                                    "Total ",
                                    maxLines: 2,
                                  ),
                                ),
                                Text(term1therorytotalmark.toString()),
                                Text(term1therorytotalmark.toString()),
                                Text('${gradeInfo.grade} ')
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 35,
                          color: const Color.fromARGB(255, 201, 196, 196),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Text(
                                    "Percentage",
                                    maxLines: 2,
                                  ),
                                ),
                                Text(
                                    "${context.read<MainBloc>().studReportCardModel.obtainedPercent}%"),
                                Text(
                                    "${context.read<MainBloc>().studReportCardModel.obtainedPercent}%"),
                                Text(' ')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 201, 196, 196),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 234, 225, 225),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 201, 196, 196),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 234, 225, 225),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
      },
    );
  }

  _termsubdataunit2coscholastic() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return context
                    .read<MainBloc>()
                    .studReportCardModelunit2
                    .groupedSubjects ==
                null
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      color: const Color.fromARGB(255, 201, 196, 196),
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Co-Scholastic Areas"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 6,
                            ),
                            Text("Grade"),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                          context
                              .read<MainBloc>()
                              .studReportCardModelunit2
                              .coscholasticAreaData!
                              .length, (index) {
                        return Container(
                          height: 35,
                          color: index % 2 != 0
                              ? const Color.fromARGB(255, 201, 196, 196)
                              : const Color.fromARGB(255, 234, 225, 225),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  child: Text(context
                                      .read<MainBloc>()
                                      .studReportCardModelunit2
                                      .coscholasticAreaData![index]
                                      .name
                                      .toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                      "${context.read<MainBloc>().studReportCardModelunit2.coscholasticAreaData![index].obtainedGrade}"),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 201, 196, 196),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 234, 225, 225),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 201, 196, 196),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 234, 225, 225),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
      },
    );
  }

  _termsubdataunit2() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return context
                    .read<MainBloc>()
                    .studReportCardModelunit2
                    .groupedSubjects ==
                null
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      color: const Color.fromARGB(255, 201, 196, 196),
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subject"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 6,
                            ),
                            Column(
                              children: [
                                Text("Theory"),
                              ],
                            ),
                            // Text("Practical"),
                            Column(
                              children: [
                                Text("Total"),
                                context
                                            .read<MainBloc>()
                                            .studReportCardModelunit2
                                            .groupedSubjects![0]
                                            .terms ==
                                        null
                                    ? Text("")
                                    : Text("("
                                        "${context.read<MainBloc>().studReportCardModelunit2.groupedSubjects![0].terms![0].maximumMarks}"
                                        ")"),
                              ],
                            ),
                            Text("Grade"),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                          context
                              .read<MainBloc>()
                              .studReportCardModelunit2
                              .groupedSubjects!
                              .length, (index) {
                        term2therorytotalmark = context
                            .read<MainBloc>()
                            .studReportCardModelunit2
                            .groupedSubjects!
                            .map((subject) => subject.terms![0].theoryMark ?? 0)
                            .reduce((a, b) => a + b);

                        // Get the obtained percentage
                        final obtainedPercentage = context
                            .read<MainBloc>()
                            .studReportCardModelunit2
                            .obtainedPercent;

// Get the grading criteria list
                        final gradingCriteria = context
                            .read<MainBloc>()
                            .studReportCardModelunit2
                            .gradingCriteria;

// Find the matching grade
                        gradeInfoterm2 = gradingCriteria!.firstWhere(
                          (criteria) =>
                              obtainedPercentage! >=
                                  (criteria.minimumPercentage ?? 0) &&
                              obtainedPercentage <=
                                  (criteria.maximumPercentage ?? 100),
                          orElse: () => GradingCriteria(
                              grade: "N/A", gradeDescription: "Not Available"),
                        );

                        return Container(
                          height: 35,
                          color: index % 2 != 0
                              ? const Color.fromARGB(255, 201, 196, 196)
                              : const Color.fromARGB(255, 234, 225, 225),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  child: Text(context
                                      .read<MainBloc>()
                                      .studReportCardModelunit2
                                      .groupedSubjects![index]
                                      .subjectName
                                      .toString()),
                                ),
                                context
                                        .read<MainBloc>()
                                        .studReportCardModelunit2
                                        .groupedSubjects![index]
                                        .terms!
                                        .isEmpty
                                    ? Text("-")
                                    : context
                                                .read<MainBloc>()
                                                .studReportCardModelunit2
                                                .groupedSubjects![index]
                                                .terms![0]
                                                .name ==
                                            "UT II"
                                        ? Text(
                                            "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].theoryMark}")
                                        : Text("-"),
                                // context
                                //         .read<MainBloc>()
                                //         .studReportCardModelunit2
                                //         .groupedSubjects![index]
                                //         .terms!
                                //         .isEmpty
                                //     ? Text("-")
                                //     : context
                                //                 .read<MainBloc>()
                                //                 .studReportCardModelunit2
                                //                 .groupedSubjects![index]
                                //                 .terms![0]
                                //                 .name ==
                                //             "UT II"
                                //         ? Text(
                                //             "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].practicalMark == 0 ? "-" : context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].practicalMark}")
                                //         : Text("-"),
                                context
                                        .read<MainBloc>()
                                        .studReportCardModelunit2
                                        .groupedSubjects![index]
                                        .terms!
                                        .isEmpty
                                    ? Text("-")
                                    : context
                                                .read<MainBloc>()
                                                .studReportCardModelunit2
                                                .groupedSubjects![index]
                                                .terms![0]
                                                .name ==
                                            "UT II"
                                        ? Text(
                                            "${context.read<MainBloc>().studReportCardModel.groupedSubjects![index].terms![0].totallMark}")
                                        : Text("-"),
                                context
                                        .read<MainBloc>()
                                        .studReportCardModelunit2
                                        .groupedSubjects![index]
                                        .terms!
                                        .isEmpty
                                    ? Text("-")
                                    : context
                                                .read<MainBloc>()
                                                .studReportCardModelunit2
                                                .groupedSubjects![index]
                                                .terms![0]
                                                .name ==
                                            "UT II"
                                        ? Text(
                                            "${context.read<MainBloc>().studReportCardModelunit2.groupedSubjects![index].terms![0].grade}")
                                        : Text("-"),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),

                    Container(
                      height: 35,
                      color: const Color.fromARGB(255, 201, 196, 196),
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Total ",
                                maxLines: 2,
                              ),
                            ),
                            Text(term2therorytotalmark.toString()),
                            Text(term2therorytotalmark.toString()),
                            Text('${gradeInfoterm2.grade} ')
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      color: const Color.fromARGB(255, 201, 196, 196),
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Percentage",
                                maxLines: 2,
                              ),
                            ),
                            Text(
                                "${context.read<MainBloc>().studReportCardModelunit2.obtainedPercent}%"),
                            Text(
                                "${context.read<MainBloc>().studReportCardModelunit2.obtainedPercent}%"),
                            Text(' ')
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 201, 196, 196),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 234, 225, 225),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 201, 196, 196),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 35,
                    //   color: const Color.fromARGB(255, 234, 225, 225),
                    //   width: MediaQuery.of(context).size.width / 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("English"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //         Text("A/90"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
      },
    );
  }

  _termsubdataunit3cosholastic() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return context.read<MainBloc>().studReportCardModelunit3 == null
            ? SizedBox.shrink()
            : context
                        .read<MainBloc>()
                        .studReportCardModelunit3
                        .groupedSubjects ==
                    null
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          height: 35,
                          color: const Color.fromARGB(255, 201, 196, 196),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Co-Scholastic Area"),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                ),
                                Text("Grade"),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              context
                                  .read<MainBloc>()
                                  .studReportCardModelunit3
                                  .coscholasticAreaData!
                                  .length, (index2) {
                            return Container(
                              height: 35,
                              color: index2 % 2 != 0
                                  ? const Color.fromARGB(255, 201, 196, 196)
                                  : const Color.fromARGB(255, 234, 225, 225),
                              width: MediaQuery.of(context).size.width / 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      child: Text(context
                                          .read<MainBloc>()
                                          .studReportCardModelunit3
                                          .coscholasticAreaData![index2]
                                          .name
                                          .toString()),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 6.0),
                                      child: Text(
                                          "${context.read<MainBloc>().studReportCardModelunit3.coscholasticAreaData![index2].obtainedGrade}"),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
      },
    );
  }

  _termsubdataunit3() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return context.read<MainBloc>().studReportCardModelunit3 == null
            ? SizedBox.shrink()
            : context
                        .read<MainBloc>()
                        .studReportCardModelunit3
                        .groupedSubjects ==
                    null
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          height: 65,
                          color: const Color.fromARGB(255, 201, 196, 196),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subject"),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                ),
                                Text("Theory"),
                                Column(
                                  children: [
                                    Text("Practical"),
                                    context
                                                .read<MainBloc>()
                                                .studReportCardModelunit3
                                                .groupedSubjects![0]
                                                .terms ==
                                            null
                                        ? Text("")
                                        : Text("("
                                            "${context.read<MainBloc>().studReportCardModelunit3.groupedSubjects![0].terms![0].maximumMarks}"
                                            ")"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Total"),
                                    context
                                                .read<MainBloc>()
                                                .studReportCardModelunit3
                                                .groupedSubjects![0]
                                                .terms ==
                                            null
                                        ? Text("")
                                        : Text("("
                                            "${context.read<MainBloc>().studReportCardModelunit3.groupedSubjects![0].terms![0].maximumMarks}"
                                            ")"),
                                  ],
                                ),
                                Text("Grade"),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              context
                                  .read<MainBloc>()
                                  .studReportCardModelunit3
                                  .groupedSubjects!
                                  .length, (index2) {
                            if (context
                                .read<MainBloc>()
                                .studReportCardModelunit3
                                .groupedSubjects![index2]
                                .terms!
                                .isNotEmpty) {
                              term3therorytotalmark = context
                                  .read<MainBloc>()
                                  .studReportCardModelunit3
                                  .groupedSubjects!
                                  .map((subject) => subject.terms!.isEmpty
                                      ? 0
                                      : subject.terms![0].theoryMark ?? 0)
                                  .reduce((a, b) => a + b);
                            }
                            if (context
                                .read<MainBloc>()
                                .studReportCardModelunit3
                                .groupedSubjects![index2]
                                .terms!
                                .isNotEmpty) {
                              term3practicsltotalmark = context
                                  .read<MainBloc>()
                                  .studReportCardModelunit3
                                  .groupedSubjects!
                                  .map((subject) => subject.terms!.isEmpty
                                      ? 0
                                      : subject.terms![0].practicalMark ?? 0)
                                  .reduce((a, b) => a + b);
                            }

                            if (context
                                .read<MainBloc>()
                                .studReportCardModelunit3
                                .groupedSubjects![index2]
                                .terms!
                                .isNotEmpty) {
                              term3grandtotaltotalmark = context
                                  .read<MainBloc>()
                                  .studReportCardModelunit3
                                  .groupedSubjects!
                                  .map((subject) => subject.terms!.isEmpty
                                      ? 0
                                      : subject.terms![0].totallMark ?? 0)
                                  .reduce((a, b) => a + b);
                            }
                            // Get the obtained percentage
                            final obtainedPercentage = context
                                .read<MainBloc>()
                                .studReportCardModelunit3
                                .obtainedPercent;

// Get the grading criteria list
                            final gradingCriteria = context
                                .read<MainBloc>()
                                .studReportCardModelunit3
                                .gradingCriteria;

// Find the matching grade
                            gradeInfoterm3 = gradingCriteria!.firstWhere(
                              (criteria) =>
                                  obtainedPercentage! >=
                                      (criteria.minimumPercentage ?? 0) &&
                                  obtainedPercentage <=
                                      (criteria.maximumPercentage ?? 100),
                              orElse: () => GradingCriteria(
                                  grade: "N/A",
                                  gradeDescription: "Not Available"),
                            );
                            return Container(
                              height: 35,
                              color: index2 % 2 != 0
                                  ? const Color.fromARGB(255, 201, 196, 196)
                                  : const Color.fromARGB(255, 234, 225, 225),
                              width: MediaQuery.of(context).size.width / 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      child: Text(context
                                          .read<MainBloc>()
                                          .studReportCardModelunit3
                                          .groupedSubjects![index2]
                                          .subjectName
                                          .toString()),
                                    ),
                                    context
                                            .read<MainBloc>()
                                            .studReportCardModelunit3
                                            .groupedSubjects![index2]
                                            .terms!
                                            .isEmpty
                                        ? Text("-")
                                        : context
                                                    .read<MainBloc>()
                                                    .studReportCardModelunit3
                                                    .groupedSubjects![index2]
                                                    .terms![0]
                                                    .name ==
                                                "TERM - I"
                                            ? Text(
                                                "${context.read<MainBloc>().studReportCardModelunit3.groupedSubjects![index2].terms![0].theoryMark}")
                                            : Text("-"),
                                    context
                                            .read<MainBloc>()
                                            .studReportCardModelunit3
                                            .groupedSubjects![index2]
                                            .terms!
                                            .isEmpty
                                        ? Text("-")
                                        : context
                                                    .read<MainBloc>()
                                                    .studReportCardModelunit3
                                                    .groupedSubjects![index2]
                                                    .terms![0]
                                                    .name ==
                                                "TERM - I"
                                            ? Text(
                                                "${context.read<MainBloc>().studReportCardModelunit3.groupedSubjects![index2].terms![0].practicalMark == 0 ? "-" : context.read<MainBloc>().studReportCardModelunit3.groupedSubjects![index2].terms![0].practicalMark}")
                                            : Text("-"),
                                    context
                                            .read<MainBloc>()
                                            .studReportCardModelunit3
                                            .groupedSubjects![index2]
                                            .terms!
                                            .isEmpty
                                        ? Text("-")
                                        : context
                                                    .read<MainBloc>()
                                                    .studReportCardModelunit3
                                                    .groupedSubjects![index2]
                                                    .terms![0]
                                                    .name ==
                                                "TERM - I"
                                            ? Text(
                                                "${context.read<MainBloc>().studReportCardModelunit3.groupedSubjects![index2].terms![0].totallMark}")
                                            : Text("-"),
                                    context
                                            .read<MainBloc>()
                                            .studReportCardModelunit3
                                            .groupedSubjects![index2]
                                            .terms!
                                            .isEmpty
                                        ? Text("-")
                                        : context
                                                    .read<MainBloc>()
                                                    .studReportCardModelunit3
                                                    .groupedSubjects![index2]
                                                    .terms![0]
                                                    .name ==
                                                "TERM - I"
                                            ? Text(
                                                "${context.read<MainBloc>().studReportCardModelunit3.groupedSubjects![index2].terms![0].grade}")
                                            : Text("-"),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),

                        Container(
                          height: 35,
                          color: const Color.fromARGB(255, 201, 196, 196),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Text(
                                    "Total ",
                                    maxLines: 2,
                                  ),
                                ),
                                Text(term3therorytotalmark.toString()),
                                Text(term3practicsltotalmark.toString()),
                                Text(term3grandtotaltotalmark.toString()),
                                Text('${gradeInfoterm3.grade} ')
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 35,
                          color: const Color.fromARGB(255, 201, 196, 196),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Text(
                                    "Percentage",
                                    maxLines: 2,
                                  ),
                                ),
                                // Text(
                                //     "${context.read<MainBloc>().studReportCardModelunit3.obtainedPercent}%"),
                                Text(
                                    "${context.read<MainBloc>().studReportCardModelunit3.obtainedPercent}%"),
                                Text(' ')
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 35,
                        //   color: const Color.fromARGB(255, 201, 196, 196),
                        //   width: MediaQuery.of(context).size.width / 1,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("English"),
                        //         Text("A/90"),
                        //         Text("A/90"),
                        //         Text("A/90"),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   height: 35,
                        //   color: const Color.fromARGB(255, 234, 225, 225),
                        //   width: MediaQuery.of(context).size.width / 1,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("English"),
                        //         Text("A/90"),
                        //         Text("A/90"),
                        //         Text("A/90"),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   height: 35,
                        //   color: const Color.fromARGB(255, 201, 196, 196),
                        //   width: MediaQuery.of(context).size.width / 1,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("English"),
                        //         Text("A/90"),
                        //         Text("A/90"),
                        //         Text("A/90"),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   height: 35,
                        //   color: const Color.fromARGB(255, 234, 225, 225),
                        //   width: MediaQuery.of(context).size.width / 1,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("English"),
                        //         Text("A/90"),
                        //         Text("A/90"),
                        //         Text("A/90"),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  );
      },
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty)
      return "N/A"; // Handle null or empty cases
    try {
      DateTime parsedDate = DateFormat("d/M/yyyy hh:mm:ss a").parse(dateStr);
      return DateFormat("dd-MM-yyyy")
          .format(parsedDate); // Change format as needed
    } catch (e) {
      return "Invalid Date"; // Fallback in case of parsing failure
    }
  }
}
