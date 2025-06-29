import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_label.dart';
import 'package:hessa/generated/l10n.dart';

class CustomLabelsSection extends StatelessWidget {
  final PropertyModel property;

  const CustomLabelsSection({super.key, required this.property});

  List<CustomLabel> getLabels(BuildContext context) {
    Map<String, Color> statusColors = {
      "Available": AppColors.newAddedColor,
      "Funded": AppColors.developersColor,
      "Exited": AppColors.bestForYouColor,
    };

    Map<String, String> statusStrings = {
      "Available": S.of(context).available,
      "Funded": S.of(context).funded,
      "Exited": S.of(context).exited,
    };

    List<CustomLabel> labels = [
      CustomLabel(
        icon: Icons.location_on_rounded,
        text: property.city,
        color: Theme.of(context).colorScheme.primary,
      ),
      if (property.isRented!)
        CustomLabel(text: S.of(context).rented, color: Colors.red),
      CustomLabel(
        text: statusStrings[property.status],
        color: statusColors[property.status],
      ),
    ];
    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 5, runSpacing: 5, children: getLabels(context));
  }
}
