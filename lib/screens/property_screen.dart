import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hessa/constants/app_colors.dart';
import 'package:hessa/constants/property_data.dart';
import 'package:hessa/widgets/custom_chart.dart';
import 'package:hessa/widgets/property_item.dart';
import 'package:get/get.dart';

class PropertyScreen extends StatefulWidget {
  final PropertyModel property;

  const PropertyScreen({
    super.key,
    required this.property
  });

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white1,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.activeAccent,
              borderRadius: BorderRadius.circular(18)
            ),
            width: 48,
            height: 48,
            child: Container()
          )
        ],
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.accentColor,),
        ),
        title: Text("Property Details", style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: AppColors.white1,
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06),
          child: Column(
            children: [
              PropertyItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                property: widget.property,
                isMatched: false,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Interior Details", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 40,)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Construction Details", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 40,)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.03
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Statistics", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),),
                    Icon(Icons.more_horiz_rounded, size: 40, color: AppColors.gray,)
                  ],
                ),
              ),
              Padding(
               padding: EdgeInsets.symmetric(
                 vertical: screenHeight * 0.03,
                 horizontal: screenWidth * 0.06
               ),
               child: CustomChart(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Location Map & Details", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

