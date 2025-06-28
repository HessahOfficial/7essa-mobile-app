import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/home/data/models/property_model.dart';

class CustomPartnerSection extends StatelessWidget {
  final PropertyModel property;

  const CustomPartnerSection({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: NetworkImage(property.ownerAvatar!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              property.ownerName!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              property.managementCompany!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
        Spacer(),
        CustomButton(
          onPressed: () {},
          width: 100,
          height: 30,
          text: "Visit",
          textColor: Colors.white,
        ),
      ],
    );
  }
}
