import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/property/presentation/managers/location_cubit.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_image_slider.dart';
import 'package:hessa/features/property/presentation/views/widgets/property_details.dart';

class PropertyScreen extends StatelessWidget {
  final PropertyModel property;

  const PropertyScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          property.title!,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageSlider(images: property.images!.cast<String>()),
            PropertyDetails(property: property),
          ],
        ),
      ),
    );
  }
}
