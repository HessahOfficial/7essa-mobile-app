import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_room_item.dart';

class CustomRoomsSection extends StatelessWidget {
  final PropertyModel property;

  const CustomRoomsSection({super.key, required this.property});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          "Rooms :",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 4,
          children: getRoomItems(screenWidth),
        ),
      ],
    );
  }
}
