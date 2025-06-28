import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_label.dart';

class CustomLabelsSection extends StatelessWidget {
  final PropertyModel property;

  const CustomLabelsSection({super.key, required this.property});

  List<CustomLabel> getLabels(BuildContext context) {
    Map<String, Color> statusColors = {
      "Available": AppColors.newAddedColor,
      "Funded": AppColors.developersColor,
      "Exited": AppColors.bestForYouColor,
    };

    List<CustomLabel> labels = [
      CustomLabel(
        icon: Icons.location_on_rounded,
        text: property.city,
        color: Theme.of(context).colorScheme.primary,
      ),
      if (property.isRented!) CustomLabel(text: "Rented", color: Colors.red),
      CustomLabel(text: property.status, color: statusColors[property.status]),
    ];
    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 5, runSpacing: 5, children: getLabels(context));
  }
}
