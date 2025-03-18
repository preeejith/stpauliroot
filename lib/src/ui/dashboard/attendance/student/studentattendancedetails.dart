import 'package:flutter/material.dart';
import 'package:iroots/newscreens/customcalender.dart';
import 'package:iroots/newscreens/studentattendancemodel.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';

class StudentAttendanceDetailed extends StatefulWidget {
  final int? month, year;
  final StudentAttendanceModel? studentAttendanceModel;
  final int? index;
  const StudentAttendanceDetailed(
      {super.key,
      this.studentAttendanceModel,
      this.index,
      this.month,
      this.year});

  @override
  State<StudentAttendanceDetailed> createState() =>
      _StudentAttendanceDetailedState();
}

class _StudentAttendanceDetailedState extends State<StudentAttendanceDetailed> {
  List<DateTime> leaves = [];
  @override
  void initState() {
    _fetchattendancedetails();
    super.initState();
  }

  _fetchattendancedetails() {
    // List<DateTime> leaves = widget
    //     .studentAttendanceModel!.data!.dateRangeAttendance!
    //     .where((entry) => entry.markFullDayAbsent == "True")
    //     .map((entry) {
    //   List<String> parts = entry.createdDate!.split("/");
    //   return DateTime(
    //       int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    // }).toList();
    if (widget.studentAttendanceModel != null) {
      if (widget.studentAttendanceModel!.data!.dateRangeAttendance != null) {
        leaves = widget.studentAttendanceModel!.data!.dateRangeAttendance!
            .where((entry) => entry.markFullDayAbsent == "True")
            .map((entry) {
          List<String> parts = entry.createdDate!.split("/");
          return DateTime(
              int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        }).toList();

        print(leaves);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstClass.themeColor,
        title: InkWell(
          child: Text(
            "Detailed",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          onTap: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              color: Colors.white,
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: CalendarWidget(
                year: widget.year,
                month: widget.month,
                holidays: [
                  DateTime(2025, 1, 26),
                  // DateTime(2024, 2, 2)
                ],
                leaves: leaves,

                //  [DateTime(2025, 1, 22), DateTime(2024, 2, 22)],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: calenderBottomItemsWidget2(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget calenderBottomItemsWidget2() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    width: 150,
                    color: const Color.fromARGB(255, 153, 225, 155),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: AppUtil.customText(
                          text: "Regional Holiday",
                          style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    width: 150,
                    color: const Color.fromARGB(255, 214, 159, 241),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: AppUtil.customText(
                          text: "National Holiday",
                          style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    width: 150,
                    color: const Color.fromARGB(255, 251, 177, 143),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: AppUtil.customText(
                          text: "Reminders",
                          style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    width: 150,
                    color: const Color.fromARGB(255, 142, 151, 245),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: AppUtil.customText(
                          text: "My Leaves",
                          style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
