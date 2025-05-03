import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/themes/light_theme.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/home/data/models/filter_option_model.dart';
import 'package:hessa/features/home/presentation/views/widgets/filter_bottom_sheet.dart';
import 'package:hessa/generated/l10n.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final BuildContext screenContext;

  const CustomSearchBar({
    super.key,
    required this.searchController,
    required this.screenContext,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: getLightThemeData(),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: S.of(context).search,
                    hintStyle: TextStyle(color: AppColors.gray),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.tune, color: Colors.white, size: 24),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
    ;
  }
}
