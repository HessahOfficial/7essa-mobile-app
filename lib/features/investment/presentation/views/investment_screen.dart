import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/investment/presentation/views/widgets/custom_investments_list.dart';
import 'package:hessa/features/investment/presentation/views/widgets/custom_pie_chart.dart';
import 'package:hessa/generated/l10n.dart';

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
        actions: [
          InkWell(
            child: Icon(
              Icons.refresh,
              size: 25,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          S.of(context).myInvestments,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          spacing: 25,
          children: [
            CustomPieChart(),
            Text(
              "My Investment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            CustomInvestmentsList(),
          ],
        ),
      ),
    );
  }
}
