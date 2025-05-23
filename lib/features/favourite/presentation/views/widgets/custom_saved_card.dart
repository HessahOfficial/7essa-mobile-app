import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/home/data/models/property_model.dart';

class CustomSavedCard extends StatefulWidget {
  final PropertyModel property;

  const CustomSavedCard({super.key, required this.property});

  @override
  State<CustomSavedCard> createState() => _CustomSavedCardState();
}

class _CustomSavedCardState extends State<CustomSavedCard> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool selectionMode = context.read<FavouriteCubit>().selectionMode;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;
    bool wasSelected = context.read<FavouriteCubit>().checkWasSelected(
      widget.property,
    );

    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (!selectionMode) {
            context.read<FavouriteCubit>().addSelectedProperty(widget.property);
            isSelected = true;
          }
        });
      },
      onTap: () {
        setState(() {
          if (selectionMode) {
            if (!isSelected) {
              context.read<FavouriteCubit>().addSelectedProperty(
                widget.property,
              );
              isSelected = true;
            } else {
              context.read<FavouriteCubit>().removeSelectedProperty(
                widget.property,
              );
              isSelected = false;
            }
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color:
              wasSelected || isSelected
                  ? AppColors.gray.withOpacity(0.1)
                  : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              widget.property.title!,
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text("${widget.property.pricePerShare} LE/Share"),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.square_foot, size: 20),
                Text('${widget.property.area} sqft'),
                Icon(Icons.king_bed, size: 20),
                Text("${widget.property.numberOfbeds ?? 0}"),
                Icon(Icons.bathtub, size: 20),
                Text("${widget.property.numberOfBathrooms ?? 0}"),
                Spacer(),
                if (wasSelected || isSelected)
                  Icon(
                    Icons.check_circle,
                    color:
                        isDark
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
