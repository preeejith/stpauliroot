import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iroots/src/utility/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class AdminHomeController extends GetxController {
  final GetStorage box = Get.put(GetStorage());

  String? selectedYear;
  String? selectedLastYear;

  Map<String, double> graphData = {};
  DateTime? rangeStart;
  DateTime? rangeEnd;
  RxBool isAttendanceDataFound = false.obs;
  DateTime? selectedDay;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<RangeSelectionMode> rangeSelectionMode = RangeSelectionMode.toggledOn.obs;

  List<String> yearList = [
    "2017-18",
    "2018-19",
    "2019-20",
    "2020-21",
    "2021-22",
    "2022-23",
    "2023-24",
  ];

  List<String> lineChartList = [
    "5",
    "4",
    "3",
    "2",
  ];

  List<dynamic> getEventsForDay(DateTime day) {
    if (day.month == 1 && day.day == 26) {
      return ['Republic Day'];
    } else if (day.month == 8 && day.day == 15) {
      return ['Independence Day'];
    } else {
      return [];
    }
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 1,
        maxX: 5,
        maxY: 4,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
            ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '0%';
        break;
      case 2:
        text = '20%';
        break;
      case 3:
        text = '40%';
        break;
      case 4:
        text = '60%';
        break;
      case 5:
        text = '80%';
        break;
      case 6:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    Widget text;

    switch (value.toInt()) {
      case 1:
        text = const Text('2020', style: style);
        break;
      case 2:
        text = const Text('2021', style: style);
        break;
      case 3:
        text = const Text('2022', style: style);
        break;
      case 4:
        text = const Text('2023', style: style);
        break;
      case 5:
        text = const Text('2024', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SizedBox();
    //  SideTitleWidget(
    //   axisSide: meta.axisSide,
    //   space: 10,
    //   child: text,
    // );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorGreen,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        show: true,
        spots: const [
          FlSpot(1, 1),
          FlSpot(2, 1.5),
          FlSpot(3, 1.4),
          FlSpot(4, 2),
          FlSpot(5, 2.2),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorPink,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        show: true,
        belowBarData: BarAreaData(
          show: false,
          color: AppColors.contentColorPink.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(2, 2.8),
          FlSpot(3, 1.7),
          FlSpot(4, 2.4),
          FlSpot(5, 2.2),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorCyan,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        show: true,
        belowBarData: BarAreaData(show: false, color: Colors.transparent),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(2, 1.9),
          FlSpot(3, 3),
          FlSpot(4, 3.6),
          FlSpot(5, 4),
        ],
      );

  void selectYear() {}
}
