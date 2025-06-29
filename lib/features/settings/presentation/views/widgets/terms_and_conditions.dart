import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/features/settings/presentation/managers/settings_cubit.dart';
import 'package:hessa/generated/l10n.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.picture_as_pdf_rounded),
          Text(
            S.of(context).termsAndConditions,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => context.read<SettingsCubit>().downloadAndOpenPDF(),
              splashColor: AppColors.gray.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.download, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
