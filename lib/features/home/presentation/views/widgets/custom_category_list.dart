import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/views/widgets/best_for_you_section.dart';
import 'package:hessa/features/home/presentation/views/widgets/best_invest_section.dart';
import 'package:hessa/features/home/presentation/views/widgets/partners_section.dart';
import 'package:hessa/features/home/presentation/views/widgets/new_added_section.dart';

class CustomCategoryList extends StatelessWidget {
  final BuildContext screenContext;

  const CustomCategoryList({super.key, required this.screenContext});

  Widget getSelectedCategoryList({required int index}) {
    List<Widget> categorySections = [
      BestForYouSection(screenContext: screenContext),
      PartenersSection(),
      NewAddedSection(screenContext: screenContext),
      BestInvestSection(screenContext: screenContext),
    ];

    return categorySections[index];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (bccontext, state) {
        int index = context.read<CategoryCubit>().selectedIndex;

        return getSelectedCategoryList(index: index);
      },
    );
  }
}
