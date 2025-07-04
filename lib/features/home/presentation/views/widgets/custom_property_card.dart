import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_request.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_request.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/generated/l10n.dart';

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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColors.gray.withOpacity(0.5),
        onTap:
            () => context.push(
              AppRoutes.propertyView,
              extra: {"propertyId": property.id},
            ),
        child: Container(
          padding: const EdgeInsets.all(12),
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
                        InkWell(
                          onTap: () {
                            if (isFavourite) {
                              context.read<PropertyBloc>().add(
                                DeleteFavouritesEvent(
                                  request: DeleteFavouritesRequest(
                                    properties: [property.id!],
                                  ),
                                ),
                              );
                            } else {
                              context.read<PropertyBloc>().add(
                                AddToFavouritesEvent(
                                  request: AddToFavouritesRequest(
                                    propertyId: property.id!,
                                    userId: currentUser.id!,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Icon(
                            isFavourite
                                ? Icons.bookmark_outlined
                                : Icons.bookmark_border_outlined,
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
                      "${property.pricePerShare} ${S.of(context).egpPerShare}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.square_foot),
                            Text(
                              "${property.area} ${S.of(context).squaredMeters}",
                            ),
                          ],
                        ),
                        Row(
                          spacing: 1,
                          children: [
                            Text(
                              "${property.numberOfRooms} ${S.of(context).rooms}",
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
      ),
    );
  }
}
