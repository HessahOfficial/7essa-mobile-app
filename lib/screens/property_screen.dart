import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hessa/constants/app_colors.dart';
import 'package:hessa/constants/property_data.dart';
import 'package:hessa/widgets/custom_chart.dart';
import 'package:hessa/widgets/property_item.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:hessa/saved_properties_provider.dart';

import 'checkout_page.dart';

class BecomeInvestorPage extends StatelessWidget {
  const BecomeInvestorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Become an Investor"),
      ),
      body: const Center(
        child: Text("Sign up to become an investor!"),
      ),
    );
  }
}

class PropertyScreen extends StatefulWidget {
  final PropertyModel property;

  const PropertyScreen({
    super.key,
    required this.property,
  });

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  // Mock investor status (replace with actual logic)
  bool get isInvestor => true;

  // Convert PropertyModel to Map for SavedPropertiesProvider
  Map<String, dynamic> _propertyToMap(PropertyModel property) {
    return {
      'name': property.name,
      'price': property.price,
      'size': property.size,
      'bedrooms': property.bedrooms,
      'bathrooms': property.bathrooms,
      'location': property.location,
      'kitchens': property.kitchens,
      'image': property.image,
    };
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white1,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
        actions: [
          Consumer<SavedPropertiesProvider>(
            builder: (context, provider, child) {
              final propertyMap = _propertyToMap(widget.property);
              final bool isSaved = provider.isPropertySaved(propertyMap);
              return IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: AppColors.accentColor,
                  size: 28,
                ),
                onPressed: () {
                  provider.toggleSaveProperty(propertyMap);
                  print('PropertyScreen: Toggled save for ${propertyMap['name']}, isSaved: $isSaved');
                },
              );
            },
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.accentColor),
        ),
        centerTitle: true,
        title: const Text(
          "Property Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.white1,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            children: [
              PropertyItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                property: widget.property,
                isMatched: false,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Interior Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 40),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Construction Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 40),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.03,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Statistics",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Icon(Icons.more_horiz_rounded, size: 40, color: AppColors.gray),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.03,
                  horizontal: screenWidth * 0.06,
                ),
                child: CustomChart(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Location Map & Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: 10,
        ),
        color: AppColors.white1,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (isInvestor) {
                Get.to(() => CheckoutInvestmentPage(property: widget.property));
              } else {
                Get.to(() => BecomeInvestorPage());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentColor,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Invest Now",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}