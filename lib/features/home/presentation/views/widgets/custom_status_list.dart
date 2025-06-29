import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/features/home/presentation/managers/search_bloc.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_status_button.dart';
import 'package:hessa/generated/l10n.dart';

class CustomStatusList extends StatelessWidget {
  const CustomStatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (bccontext, state) {
        int status = context.read<SearchBloc>().statusIndex;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomStatusButton(
              isSelected: status == 0,
              index: 0,
              onTap: () {
                if (status == 0) {
                  context.read<SearchBloc>().setStatus(index: -1);
                } else {
                  context.read<SearchBloc>().setStatus(index: 0);
                }
              },
              text: S.of(context).available,
              color: AppColors.newAddedColor,
            ),
            CustomStatusButton(
              isSelected: status == 1,
              index: 1,
              onTap: () {
                if (status == 1) {
                  context.read<SearchBloc>().setStatus(index: -1);
                } else {
                  context.read<SearchBloc>().setStatus(index: 1);
                }
              },
              text: S.of(context).funded,
              color: AppColors.developersColor,
            ),
            CustomStatusButton(
              isSelected: status == 2,
              index: 2,
              onTap: () {
                if (status == 2) {
                  context.read<SearchBloc>().setStatus(index: -1);
                } else {
                  context.read<SearchBloc>().setStatus(index: 2);
                }
              },
              text: S.of(context).exited,
              color: AppColors.bestForYouColor,
            ),
          ],
        );
      },
    );
  }
}
