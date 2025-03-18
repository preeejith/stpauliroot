import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/src/controller/attendance/student/student_attendance_controller.dart';
import 'package:iroots/src/ui/dashboard/attendance/student/studentattendance.dart';
import 'package:iroots/src/utility/const.dart';
import 'package:iroots/src/utility/util.dart';
import 'package:pie_chart/pie_chart.dart';

class StudentAttendanceScreen extends StatelessWidget {
  const StudentAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StudentAttendanceController(),
      builder: (logic) => DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: ConstClass.dashBoardColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ConstClass.dashBoardColor,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0))),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            logic.tabController!
                                .animateTo(logic.tabController!.index - 1);
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: TabBar(
                          onTap: (index) {
                            logic.getCurrentYear(index);
                          },
                          controller: logic.tabController,
                          indicatorColor: Colors.transparent,
                          labelStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          unselectedLabelStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w200,
                              fontSize: 12),
                          isScrollable: true,
                          tabs: logic.yearTabs.map((String tab) {
                            return Tab(
                              text: tab,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      IconButton(
                          onPressed: () {
                            logic.tabController!
                                .animateTo(logic.tabController!.index + 1);
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              title: InkWell(
                child: AppUtil.customText(
                  text: "Student Attendance",
                  style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentsAttendence()));
                },
              ),
            ),
            body: Obx(() {
              if (logic.showProgress.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (logic.isDataFound.value) {
                  return Center(
                    child: SizedBox(
                      height: 360,
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: logic.tabController,
                          children: logic.yearTabs
                              .map((year) => attendanceWidget(logic))
                              .toList(),
                        ),
                      ),
                    ),
                  );
                } else {
                  return emptyGraph(logic);
                }
              }
            })),
      ),
    );
  }

  Widget emptyGraph(StudentAttendanceController logic) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SizedBox(
          height: 280,
          width: Get.width,
          child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: PieChart(
                    emptyColor: Colors.lightBlue,
                    dataMap: logic.graphData,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 50,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 35,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: false,
                      legendShape: BoxShape.rectangle,
                      legendTextStyle: TextStyle(
                          color: Color(0xff64748B),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppUtil.noDataFound("No Data Found")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget attendanceWidget(StudentAttendanceController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppUtil.customText(
          text: "${logic.studentData!.studentName} Attendance",
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*   SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 300.h,
                    width: 1.sw,
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(drawVerticalLine: false),
                        borderData: FlBorderData(
                            show: true,
                            border: const Border(
                              left: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            )),
                        titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                                drawBehindEverything: false,
                                sideTitles: SideTitles(
                                  reservedSize: 10,
                                  showTitles: true,
                                )),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                              reservedSize: 44,
                              showTitles: true,
                            )),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                              reservedSize: 10,
                              showTitles: false,
                            )),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(
                              reservedSize: 10,
                              showTitles: false,
                            ))),
                        minY: 0,
                        maxY: 5,
                        alignment: BarChartAlignment.center,
                        groupsSpace: 10.0,
                        barGroups: logic.attendance!
                            .asMap()
                            .map((index, item) {
                              return MapEntry(
                                  index,
                                  BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        width: 20.w,
                                        borderRadius: BorderRadius.zero,
                                        color: Colors.blue,
                                        toY: 3,
                                      ),
                                    ],
                                  ));
                            })
                            .values
                            .toList(),
                      ),
                    ),
                  ),
                ),*/
                PieChart(
                  dataMap: logic.graphData,
                  animationDuration: const Duration(milliseconds: 800),
                  chartLegendSpacing: 50,
                  colorList: logic.colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 35,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.rectangle,
                    legendTextStyle: TextStyle(
                        color: Color(0xff64748B),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 10),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 0,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppUtil.customText(
                  text: "Attendance",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                AppUtil.customText(
                  text:
                      "${logic.studentData!.totalAttendedDays} / ${logic.studentData!.totalDays} days",
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppUtil.customText(
                  text: "Percentage",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                AppUtil.customText(
                  text: logic.studentData!.attendancePer,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
