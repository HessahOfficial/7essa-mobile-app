import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomNavItem extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final IconData icon;
  final void Function()? onTap;

  const CustomNavItem({
    super.key,
    required this.selectedIndex,
    required this.index,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      splashColor: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color:
              selectedIndex == index
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
        ),
        width: 48,
        height: 48,
        child: Center(
          child: Icon(
            icon,
            size: 24,
            color:
                selectedIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : AppColors.gray,
          ),
        ),
      ),
    );
  }
}
