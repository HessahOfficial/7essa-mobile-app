import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/themes/light_theme.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/generated/l10n.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final BuildContext screenContext;
  final void Function(String) onChanged;

  const CustomSearchBar({
    super.key,
    required this.searchController,
    required this.screenContext,
    required this.onChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Row(
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
              child: TextFormField(
                onChanged: widget.onChanged,
                controller: widget.searchController,
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
      ],
    );
  }
}
