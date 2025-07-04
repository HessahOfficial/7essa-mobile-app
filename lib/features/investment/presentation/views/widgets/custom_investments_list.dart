import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/features/investment/data/models/investment_model.dart';
import 'package:hessa/features/investment/presentation/managers/investment_bloc.dart';

import 'package:hessa/features/investment/presentation/views/widgets/custom_investment_item.dart';

class CustomInvestmentsList extends StatelessWidget {
  final List<InvestmentModel> investments;

  const CustomInvestmentsList({super.key, required this.investments});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.read<InvestmentBloc>().selectedIndex;
    double screenWidth = MediaQuery.of(context).size.width;

    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 20),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
      itemCount: investments.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder:
          (context, index) => CustomInvestmentItem(
            investment: investments[index],
            index: index,
            selectedIndex: selectedIndex,
          ),
    );
  }
}
