import 'package:flutter/material.dart';

import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_line_chart.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_switch_buttons.dart';
import 'package:hessa/generated/l10n.dart';

class CustomSharesSection extends StatefulWidget {
  final PropertyModel property;

  const CustomSharesSection({super.key, required this.property});

  @override
  State<CustomSharesSection> createState() => _CustomSharesSectionState();
}

class _CustomSharesSectionState extends State<CustomSharesSection> {
  bool isPrice = true;

  @override
  Widget build(BuildContext context) {
    DateTime exit = DateTime.parse(widget.property.estimatedExitDate!);
    String formatExitDay = exit.day < 10 ? "0${exit.day}" : "${exit.day}";
    String formatExitMonth =
        exit.month < 10 ? "0${exit.month}" : "${exit.month}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 30,
      children: [
        Text(
          S.of(context).sharesSeciton,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        CustomLineChart(
          isPrice: isPrice,
          priceHistory: widget.property.priceHistory!,
          pricePerShareHistory: widget.property.pricePerShareHistory!,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).price}: ${widget.property.price} ${S.of(context).egp}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${S.of(context).paymentPerYear}: ${widget.property.yearlyPayment} ${S.of(context).egpPerYear}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${S.of(context).pricePerShare}: ${widget.property.pricePerShare} ${S.of(context).egpPerShare}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${S.of(context).availableShares}: ${widget.property.availableShares} ${S.of(context).egp}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${S.of(context).priceSold}: ${widget.property.priceSold} ${S.of(context).egp}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${S.of(context).estimatedExitdate}: $formatExitDay/$formatExitMonth/${exit.year}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        CustomSwitchButtons(
          isPrice: isPrice,
          onTapPrice:
              () => setState(() {
                isPrice = true;
              }),
          onTapPricePerShare:
              () => setState(() {
                isPrice = false;
              }),
        ),
      ],
    );
  }
}
