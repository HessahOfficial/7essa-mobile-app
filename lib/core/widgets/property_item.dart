import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

import '../../constants/property_data.dart';

class PropertyItem extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final PropertyModel property;
  final bool isMatched;

  const PropertyItem({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.property,
    this.isMatched = true,
  });

  @override
  State<PropertyItem> createState() => _PropertyItemState();
}

class _PropertyItemState extends State<PropertyItem> {
  @override
  Widget build(BuildContext context) {
    PropertyModel property = widget.property;

    return GestureDetector(
      onTap: () {
        if (widget.isMatched) {}
      },
      child: Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: widget.screenHeight * 0.01),
          // height: 340,
          decoration: BoxDecoration(
            color: AppColors.white2,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  child: SvgPicture.asset(property.image, height: 220),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        property.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "\$${property.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.location_on, color: AppColors.gray),
                      Expanded(
                        child: Text(
                          "${property.location} (${property.area}sqft)",
                          style: TextStyle(color: AppColors.gray, fontSize: 15),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/bed.svg",
                            width: 17,
                            height: 17,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${property.beds} Bed",
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 20),
                          SvgPicture.asset(
                            "assets/images/bath.svg",
                            width: 17,
                            height: 17,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${property.baths} Bath",
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 20),
                          SvgPicture.asset(
                            "assets/images/kitchen.svg",
                            width: 17,
                            height: 17,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${property.kitchens} Kitchen",
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
