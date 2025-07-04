import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/lang.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_request.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_request.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class HotPropertyCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final PropertyModel property;

  const HotPropertyCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    bool arabic = isArabic();
    UserModel currentUser = getIt.get<HiveHelper>().currentUser!;
    bool isFavourite = context.read<FavouriteCubit>().isFavourite(
      propertyId: property.id!,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap:
          () => context.push(
            AppRoutes.propertyView,
            extra: {"propertyId": property.id},
          ),
      child: Container(
        width: screenWidth * 0.67,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 15,
              spreadRadius: 2,
              offset: Offset(0, 8),
            ),
          ],
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(property.images![0]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: AppColors.gray.withOpacity(0.4),
                ),
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.08),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: InkWell(
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
                        borderRadius: BorderRadius.circular(10),
                        splashColor: AppColors.gray.withOpacity(0.1),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            isFavourite
                                ? Icons.bookmark_outlined
                                : Icons.bookmark_border_rounded,
                            size: 24,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.title!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: AppColors.gray,
                        ),
                        Text(
                          property.city!,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${property.pricePerShare} ${S.of(context).egpPerShare}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
