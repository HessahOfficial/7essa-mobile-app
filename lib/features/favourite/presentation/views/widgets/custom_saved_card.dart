import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/favourite/presentation/views/widgets/custom_delete_single_popup.dart';
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColors.gray.withOpacity(0.5),
        onLongPress: () {
          setState(() {
            if (!selectionMode) {
              context.read<FavouriteCubit>().addSelectedProperty(
                widget.property,
              );
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
          height: 120,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color:
                wasSelected || isSelected
                    ? AppColors.gray.withOpacity(0.5)
                    : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            spacing: 10,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.gray.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(widget.property.images![0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
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
                        if (!selectionMode)
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              splashColor: AppColors.gray.withOpacity(0.1),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => CustomDeleteSinglePopup(
                                        property: widget.property,
                                      ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.trash,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
