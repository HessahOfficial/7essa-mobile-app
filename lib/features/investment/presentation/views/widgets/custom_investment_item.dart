import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/lang.dart';
import 'package:hessa/core/utils/service_locator.dart';
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
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Opacity(
      opacity: index == selectedIndex ? 1 : 0.5,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          splashColor: AppColors.gray.withOpacity(0.1),
          onTap: () => context.read<InvestmentBloc>().setSelectedIndex(index),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow:
                  index == selectedIndex
                      ? [
                        BoxShadow(
                          color: AppColors.gray,
                          offset: Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: -1,
                        ),
                      ]
                      : null,
            ),
            width: double.infinity,
            child: Row(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(investment.propertyId!.images![0]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${investment.propertyId!.title}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${investment.sharePrice} EGP/Share",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:
                                  isDark
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          if (index == selectedIndex)
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(10),
                              splashColor: AppColors.gray.withOpacity(0.1),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Icon(
                                  Icons.double_arrow,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
