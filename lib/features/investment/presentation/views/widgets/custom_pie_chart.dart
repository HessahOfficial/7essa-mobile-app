import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/investment/data/models/investment_model.dart';
import 'package:hessa/features/investment/presentation/managers/investment_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class CustomPieChart extends StatelessWidget {
  final InvestmentModel currentInvestment;

  const CustomPieChart({super.key, required this.currentInvestment});

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  swapAnimationDuration: Duration(milliseconds: 500),
                  PieChartData(
                    sectionsSpace: 5,
                    centerSpaceRadius: 100,
                    sections:
                        context.read<InvestmentBloc>().getPieChartSections(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Text(
                      S.of(context).totalInvestments,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${currentInvestment.investmentAmount} ${S.of(context).egp}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
