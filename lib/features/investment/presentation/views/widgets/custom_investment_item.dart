import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/lang.dart';
import 'package:hessa/features/investment/data/models/investment_model.dart';
import 'package:hessa/features/investment/presentation/managers/investment_bloc.dart';

class CustomInvestmentItem extends StatelessWidget {
  final InvestmentModel investment;
  final int index;
  final int selectedIndex;

  const CustomInvestmentItem({
    super.key,
    required this.investment,
    required this.index,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: AppColors.gray.withOpacity(0.1),
        onTap: () => context.read<InvestmentBloc>().setSelectedIndex(index),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow:
                index == selectedIndex
                    ? [
                      BoxShadow(
                        color: AppColors.gray,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ]
                    : null,
          ),
          width: double.infinity,
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(FontAwesomeIcons.building),
              Text(
                "${investment.propertyId!.title}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              if (index == selectedIndex)
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.more_horiz, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
