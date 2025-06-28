import 'package:flutter/material.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_line_chart.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_switch_buttons.dart';

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
          "Shares :",
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
                "Price: ${widget.property.price} EGP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Payment per year: ${widget.property.yearlyPayment} EGP/year",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Price per share: ${widget.property.pricePerShare} EGP/Share",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Available Shares: ${widget.property.availableShares} Shares",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Price Sold: ${widget.property.priceSold} EGP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Estimated to exit on: $formatExitDay/$formatExitMonth/${exit.year}",
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
