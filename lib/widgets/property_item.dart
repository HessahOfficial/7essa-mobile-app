import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hessa/constants/app_colors.dart';

class PropertyItem extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const PropertyItem({
    super.key,
    required this.screenWidth,
    required this.screenHeight
  });

  @override
  State<PropertyItem> createState() => _PropertyItemState();
}

class _PropertyItemState extends State<PropertyItem> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){ print("Inside Property Item!"); },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: widget.screenHeight * 0.01),
        // height: 340,
        decoration: BoxDecoration(
            color: AppColors.white2,
            borderRadius: BorderRadius.circular(45)
        ),
        child: Padding(padding: EdgeInsets.all(20), child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20)
              ),
              width: double.infinity,
              child: SvgPicture.asset("assets/images/google.svg", height: 220, ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Deluxe Apartment", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  Text("\$276000", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: AppColors.accentColor
                  ),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.gray),
                      Text("2BW Street NY, New York", style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 17
                      ),)
                    ],
                  ),
                  Text("(2000sqft)", style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                      color: AppColors.gray
                  ),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/bed.svg", width: 17, height: 17,),
                      SizedBox(width: 5,),
                      Text("4 Bed", style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 17
                      ),),
                      SizedBox(width: 30,),
                      SvgPicture.asset("assets/images/bath.svg", width: 17, height: 17,),
                      SizedBox(width: 5,),
                      Text("4 Bath", style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 17
                      ),),
                      SizedBox(width: 30,),
                      SvgPicture.asset("assets/images/kitchen.svg", width: 17, height: 17,),
                      SizedBox(width: 5,),
                      Text("4 Kitchen", style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 17
                      ),)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),),
      ),
    );
  }
}
