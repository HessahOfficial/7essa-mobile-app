import 'package:dartz/dartz.dart' as property;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_request.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/home/data/models/add_to_favourites_request.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/features/investment/data/models/investment_model.dart';
import 'package:hessa/features/investment/presentation/managers/investment_bloc.dart';
import 'package:hessa/features/property/data/models/get_property_request.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_image_slider.dart';
import 'package:hessa/features/property/presentation/views/widgets/property_details.dart';
import 'package:hessa/features/wallet/data/models/investment_model.dart';
import 'package:hessa/generated/l10n.dart';

class PropertyScreen extends StatefulWidget {
  final String propertyId;
  final InvestmentModel? investment;

  const PropertyScreen({super.key, required this.propertyId, this.investment});

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  PropertyModel? property;

  @override
  void initState() {
    super.initState();

    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );

    context.read<PropertyBloc>().add(
      GetPropertyEvent(
        request: GetPropertyRequest(propertyId: widget.propertyId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (bccontext, state) {
        if (state is RefreshTokenFailure) {
          context.go(AppRoutes.loginView);
        }
      },
      builder: (bccontext, state) {
        return BlocConsumer<InvestmentBloc, InvestmentState>(
          listener: (bccontext, state) {
            if (state is MakeInvestmentFailure) {
              showSnackBar(context: context, message: state.message, type: 1);
            } else if (state is MakeInvestmentSuccess) {
              showSnackBar(
                context: context,
                message: "Investment operation is done successfully!",
                type: 0,
              );
            }
          },
          builder:
              (bccontext, state) => BlocConsumer<PropertyBloc, PropertyState>(
                listener: (bccontext, state) {
                  if (state is GetPropertyFailure) {
                    showSnackBar(
                      context: context,
                      message: state.message,
                      type: 1,
                    );
                  } else if (state is GetPropertySuccess) {
                    property = state.response.property;
                  } else if (state is AddToFavouritesFailure) {
                    showSnackBar(
                      context: context,
                      message: state.message,
                      type: 1,
                    );
                  } else if (state is DeleteFavouritesFailure) {
                    showSnackBar(
                      context: context,
                      message: state.message,
                      type: 1,
                    );
                  }
                },
                builder: (bccontext, state) {
                  bool isFavourite = context.read<FavouriteCubit>().isFavourite(
                    propertyId: widget.propertyId,
                  );

                  return state is GetPropertyLoading ||
                          property == null ||
                          state is MakeInvestmentLoading
                      ? Scaffold(
                        appBar: AppBar(
                          leading: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => context.pop(),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        body: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              color:
                                  isDark
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      )
                      : Scaffold(
                        appBar: AppBar(
                          titleSpacing: 0,
                          title: Text(
                            property!.title!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actionsPadding: EdgeInsets.symmetric(horizontal: 5),
                          actions: [
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              splashColor: AppColors.gray.withOpacity(0.1),
                              onTap: () {
                                final currentUser =
                                    getIt.get<HiveHelper>().currentUser;
                                if (isFavourite) {
                                  context.read<PropertyBloc>().add(
                                    DeleteFavouritesEvent(
                                      request: DeleteFavouritesRequest(
                                        properties: [property!.id!],
                                      ),
                                    ),
                                  );
                                } else {
                                  context.read<PropertyBloc>().add(
                                    AddToFavouritesEvent(
                                      request: AddToFavouritesRequest(
                                        propertyId: property!.id!,
                                        userId: currentUser!.id!,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  isFavourite
                                      ? Icons.bookmark_rounded
                                      : Icons.bookmark_border_rounded,
                                  color:
                                      isDark
                                          ? Colors.white
                                          : Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
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
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageSlider(
                                images: property!.images!.cast<String>(),
                              ),
                              PropertyDetails(
                                property: property!,
                                screenContext: context,
                              ),
                            ],
                          ),
                        ),
                      );
                },
              ),
        );
      },
    );
  }
}
