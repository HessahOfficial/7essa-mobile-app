import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_request.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';

class CustomPropertyCard extends StatelessWidget {
  final PropertyModel property;

  const CustomPropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;
    UserModel currentUser = getIt.get<HiveHelper>().currentUser!;
    bool isFavourite = context.read<FavouriteCubit>().isFavourite(
      propertyId: property.id!,
    );

    return InkWell(
      onTap:
          () => context.push(
            AppRoutes.propertyView,
            extra: {"property": property},
          ),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(property.images![0]),
                  fit: BoxFit.cover,
                ),
                color: AppColors.gray.withOpacity(0.4),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.title!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!isFavourite)
                        InkWell(
                          onTap: () {
                            context.read<PropertyBloc>().add(
                              AddToFavouritesEvent(
                                request: AddToFavouritesRequest(
                                  propertyId: property.id!,
                                  userId: currentUser.id!,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.bookmark_border_outlined,
                            color:
                                isDark
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    property.city!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.gray,
                    ),
                  ),
                  Text(
                    "${property.pricePerShare} LE/Share",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.square_foot),
                          Text("${property.area} sqft"),
                        ],
                      ),
                      Row(
                        spacing: 1,
                        children: [
                          Text(
                            "${property.numberOfRooms} rooms",
                            style: TextStyle(color: AppColors.gray),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
