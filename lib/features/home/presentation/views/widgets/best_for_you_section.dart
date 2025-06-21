import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/utils/lang.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_property_card.dart';
import 'package:hessa/features/home/presentation/views/widgets/hot_properties_title.dart';
import 'package:hessa/features/home/presentation/views/widgets/hot_property_card.dart';
import 'package:hessa/generated/l10n.dart';

class BestForYouSection extends StatefulWidget {
  final BuildContext screenContext;

  const BestForYouSection({super.key, required this.screenContext});

  @override
  State<BestForYouSection> createState() => _BestForYouSectionState();
}

class _BestForYouSectionState extends State<BestForYouSection> {
  @override
  void initState() {
    super.initState();

    context.read<PropertyBloc>().add(
      GetAllPropertiesEvent(request: GetAllPropertiesRequest()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    bool arabic = isArabic();

    return BlocConsumer<PropertyBloc, PropertyState>(
      listener: (bccontext, state) {
        if (state is GetAllPropertiesFailure) {
          showSnackBar(
            context: widget.screenContext,
            message: state.message,
            type: 1,
          );
        } else if (state is GetAllPropertiesSuccess) {
          context.read<CategoryCubit>().setProperties(
            allProperties: state.response.properties,
          );
        } else if (state is AddToFavouritesSuccess) {
          showSnackBar(
            context: widget.screenContext,
            message: S.of(context).addToFavouritesResponse,
            type: 0,
          );
        } else if (state is AddToFavouritesFailure) {
          showSnackBar(
            context: widget.screenContext,
            message: state.message,
            type: 1,
          );
        } else if (state is DeleteFavouritesFailure) {
          showSnackBar(context: context, message: state.message, type: 1);
        }
      },
      builder: (context, state) {
        bool isDark = getIt.get<HiveHelper>().isDark ?? false;

        return BlocBuilder<CategoryCubit, CategoryState>(
          builder: (bccontext, state) {
            List<PropertyModel> hotProperties =
                context.read<CategoryCubit>().hotProperties;
            List<PropertyModel> restOfProperties =
                context.read<CategoryCubit>().restOfProperties;

            print("STATE: $state");
            print("HOT: $hotProperties");

            return state is CategoryFetch
                ? CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(child: HotPropertiesTitle()),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                        ),
                        child: SizedBox(
                          height: screenHeight * 0.32,
                          child: CarouselSlider.builder(
                            itemCount: hotProperties.length,
                            itemBuilder:
                                (context, index, realIndex) => HotPropertyCard(
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  property: hotProperties[index],
                                ),
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                              reverse: arabic ? true : false,
                              viewportFraction: 0.75,
                              autoPlayInterval: Duration(seconds: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).restOfProperties,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap:
                                  () => context.push(
                                    AppRoutes.matchedPropertyView,
                                  ),
                              borderRadius: BorderRadius.circular(15),
                              splashColor:
                                  Theme.of(context).colorScheme.secondary,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  S.of(context).more,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => CustomPropertyCard(
                          property: restOfProperties[index],
                        ),
                        childCount: restOfProperties.length,
                      ),
                    ),
                  ],
                )
                : Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(
                    color:
                        isDark
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                  ),
                );
          },
        );
      },
    );
  }
}
