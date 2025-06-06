import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/property/presentation/managers/location_cubit.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_benefit_badge.dart';

class PropertyDetails extends StatelessWidget {
  final PropertyModel property;

  const PropertyDetails({super.key, required this.property});

  List<CustomBenefitBadge> getBenefitBadges() {
    List<CustomBenefitBadge> benefitBadges = [];
    for (var benefit in property.benefits!.cast<String>()) {
      benefitBadges.add(CustomBenefitBadge(text: benefit));
    }
    return benefitBadges;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.06,
        right: screenWidth * 0.06,
        top: 30,
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${property.title!} :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<LocationCubit>().openLocationLink(
                    "https://maps.app.goo.gl/n3E7Ngk6EL2DrJpv9",
                  );
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    FontAwesomeIcons.mapLocationDot,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            property.description!,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Text(
            "Benefits :",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          Wrap(spacing: 10, children: getBenefitBadges()),
        ],
      ),
    );
  }
}
