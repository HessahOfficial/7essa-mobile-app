import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:hessa/constants/property_data.dart";
import "package:hessa/widgets/custom_search_bar.dart";
import "package:hessa/widgets/fixed_header_delegate.dart";
import "package:hessa/widgets/property_item.dart";

import "../constants/app_colors.dart";


class MatchedPropertyScreen extends StatefulWidget {
  const MatchedPropertyScreen({super.key});

  @override
  State<MatchedPropertyScreen> createState() => _MatchedPropertyScreenState();
}

class _MatchedPropertyScreenState extends State<MatchedPropertyScreen> {

  TextEditingController searchController = TextEditingController();
  String search = "";

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<PropertyModel> list = data;

    return Scaffold(
      backgroundColor: AppColors.white1,
      body: CustomScrollView(
        slivers: [
         SliverAppBar(
            surfaceTintColor: AppColors.white,
            leading: Container(),
            toolbarHeight: 100,
            backgroundColor: AppColors.white1,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.03
                ),
                child: CustomSearchBar(width: screenWidth),
              ),
            ),
          ),
          SliverPadding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.06,
                right: screenWidth * 0.06,
              ),
              sliver: SliverPersistentHeader(
                  pinned: false,
                  floating: false,
                  delegate: FixedHeaderDelegate(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Matched Property", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23
                          ),),
                          Row(
                            children: [
                              Text("See All", style: TextStyle(
                                color: AppColors.lightGreen,
                                fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),),
                              Icon(
                                Icons.arrow_right_outlined,
                                color: AppColors.lightGreen,
                                size: 40,
                                weight: 40,
                              )
                            ],
                          )
                        ],
                      ), height: 50))
          ),
          SliverPadding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.08,
                  right: screenWidth * 0.08,
                  top: screenHeight * 0.01
              ),
              sliver: SliverList.builder(
                itemCount: list.length,
                itemBuilder: (context , index) {
                  return PropertyItem(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      property: list[index],
                  );
              })
          )
        ],
      )
    );
  }
}
