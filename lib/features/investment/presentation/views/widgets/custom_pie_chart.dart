import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/investment/presentation/views/widgets/custom_badge.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    final TextStyle titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.green,
                    value: 40,
                    showTitle: true,
                    titleStyle: titleStyle,
                    badgeWidget: CustomBadge(),
                    titlePositionPercentageOffset: 0.5,
                    badgePositionPercentageOffset: 1.3,
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: 60,
                    showTitle: true,
                    titleStyle: titleStyle,
                    badgeWidget: CustomBadge(),
                    titlePositionPercentageOffset: 0.5,
                    badgePositionPercentageOffset: 1.3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
