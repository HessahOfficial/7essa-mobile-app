import 'package:flutter/material.dart';
import 'package:hessa/generated/l10n.dart';

class CustomSwitchButtons extends StatelessWidget {
  final bool isPrice;
  final void Function()? onTapPrice;
  final void Function()? onTapPricePerShare;

  const CustomSwitchButtons({
    super.key,
    required this.isPrice,
    this.onTapPrice,
    this.onTapPricePerShare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        InkWell(
          onTap: onTapPrice ?? () {},
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.teal.withOpacity(0.5),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3, color: Colors.teal),
              color: isPrice ? Colors.teal.withOpacity(0.5) : null,
            ),
            child: Text(
              S.of(context).price,
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        InkWell(
          onTap: onTapPricePerShare ?? () {},
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.amber.withOpacity(0.5),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3, color: Colors.amber),
              color: !isPrice ? Colors.amber.withOpacity(0.5) : null,
            ),
            child: Text(
              S.of(context).priceShare,
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
