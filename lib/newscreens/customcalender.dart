// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // Used for date formatting

// class CustomCalendar extends StatelessWidget {
//   final int year;
//   final int month;
//   final List<String> holidays; // Example format: ["2024-01-26", "2024-02-02"]

//   const CustomCalendar(
//       {super.key,
//       required this.year,
//       required this.month,
//       required this.holidays});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           _buildWeekdayHeader(),
//           _buildCalendarGrid(),
//         ],
//       ),
//     );
//   }

//   Widget _buildWeekdayHeader() {
//     List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: weekdays
//           .map(
//               (day) => Text(day, style: TextStyle(fontWeight: FontWeight.bold)))
//           .toList(),
//     );
//   }

//   Widget _buildCalendarGrid() {
//     int totalDays = DateTime(year, month + 1, 0).day;
//     int firstWeekday = DateTime(year, month, 1).weekday %
//         7; // Convert Monday-start to Sunday-start
//     List<Widget> daysWidgets = [];

//     for (int i = 0; i < 35; i++) {
//       int dayNum = i - firstWeekday + 1;
//       DateTime? currentDate = (dayNum > 0 && dayNum <= totalDays)
//           ? DateTime(year, month, dayNum)
//           : null;
//       daysWidgets.add(_buildDayCell(dayNum, currentDate));
//     }

//     return GridView.count(
//       crossAxisCount: 7,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: daysWidgets,
//     );
//   }

//   Widget _buildDayCell(int day, DateTime? date) {
//     bool isSunday = date != null && date.weekday == 7;
//     bool isHoliday = date != null &&
//         holidays.contains(DateFormat("yyyy-MM-dd").format(date));
//     bool isCurrentMonth = date != null;

//     return Container(
//       margin: EdgeInsets.all(4),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: isCurrentMonth ? Colors.black : Colors.grey,
//           width: isCurrentMonth ? 2 : 1,
//         ),
//         color: isSunday
//             ? Colors.red
//             : isHoliday
//                 ? Colors.green
//                 : Colors.white,
//       ),
//       child: Text(
//         day > 0 ? day.toString() : "",
//         style: TextStyle(color: Colors.black),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iroots/src/utility/util.dart';

class CalendarWidget extends StatefulWidget {
  final List<DateTime> holidays;
  final List<DateTime> leaves;
  final int? month, year;

  const CalendarWidget({
    super.key,
    required this.holidays,
    this.month,
    this.year,
    required this.leaves,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  @override
  void initState() {
    print(widget.leaves);

    if (widget.year != null) {
      year = widget.year!;
    }
    if (widget.month != null) {
      month = widget.month!;
    }
    super.initState();
  }

  void changeMonth(int offset) {
    setState(() {
      month += offset;
      if (month > 12) {
        month = 1;
        year++;
      } else if (month < 1) {
        month = 12;
        year--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int startWeekday = firstDayOfMonth.weekday % 7;

    int totalCells =
        startWeekday + daysInMonth > 35 ? 42 : 35; // Adjust for overflow
    List<int> dayNumbers = List.filled(totalCells, 0);

    for (int i = 0; i < daysInMonth; i++) {
      int index = startWeekday + i;
      if (index < dayNumbers.length) {
        dayNumbers[index] = i + 1;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: () => changeMonth(-1),
                  ),
                  Text(
                    "${DateFormat.MMMM().format(firstDayOfMonth)} $year",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    onPressed: () => changeMonth(1),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                    .map((day) => Text(day,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.blue)))
                    .toList(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemCount: totalCells,
                  itemBuilder: (context, index) {
                    int day = dayNumbers[index];
                    bool isSunday = index % 7 == 0;
                    bool isHoliday = widget.holidays.any((h) =>
                        h.year == year && h.month == month && h.day == day);
                    bool isLeave = widget.leaves.any((l) =>
                        l.year == year && l.month == month && l.day == day);
                    bool isWithinMonth = day > 0;
                    DateTime today = DateTime.now();
                    bool isToday = day > 0 &&
                        today.year == year &&
                        today.month == month &&
                        today.day == day;
                    return Center(
                      child: Container(
                        width: 37,
                        height: 37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isLeave
                              ? const Color.fromARGB(255, 83, 124, 226)
                              : isHoliday
                                  ? Color.fromARGB(255, 127, 220, 130)
                                  : isSunday
                                      ? Color.fromARGB(159, 227, 157, 241)
                                      : Colors.white,
                          // border: Border.all(
                          //   color: isWithinMonth
                          //       ? Color.fromARGB(255, 182, 212, 237)
                          //       : Colors.transparent,
                          //   width: isWithinMonth ? 1.5 : 0.5,
                          // ),

                          border: Border.all(
                            color: isToday
                                ? const Color.fromARGB(255, 239, 134, 127)
                                : (isWithinMonth
                                    ? Color.fromARGB(255, 182, 212, 237)
                                    : Colors.transparent),
                            width: isToday ? 2 : (isWithinMonth ? 1.5 : 0.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            day > 0 ? "$day" : "",
                            style: TextStyle(
                              color: isToday
                                  ? const Color.fromARGB(255, 227, 117, 109)
                                  : isLeave
                                      ? Colors.white
                                      : isHoliday
                                          ? Color.fromARGB(255, 16, 151, 21)
                                          : isSunday
                                              ? Color.fromARGB(
                                                  159, 213, 111, 233)
                                              : Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget calenderBottomItemsWidget() {
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
                    width: 140,
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
                    width: 140,
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
                    width: 140,
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
                    width: 140,
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
