import 'package:flutter/material.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_benefit_badge.dart';
import 'package:hessa/generated/l10n.dart';

class CustomBenefitsSection extends StatelessWidget {
  final PropertyModel property;

  const CustomBenefitsSection({super.key, required this.property});

  List<CustomBenefitBadge> getBenefitBadges() {
    List<CustomBenefitBadge> benefitBadges = [];
    for (var benefit in property.benefits!.cast<String>()) {
      benefitBadges.add(CustomBenefitBadge(text: benefit));
    }
    return benefitBadges;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          S.of(context).benefitsSeciton,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Wrap(spacing: 10, children: getBenefitBadges()),
      ],
    );
  }
}
