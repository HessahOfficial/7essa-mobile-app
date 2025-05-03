import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomChart extends StatefulWidget {
  const CustomChart({super.key});

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  late double touchedValue;
  int currentMonth = DateTime.now().month;

  @override
  void initState() {
    touchedValue = -1;
    super.initState();
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Jan', style: style);
        break;
      case 2:
        text = const Text('Feb', style: style);
        break;
      case 3:
        text = const Text('Mar', style: style);
        break;
      case 4:
        text = const Text('Apr', style: style);
        break;
      case 5:
        text = const Text('May', style: style);
        break;
      case 6:
        text = const Text('Jun', style: style);
        break;
      case 7:
        text = const Text('Jul', style: style);
        break;
      case 8:
        text = const Text('Aug', style: style);
        break;
      case 9:
        text = const Text('Sep', style: style);
        break;
      case 10:
        text = const Text('Oct', style: style);
        break;
      case 11:
        text = const Text('Nov', style: style);
        break;
      case 12:
        text = const Text('Dec', style: style);
        break;
      default:
        text = const Text('', style: style);
    }

    return SideTitleWidget(meta: meta, space: 25, child: text);
  }

  Color getToolTipColor(LineBarSpot touchSpot) {
    return Colors.black;
  }

  List<LineTooltipItem> getToolTipItems(List<LineBarSpot> touchSpots) {
    return touchSpots.map((spot) {
      final flSpot = spot;
      return LineTooltipItem(
        "\$${flSpot.y.toInt()}",
        TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  List<TouchedSpotIndicatorData> getTouchedSpotIndicator(
    LineChartBarData barData,
    List<int> spotIndexes,
  ) {
    return spotIndexes.map((spotIndex) {
      return TouchedSpotIndicatorData(
        FlLine(color: Colors.black, strokeWidth: 8),
        FlDotData(
          getDotPainter: (spot, percent, barData, index) {
            if (index == currentMonth - 1) {
              return FlDotCirclePainter(
                radius: 8,
                color: AppColors.chartLine,
                strokeWidth: 8,
                strokeColor: Colors.black,
              );
            } else {
              return FlDotCirclePainter(
                radius: 5,
                color: AppColors.chartLine,
                strokeWidth: 8,
                strokeColor: Colors.black,
              );
            }
          },
        ),
      );
    }).toList();
  }

  void handleTouchEvents(FlTouchEvent event, LineTouchResponse? lineTouch) {
    if (!event.isInterestedForInteractions ||
        lineTouch == null ||
        lineTouch.lineBarSpots == null) {
      setState(() {
        touchedValue = -1;
      });
      return;
    }
    final value = lineTouch.lineBarSpots![0].x;

    if (value == 0 || value == 6) {
      setState(() {
        touchedValue = -1;
      });
      return;
    }

    setState(() {
      touchedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            enabled: true,
            getTouchedSpotIndicator: (
              LineChartBarData barData,
              List<int> spotIndexes,
            ) {
              return getTouchedSpotIndicator(barData, spotIndexes);
            },
            touchTooltipData: LineTouchTooltipData(
              tooltipRoundedRadius: 25,
              getTooltipColor: getToolTipColor,
              getTooltipItems: (touchedSpots) {
                return getToolTipItems(touchedSpots);
              },
            ),
            touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {
              handleTouchEvents(event, lineTouch);
            },
          ),
          maxX: 12,
          minX: 1,
          maxY: 11,
          minY: 0,
          backgroundColor: AppColors.backgtoundLight,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: AppColors.horizontalGridLine,
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              axisNameSize: 20,

              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return getBottomTitles(value, meta);
                },
                reservedSize: 40,
              ),
            ),
            show: true,
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              preventCurveOverShooting: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [AppColors.belowChartLine, AppColors.backgtoundLight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              barWidth: 4,
              color: AppColors.chartLine,
              show: true,
              spots: [
                FlSpot(1, 0),
                FlSpot(2, 1),
                FlSpot(3, 2),
                FlSpot(4, 3),
                FlSpot(5, 3),
                FlSpot(6, 1),
                FlSpot(7, 6),
                FlSpot(8, 8),
                FlSpot(9, 0),
                FlSpot(10, 3),
                FlSpot(11, 5),
                FlSpot(12, 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
