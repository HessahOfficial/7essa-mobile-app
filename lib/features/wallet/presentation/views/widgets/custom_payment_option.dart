import 'package:flutter/material.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';

class CustomPaymentOption extends StatelessWidget {
  final String? image;
  final IconData? icon;
  final String? textIcon;
  final int index;
  final int selectedIndex;
  final void Function()? onTap;
  final BorderRadius? borderRadius;

  const CustomPaymentOption({
    super.key,
    this.image,
    required this.index,
    required this.selectedIndex,
    this.onTap,
    this.icon,
    this.textIcon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return InkWell(
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      borderRadius: borderRadius,
      onTap: onTap ?? () {},
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: isDark ? Colors.white : Colors.black,
              ),
              borderRadius: borderRadius,
            ),
            child:
                image == null && icon != null
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Icon(icon),
                        Text(
                          textIcon!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                    : Image(image: AssetImage(image!), fit: BoxFit.cover),
          ),
          if (selectedIndex == index)
            Container(
              padding: EdgeInsets.all(10),
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              child: Icon(Icons.check, color: Colors.white, size: 30),
            ),
        ],
      ),
    );
  }
}
