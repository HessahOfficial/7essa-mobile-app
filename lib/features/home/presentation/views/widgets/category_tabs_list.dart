import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/lang.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_category_tab.dart';
import 'package:hessa/generated/l10n.dart';

class CategoryTabsList extends StatelessWidget {
  const CategoryTabsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (bccontext, state) {
        int selectedIndex = context.read<CategoryCubit>().selectedIndex;

        List<CustomCategoryTab> tabs = [
          CustomCategoryTab(
            index: 0,
            selectedIndex: selectedIndex,
            text: S.of(context).bestForYou,
            color: AppColors.bestForYouColor,
            onTap:
                () => context.read<CategoryCubit>().setSelectedIndex(index: 0),
          ),
          CustomCategoryTab(
            index: 1,
            selectedIndex: selectedIndex,
            text: S.of(context).developers,
            color: AppColors.developersColor,
            onTap:
                () => context.read<CategoryCubit>().setSelectedIndex(index: 1),
          ),
          CustomCategoryTab(
            index: 2,
            selectedIndex: selectedIndex,
            text: S.of(context).newAdded,
            color: AppColors.newAddedColor,
            onTap:
                () => context.read<CategoryCubit>().setSelectedIndex(index: 2),
          ),
          CustomCategoryTab(
            index: 3,
            selectedIndex: selectedIndex,
            text: S.of(context).bestInvest,
            color: AppColors.bestInvestColor,
            onTap:
                () => context.read<CategoryCubit>().setSelectedIndex(index: 3),
          ),
        ];

        bool arabic = isArabic();

        double screenWidth = MediaQuery.of(context).size.width;

        return SizedBox(
          height: 40,
          child: ListView.builder(
            padding: EdgeInsets.only(
              left: arabic ? 0 : screenWidth * 0.06,
              right: arabic ? screenWidth * 0.06 : 0,
            ),
            itemCount: tabs.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => tabs[index],
          ),
        );
      },
    );
  }
}
