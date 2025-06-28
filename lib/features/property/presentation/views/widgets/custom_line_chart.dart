import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomLineChart extends StatelessWidget {
  final List<dynamic> priceHistory;
  final List<dynamic> pricePerShareHistory;
  final bool isPrice;

  const CustomLineChart({
    super.key,
    required this.priceHistory,
    required this.pricePerShareHistory,
    this.isPrice = true,
  });

  @override
  Widget build(BuildContext context) {
    double minPriceY = priceHistory
        .map((e) => (e["price"] as num).toDouble())
        .reduce((a, b) => a < b ? a : b);
    double maxPriceY = priceHistory
        .map((e) => (e["price"] as num).toDouble())
        .reduce((a, b) => a > b ? a : b);

    double minPricePerShareY = pricePerShareHistory
        .map((e) => (e["pricePerShare"] as num).toDouble())
        .reduce((a, b) => a < b ? a : b);
    double maxPricePerShareY = pricePerShareHistory
        .map((e) => (e["pricePerShare"] as num).toDouble())
        .reduce((a, b) => a > b ? a : b);

    String formatShortNumber(double value) {
      if (value >= 1000000) {
        return "${(value / 1000000).toStringAsFixed(1)}M";
      } else if (value >= 1000) {
        return "${(value / 1000).toStringAsFixed(1)}K";
      } else {
        return value.toInt().toString();
      }
    }

    FlTitlesData getTilesData() {
      final tilesData =
          isPrice
              ? FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameSize: 40,
                  axisNameWidget: Text(
                    "Month / Day",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < priceHistory.length) {
                        final date = DateTime.tryParse(
                          priceHistory[index]["date"],
                        );
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            date != null
                                ? DateFormat('MM/yy').format(date)
                                : '',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  axisNameSize: 30,
                  axisNameWidget: Text(
                    "Price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        formatShortNumber(value),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              )
              : FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameSize: 40,
                  axisNameWidget: Text(
                    "Month / Day",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < pricePerShareHistory.length) {
                        final date = DateTime.tryParse(
                          pricePerShareHistory[index]["date"],
                        );
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            date != null
                                ? DateFormat('MM/yy').format(date)
                                : '',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  axisNameSize: 30,
                  axisNameWidget: Text(
                    "Price / Share",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        formatShortNumber(value),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              );

      return tilesData;
    }

    LineChartBarData getLineChartData() {
      final lineChartData =
          isPrice
              ? LineChartBarData(
                isCurved: true,
                spots:
                    priceHistory.asMap().entries.map((entry) {
                      final index = entry.key;
                      final data = entry.value;
                      return FlSpot(
                        index.toDouble(),
                        (data["price"] as num).toDouble(),
                      );
                    }).toList(),
                barWidth: 3,
                color: Colors.teal,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.teal.withOpacity(0.2),
                ),
              )
              : LineChartBarData(
                isCurved: true,
                spots:
                    pricePerShareHistory.asMap().entries.map((entry) {
                      final index = entry.key;
                      final data = entry.value;
                      return FlSpot(
                        index.toDouble(),
                        (data["pricePerShare"] as num).toDouble(),
                      );
                    }).toList(),
                barWidth: 3,
                color: Colors.amber,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.amber.withOpacity(0.2),
                ),
              );
      return lineChartData;
    }

    double minY = isPrice ? minPriceY : minPricePerShareY;
    double maxY = isPrice ? maxPriceY : maxPricePerShareY;

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: LineChart(
        LineChartData(
          minY: (minY - 200).clamp(0, minY),
          maxY: maxY + 200,
          gridData: FlGridData(show: true),
          titlesData: getTilesData(),
          borderData: FlBorderData(show: true),
          lineBarsData: [getLineChartData()],
        ),
      ),
    );
  }
}
