import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iroots/newscreens/customcalender.dart';
import 'package:iroots/src/modal/dashboardModalClass.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:iroots/src/controller/home/student/student_home_controller.dart';

//mestudenthome
class StudentHomePageScreen extends StatelessWidget {
  const StudentHomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StudentHomeController(),
      builder: (logic) => Scaffold(body: Obx(() {
        if (logic.showProgress.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Container(
              color: const Color(0xffF1F5F9),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    todayAttendanceWidget(logic),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppUtil.customText(
                            text: "Academics",
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                          AppUtil.customText(
                            text: "View All",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: ConstClass.themeColor,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: logic.studentAcademicList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                logic.onItemTapped(index, context);
                              },
                              child: buildAcademicWidget(
                                  logic.studentAcademicList[index], context));
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 6 / 3.2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        color: Colors.white,
                        height: 390,
                        width: 400,
                        child: CalendarWidget(
                          // year: 2025,
                          // month: 1,
                          holidays: [
                            DateTime(2025, 1, 26),
                            // DateTime(2024, 2, 2)
                          ],
                          leaves: [
                            // DateTime(2025, 1, 22),
                            // DateTime(2024, 2, 22)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: calenderBottomItemsWidget2(),
                    ),

                    // calenderBottomItemsWidget(),
                    // _buildCalendarMonth(logic),
                    // Card(
                    //   margin: const EdgeInsets.symmetric(
                    //       horizontal: 20, vertical: 5),
                    //   elevation: 2,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(15.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         AppUtil.customText(
                    //           text: "Attendance",
                    //           style: const TextStyle(
                    //               color: Color(0xff334155),
                    //               fontFamily: 'Open Sans',
                    //               fontWeight: FontWeight.w700,
                    //               fontSize: 20),
                    //         ),
                    //         const SizedBox(
                    //           height: 5,
                    //         ),
                    //         Row(
                    //           children: [
                    //             AppUtil.customText(
                    //               text: "Student Attendance",
                    //               style: const TextStyle(
                    //                   color: Color(0xff64748B),
                    //                   fontFamily: 'Open Sans',
                    //                   fontWeight: FontWeight.w700,
                    //                   fontSize: 12),
                    //             ),
                    //             const SizedBox(
                    //               width: 10,
                    //             ),
                    //             Container(
                    //               padding: const EdgeInsets.symmetric(
                    //                   horizontal: 6, vertical: 2),
                    //               decoration: ShapeDecoration(
                    //                 color: const Color(0xFFF1F5F9),
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(4)),
                    //               ),
                    //               child: AppUtil.customText(
                    //                 text:
                    //                     "01 Jan ${logic.currentYear} - ${logic.currentDate}",
                    //                 style: TextStyle(
                    //                     decoration: TextDecoration.underline,
                    //                     color: ConstClass.themeColor,
                    //                     fontFamily: 'Open Sans',
                    //                     fontWeight: FontWeight.w700,
                    //                     fontSize: 10),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(
                    //           height: 20,
                    //         ),
                    //         Obx(() {
                    //           if (logic.isAttendanceDataFound.value) {
                    //             return PieChart(
                    //               dataMap: logic.graphData,
                    //               animationDuration:
                    //                   const Duration(milliseconds: 800),
                    //               chartLegendSpacing: 50,
                    //               colorList: logic.colorList,
                    //               initialAngleInDegree: 0,
                    //               chartType: ChartType.ring,
                    //               ringStrokeWidth: 35,
                    //               legendOptions: const LegendOptions(
                    //                 showLegendsInRow: false,
                    //                 legendPosition: LegendPosition.right,
                    //                 showLegends: true,
                    //                 legendShape: BoxShape.rectangle,
                    //                 //   legendLabels: logic.legendLabels,
                    //                 legendTextStyle: TextStyle(
                    //                     color: Color(0xff64748B),
                    //                     fontFamily: 'Open Sans',
                    //                     fontWeight: FontWeight.w700,
                    //                     fontSize: 10),
                    //               ),
                    //               chartValuesOptions: const ChartValuesOptions(
                    //                 showChartValueBackground: false,
                    //                 showChartValues: false,
                    //                 showChartValuesOutside: false,
                    //                 decimalPlaces: 0,
                    //               ),
                    //             );
                    //           } else {
                    //             return AppUtil.noDataFound("No Data Found");
                    //           }
                    //         }),
                    //         const SizedBox(
                    //           height: 10,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ]),
            ),
          );
        }
      })),
    );
  }
}

Widget _buildCalendarMonth(StudentHomeController logic) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => TableCalendar(
              calendarBuilders: CalendarBuilders(
                holidayBuilder: (context, date, events) {
                  if (date.month == 1 && date.day == 26) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red, // Highlight color
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return null;
                  }
                },
              ),
              eventLoader: (date) => logic.getEventsForDay(date),
              locale: 'en_US',
              firstDay: DateTime(DateTime.now().year - 5),
              lastDay: DateTime(DateTime.now().year + 5),
              calendarFormat: CalendarFormat.month,
              rangeSelectionMode: logic.rangeSelectionMode.value,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              headerVisible: true,
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                isTodayHighlighted: true,
                todayTextStyle: const TextStyle(
                    color: Color(0xff64748B),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
                todayDecoration: BoxDecoration(
                  color: const Color(0XFFD0E3FF),
                  borderRadius: BorderRadius.circular(
                    28,
                  ),
                  border: Border.all(
                    color: const Color(0XFF1575FF),
                    width: 0.9,
                  ),
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                    color: Color(0xff64748B),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              rowHeight: 28,
              focusedDay: logic.focusedDay.value,
              rangeStartDay: logic.rangeStart,
              rangeEndDay: logic.rangeEnd,
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(logic.selectedDay, selectedDay)) {
                  logic.focusedDay.value = focusedDay;
                  logic.selectedDay = selectedDay;
                  logic.rangeSelectionMode.value = RangeSelectionMode.toggledOn;
                }
              },
              onRangeSelected: (start, end, focusedDay) {
                logic.focusedDay.value = focusedDay;
                logic.rangeEnd = end;
                logic.rangeStart = start;
                logic.rangeSelectionMode.value = RangeSelectionMode.toggledOn;
              },
              onPageChanged: (focusedDay) {
                logic.focusedDay.value = focusedDay;
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: const Color(0xffE2E8F0),
            height: 1.0,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            width: Get.width,
          ),
          const SizedBox(
            height: 5,
          ),
          calenderBottomItemsWidget(),
        ],
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
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: const Color(0XFFFB7185),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              AppUtil.customText(
                text: "Regional Holiday",
                style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: const Color(0XFF48E17C),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              AppUtil.customText(
                text: "National Holiday",
                style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: const Color(0xff42B5C4),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              AppUtil.customText(
                text: "My Leaves",
                style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/reminder_icon.png",
                height: 10,
                width: 10,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 5,
              ),
              AppUtil.customText(
                text: "Reminders",
                style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ],
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
                  width: 145,
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
                  width: 145,
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
                  width: 145,
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
                  width: 145,
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

Widget buildAcademicWidget(DashBoardModal academicList, context) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SizedBox(
          //     height: 30, width: 30, child: Image.asset(academicList.image!)

          //     ),

          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10), // Curve bottom-left
              topLeft: Radius.circular(10), // Curve bottom-right
            ),
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: 34,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(academicList.image!),
                )
                //  Icon(
                //   Icons.attach_email,
                //   color: const Color.fromARGB(255, 255, 255, 255),
                // ),
                // child: SvgPicture.asset(
                //   academicList.image!,
                //   width: 22,
                //   height: 22,
                // ),
                ),
          ),
          // SvgPicture.asset(
          //   academicList.image!,
          //   width: 22,
          //   height: 22,
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: SizedBox(
              width: 60,
              child: AppUtil.customText(
                text: academicList.title!,
                style: const TextStyle(
                    color: Color(0xff334155),
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 10),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

// Widget todayAttendanceWidget2(StudentHomeController logic) {
//   return Card(
//     margin: const EdgeInsets.all(20),
//     elevation: 2,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           AppUtil.customText(
//                             text: logic.studentData != null
//                                 ? logic.studentData!.name
//                                 : "",
//                             style: const TextStyle(
//                                 fontFamily: 'Open Sans',
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 16),
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.edit,
//                                 size: 22,
//                                 color: ConstClass.themeColor,
//                               ))
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       AppUtil.customText(
//                         text:
//                             "Class: ${logic.studentData != null ? logic.studentData!.className : ""} | Roll No: ${logic.studentData != null ? logic.studentData!.rollNo : ""}",
//                         style: const TextStyle(
//                             fontFamily: 'Open Sans',
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12),
//                       ),
//                     ],
//                   ),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(50.0),
//                     child: Image.asset(
//                       "assets/images/profile.png",
//                       height: 50,
//                       width: 50,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AppUtil.customText(
//                     text: "Overall Performance",
//                     style: const TextStyle(
//                         fontFamily: 'Open Sans',
//                         fontWeight: FontWeight.w600,
//                         fontSize: 10),
//                   ),
//                   AppUtil.customText(
//                     text: "75%",
//                     style: const TextStyle(
//                         fontFamily: 'Open Sans',
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 3,
//               ),
//               Container(
//                 height: 5,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(
//                     2,
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(
//                     2,
//                   ),
//                   child: LinearProgressIndicator(
//                     value: 0.85,
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       ConstClass.themeColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.transparent, // No background color
//             border: Border.all(
//               color:
//                   const Color.fromARGB(255, 141, 140, 140), // Light grey border
//               width: 0.1, // Thin border
//             ),
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(8), // Curve bottom-left corner
//               topRight: Radius.circular(8),
//               bottomLeft: Radius.circular(3), // Curve bottom-left corner
//               bottomRight: Radius.circular(3),
//               // Curve bottom-right corner
//             ), // Slightly curved edges
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(
//                 top: 18.0, right: 10, left: 10, bottom: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset(
//                       "assets/icons/today_attend_icon.svg",
//                       width: 36,
//                       height: 36,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         AppUtil.customText(
//                           text: "Today Attendance",
//                           style: const TextStyle(
//                               fontFamily: 'Open Sans',
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Color(0xff0DB166),
//                               ),
//                               width: 10,
//                               height: 10,
//                             ),
//                             const SizedBox(
//                               width: 3,
//                             ),
//                             AppUtil.customText(
//                               text: "Present",
//                               style: const TextStyle(
//                                   fontFamily: 'Open Sans',
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 10),
//                             ),
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//                 AppUtil.customText(
//                   text: logic.currentDate,
//                   style: const TextStyle(
//                       fontFamily: 'Open Sans',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 10),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }

attendenceremark(String? attendencestatus, Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0),
    child: Container(
      height: 24,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 149, 207, 233),
        border: Border.all(
          color: Colors.white, // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(6), // Optional: rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: CircleAvatar(
                radius: 6,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.circle,
                  color: color,
                  size: 10,
                )),
          ),
          SizedBox(
            width: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: Text(
              attendencestatus.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget todayAttendanceWidget(StudentHomeController logic) {
  //staffintialcard

  final double attendancePercentage = 0.75;
  String formattedDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  return Container(
    margin: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          // Colors.white,
          const Color.fromARGB(255, 104, 172, 228),
          Colors.blue,
          Colors.blue,
          Colors.blue
        ], // Gradient colors
        begin: Alignment.topLeft, // Start position
        end: Alignment.bottomRight, // End position
      ),
      border: Border.all(
        color: Colors.blue, // Border color
        width: .4, // Border width
      ),
      borderRadius: BorderRadius.circular(10), // Optional: rounded corners
    ),
    // elevation: 2,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(8.0),
    // ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      "assets/images/studentimg.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Text(logic.staffDetail.value.avatar.toString()),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppUtil.customText(
                              text: logic.studentnamedashboard.toString(),

                              // logic.studentData != null
                              //     ? logic.studentData!.name
                              //     : logic.namestudent.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            // const SizedBox(width: 5),
                            // Icon(
                            //   Icons.edit,
                            //   size: 22,
                            //   color: ConstClass.themeColor,
                            // )
                          ],
                        ),
                        const SizedBox(height: 5),
                        AppUtil.customText(
                          text:
                              "Class: ${logic.studentData != null ? logic.studentData!.className : ""} | Roll No: ${logic.studentData != null ? logic.studentData!.rollNo : ""}",
                          style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(
                          color: Colors.white, // Border color
                          width: 2.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // Optional: rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          size: 18,
                          color: ConstClass.unselectedColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white, // Border color
                                    width: .5, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      5), // Optional: rounded corners
                                ),
                                child: Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Attendence",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            attendenceremark("Present", Colors.green),
                            SizedBox(
                              width: 4,
                            ),
                            attendenceremark("Absent",
                                const Color.fromARGB(255, 203, 88, 241)),
                            SizedBox(
                              width: 4,
                            ),
                            attendenceremark("Leave", Colors.red),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 55.0, // Size of the circle
                    lineWidth: 12.0, // Thickness of the progress line
                    percent: attendancePercentage, // Value between 0.0 to 1.0
                    center: Text(
                      "${(attendancePercentage * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    progressColor: Colors.white, // Progress bar color
                    backgroundColor: Colors.blue, // Background color
                    circularStrokeCap:
                        CircularStrokeCap.round, // Round stroke cap
                    animation: true, // Animate progress
                    animationDuration: 1000, // Duration in milliseconds
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     AppUtil.customText(
              //       text: "Overall Performance",
              //       style: const TextStyle(
              //         fontFamily: 'Open Sans',
              //         fontWeight: FontWeight.w600,
              //         fontSize: 10,
              //       ),
              //     ),
              //     AppUtil.customText(
              //       text: "75%",
              //       style: const TextStyle(
              //         fontFamily: 'Open Sans',
              //         fontWeight: FontWeight.w600,
              //         fontSize: 12,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 3),
              // Container(
              //   height: 5,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(2),
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(2),
              //     child: LinearProgressIndicator(
              //       value: 0.85,
              //       valueColor: AlwaysStoppedAnimation<Color>(
              //         ConstClass.themeColor,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        // Container(
        //   color: Colors.grey,
        //   height: 1.0,
        //   width: Get.width,
        // ),
        // const SizedBox(height: 5),
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           SvgPicture.asset(
        //             "assets/icons/today_attend_icon.svg",
        //             width: 36,
        //             height: 36,
        //           ),
        //           const SizedBox(width: 10),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               AppUtil.customText(
        //                 text: "Today Attendance",
        //                 style: const TextStyle(
        //                   fontFamily: 'Open Sans',
        //                   fontWeight: FontWeight.w400,
        //                   fontSize: 14,
        //                 ),
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Container(
        //                     decoration: const BoxDecoration(
        //                       shape: BoxShape.circle,
        //                       color: Color(0xff0DB166),
        //                     ),
        //                     width: 10,
        //                     height: 10,
        //                   ),
        //                   const SizedBox(width: 3),
        //                   AppUtil.customText(
        //                     text: "Present",
        //                     style: const TextStyle(
        //                       fontFamily: 'Open Sans',
        //                       fontWeight: FontWeight.w400,
        //                       fontSize: 10,
        //                     ),
        //                   ),
        //                 ],
        //               )
        //             ],
        //           )
        //         ],
        //       ),
        //       AppUtil.customText(
        //         text: logic.currentDate,
        //         style: const TextStyle(
        //           fontFamily: 'Open Sans',
        //           fontWeight: FontWeight.w400,
        //           fontSize: 10,
        //         ),
        //       ),
        //     ],
        //   ),
        // )
      ],
    ),
  );
}
