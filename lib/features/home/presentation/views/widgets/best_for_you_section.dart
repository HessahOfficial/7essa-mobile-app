import 'package:flutter/material.dart';
import 'package:hessa/core/utils/lang.dart';
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

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: HotPropertiesTitle()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: SizedBox(
              height: screenHeight * 0.32,
              child: ListView.builder(
                padding: EdgeInsets.only(
                  left: arabic ? 0 : screenHeight * 0.075,
                  right: arabic ? screenHeight * 0.075 : 0,
                ),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return HotPropertyCard(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  );
                },
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
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: const CustomPropertyCard(),
            ),
            childCount: 10,
          ),
        ),
      ],
    );
  }
}
