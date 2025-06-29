import 'package:flutter/material.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/generated/l10n.dart';

class CustomRentalSection extends StatelessWidget {
  final PropertyModel property;

  const CustomRentalSection({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    DateTime start = DateTime.parse(property.rentalStartDate!);
    DateTime end = DateTime.parse(property.rentalEndDate!);

    String formatStartDay = start.day < 10 ? "0${start.day}" : "${start.day}";
    String formatEndDay = end.day < 10 ? "0${end.day}" : "${end.day}";
    String formatStartMonth =
        start.month < 10 ? "0${start.month}" : "${start.month}";
    String formatEndMonth = end.month < 10 ? "0${end.month}" : "${end.month}";

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).rentalSeciton,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).rentalName}: ${property.rentalName}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${S.of(context).income}: ${property.rentalIncome} ${S.of(context).egp}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${S.of(context).from}: $formatStartDay/$formatStartMonth/${start.year} ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${S.of(context).to}: $formatEndDay/$formatEndMonth/${start.year} ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
