import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/property/presentation/managers/location_cubit.dart';
import 'package:hessa/generated/l10n.dart';

class CustomDescriptionSection extends StatelessWidget {
  final PropertyModel property;

  const CustomDescriptionSection({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  property.locationLink!,
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
          "${property.description!} (${property.area} ${S.of(context).squaredMeters})",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
