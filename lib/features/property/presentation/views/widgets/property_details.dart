import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/widgets/custom_button.dart';

import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/investment/data/models/investment_model.dart';
import 'package:hessa/features/investment/presentation/managers/investment_bloc.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_benefits_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_description_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_labels_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_rental_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_rooms_section.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_shares_section.dart';
import 'package:hessa/generated/l10n.dart';

class PropertyDetails extends StatelessWidget {
  final PropertyModel property;
  final BuildContext screenContext;
  final InvestmentModel? investment;

  const PropertyDetails({
    super.key,
    required this.property,
    required this.screenContext,
    this.investment,
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
              CustomSharesSection(property: property),
              if (property.isRented!) CustomRentalSection(property: property),
              CustomBenefitsSection(property: property),
            ],
          ),
          CustomRoomsSection(property: property),
          if (property.availableShares! > 0)
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
                  text: S.of(context).investNow,
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
