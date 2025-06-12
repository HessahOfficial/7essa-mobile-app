import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/utils/lang.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_property_card.dart';
import 'package:hessa/features/home/presentation/views/widgets/hot_properties_title.dart';
import 'package:hessa/features/home/presentation/views/widgets/hot_property_card.dart';
import 'package:hessa/generated/l10n.dart';

class BestForYouSection extends StatelessWidget {
  const BestForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    bool arabic = isArabic();

    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (bccontext, state) {
        List<PropertyModel> hotProperties =
            context.read<CategoryCubit>().hotProperties;
        List<PropertyModel> restOfProperties =
            context.read<CategoryCubit>().restOfProperties;

        return CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: HotPropertiesTitle()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
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
                  vertical: screenHeight * 0.06,
                ),
                child: Text(
                  S.of(context).restOfProperties,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    CustomPropertyCard(property: restOfProperties[index]),
                childCount: restOfProperties.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
