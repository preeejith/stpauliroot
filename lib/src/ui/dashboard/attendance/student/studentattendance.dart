import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iroots/bloc/mainbloc.dart';
import 'package:iroots/src/ui/dashboard/attendance/student/studentattendancedetails.dart';
import 'package:iroots/src/utility/const.dart';

class StudentsAttendence extends StatefulWidget {
  const StudentsAttendence({super.key});

  @override
  State<StudentsAttendence> createState() => _StudentsAttendenceState();
}

class _StudentsAttendenceState extends State<StudentsAttendence> {
  @override
  void initState() {
    BlocProvider.of<MainBloc>(context).add(GetStudentAttendance());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ConstClass.themeColor,
          title: InkWell(
            child: Text(
              "Attendance",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentsAttendence()));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              return context.read<MainBloc>().studentAttendanceModel.data ==
                      null
                  ? Center(child: CircularProgressIndicator())
                  : context
                          .read<MainBloc>()
                          .studentAttendanceModel
                          .data!
                          .yearlyAttendanceSummary!
                          .isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 38.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(child: Text("No Data Found")),
                            ],
                          ),
                        )
                      : Column(
                          children: List.generate(
                              context
                                  .read<MainBloc>()
                                  .studentAttendanceModel
                                  .data!
                                  .yearlyAttendanceSummary!
                                  .length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              spacing: .2,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, bottom: 4),
                                  child: Text(
                                    // "",
                                    context
                                                .read<MainBloc>()
                                                .studentAttendanceModel
                                                .data ==
                                            null
                                        ? ""
                                        : context
                                                    .read<MainBloc>()
                                                    .studentAttendanceModel
                                                    .data!
                                                    .yearlyAttendanceSummary ==
                                                null
                                            ? ""
                                            :
                                            // context
                                            //     .read<MainBloc>()
                                            //     .studentAttendanceModel
                                            //     .data!
                                            //     .yearlyAttendanceSummary![index]
                                            //     .month!
                                            //     .toString(),
                                            months[context
                                                    .read<MainBloc>()
                                                    .studentAttendanceModel
                                                    .data!
                                                    .yearlyAttendanceSummary![
                                                        index]
                                                    .month! -
                                                1],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        child: InkWell(
                                          child: Container(
                                            height: 70,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 189, 240, 194),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 67, 183, 78),
                                                  width: 1.0),
                                            ),
                                            // height: 30,
                                            // width: 40,

                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  Text(
                                                      context
                                                          .read<MainBloc>()
                                                          .studentAttendanceModel
                                                          .data!
                                                          .yearlyAttendanceSummary![
                                                              index]
                                                          .totalPresent
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              84,
                                                              180,
                                                              94))),
                                                  Text("Present",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 14, 181, 31),
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              )),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => StudentAttendanceDetailed(
                                                        index: index,
                                                        month: context
                                                            .read<MainBloc>()
                                                            .studentAttendanceModel
                                                            .data!
                                                            .yearlyAttendanceSummary![
                                                                index]
                                                            .month,
                                                        year: context
                                                            .read<MainBloc>()
                                                            .studentAttendanceModel
                                                            .data!
                                                            .yearlyAttendanceSummary![
                                                                index]
                                                            .year,
                                                        studentAttendanceModel:
                                                            context
                                                                .read<
                                                                    MainBloc>()
                                                                .studentAttendanceModel)));
                                          },
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: InkWell(
                                          child: Container(
                                            height: 70,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 218, 182, 240),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255,
                                                    152,
                                                    53,
                                                    209), // Border color
                                                width: 1.0, // Border width
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                  10), // Optional: rounded corners
                                            ),
                                            // height: 30,
                                            // width: 40,

                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  Text(
                                                      context
                                                          .read<MainBloc>()
                                                          .studentAttendanceModel
                                                          .data!
                                                          .yearlyAttendanceSummary![
                                                              index]
                                                          .totalAbsent
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              152,
                                                              77,
                                                              198))),
                                                  Text(
                                                    "Absent",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 173, 104, 216),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => StudentAttendanceDetailed(
                                                        index: index,
                                                        month: context
                                                            .read<MainBloc>()
                                                            .studentAttendanceModel
                                                            .data!
                                                            .yearlyAttendanceSummary![
                                                                index]
                                                            .month,
                                                        year: context
                                                            .read<MainBloc>()
                                                            .studentAttendanceModel
                                                            .data!
                                                            .yearlyAttendanceSummary![
                                                                index]
                                                            .year,
                                                        studentAttendanceModel:
                                                            context
                                                                .read<
                                                                    MainBloc>()
                                                                .studentAttendanceModel)));
                                          },
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: InkWell(
                                          child: Container(
                                            height: 70,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 241, 161, 136),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255,
                                                    206,
                                                    83,
                                                    46), // Border color
                                                width: 1.0, // Border width
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                  10), // Optional: rounded corners
                                            ),
                                            // height: 30,
                                            // width: 40,

                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  Text(
                                                    context
                                                        .read<MainBloc>()
                                                        .studentAttendanceModel
                                                        .data!
                                                        .yearlyAttendanceSummary![
                                                            index]
                                                        .totalLeave
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  Text(
                                                    "Leave",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => StudentAttendanceDetailed(
                                                        index: index,
                                                        month: context
                                                            .read<MainBloc>()
                                                            .studentAttendanceModel
                                                            .data!
                                                            .yearlyAttendanceSummary![
                                                                index]
                                                            .month,
                                                        year: context
                                                            .read<MainBloc>()
                                                            .studentAttendanceModel
                                                            .data!
                                                            .yearlyAttendanceSummary![
                                                                index]
                                                            .year,
                                                        studentAttendanceModel:
                                                            context
                                                                .read<
                                                                    MainBloc>()
                                                                .studentAttendanceModel)));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }));
            },
          ),
        ));
  }
}
