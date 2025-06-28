import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

class CustomCounterButton extends StatelessWidget {
  final void Function()? increment;
  final void Function()? decrement;
  final int value;

  const CustomCounterButton({
    super.key,
    this.increment,
    this.decrement,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    );
    EdgeInsets padding = EdgeInsets.all(10);

    double width = 50;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: decrement ?? () {},
            onLongPress: decrement ?? () {},
            child: Container(
              width: width,
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(child: Text("-", style: style)),
            ),
          ),
          Container(
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: padding,
            child: Center(child: Text("$value", style: style)),
          ),
          GestureDetector(
            onTap: increment ?? () {},
            onLongPress: increment ?? () {},
            child: Container(
              width: width,
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(child: Text("+", style: style)),
            ),
          ),
        ],
      ),
    );
  }
}
