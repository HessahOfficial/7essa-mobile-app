import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';

import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/investment/presentation/managers/investment_bloc.dart';
import 'package:hessa/features/property/presentation/managers/location_cubit.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_benefit_badge.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_benefits_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_description_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_label.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_labels_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_partner_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_rental_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_room_item.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_rooms_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_shares_section.dart';
import 'package:hessa/generated/l10n.dart';

class PropertyDetails extends StatelessWidget {
  final PropertyModel property;
  final BuildContext screenContext;

  const PropertyDetails({
    super.key,
    required this.property,
    required this.screenContext,
  });

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
          CustomLabelsSection(property: property),
          CustomDescriptionSection(property: property),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              CustomPartnerSection(property: property),
              CustomSharesSection(property: property),
              if (property.isRented!) CustomRentalSection(property: property),
              CustomBenefitsSection(property: property),
            ],
          ),
          CustomRoomsSection(property: property),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: CustomButton(
                onPressed:
                    () => context.read<InvestmentBloc>().checkIsInvestor(
                      screenContext,
                      property,
                    ),
                width: 120,
                height: 40,
                text: "Invest NOW!",
                backgroundColor: Colors.green,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
