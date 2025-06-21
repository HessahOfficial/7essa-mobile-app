import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/widgets/custom_button.dart';

import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/investment/presentation/managers/investment_bloc.dart';
import 'package:hessa/features/property/presentation/managers/location_cubit.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_benefit_badge.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_room_item.dart';

class PropertyDetails extends StatelessWidget {
  final PropertyModel property;
  final BuildContext screenContext;

  const PropertyDetails({
    super.key,
    required this.property,
    required this.screenContext,
  });

  List<CustomBenefitBadge> getBenefitBadges() {
    List<CustomBenefitBadge> benefitBadges = [];
    for (var benefit in property.benefits!.cast<String>()) {
      benefitBadges.add(CustomBenefitBadge(text: benefit));
    }
    return benefitBadges;
  }

  List<CustomRoomItem> getRoomItems(double screenWidth) {
    List<CustomRoomItem> roomItems = [];
    if (property.numberOfRooms != null) {
      roomItems.add(
        CustomRoomItem(
          icon: FontAwesomeIcons.personBooth,
          text: "${property.numberOfRooms} Rooms",
          width: screenWidth,
        ),
      );
    }

    if (property.numberOfBathrooms != null) {
      roomItems.add(
        CustomRoomItem(
          icon: FontAwesomeIcons.bath,
          text: "${property.numberOfBathrooms} Bathrooms",
          width: screenWidth,
        ),
      );
    }

    if (property.numberOfbeds != null) {
      roomItems.add(
        CustomRoomItem(
          icon: FontAwesomeIcons.bed,
          text: "${property.numberOfbeds} Beds",
          width: screenWidth,
        ),
      );
    }

    if (property.numberOfKitchens != null) {
      roomItems.add(
        CustomRoomItem(
          icon: FontAwesomeIcons.kitchenSet,
          text: "${property.numberOfKitchens} Kitchens",
          width: screenWidth,
        ),
      );
    }

    return roomItems;
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
          Text(
            "Rooms :",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 4,
            children: getRoomItems(screenWidth),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: CustomButton(
                onPressed:
                    () => context.read<InvestmentBloc>().checkIsInvestor(
                      screenContext,
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
