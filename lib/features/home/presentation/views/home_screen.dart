import 'package:flutter/material.dart';

import 'package:hessa/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_category_list.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/category_tabs_list.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final BuildContext screenContext;

  HomeScreen({super.key, required this.screenContext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            CustomAppBar(),
            CustomSearchBar(
              searchController: searchController,
              screenContext: screenContext,
            ),
            CategoryTabsList(),
            Expanded(child: CustomCategoryList()),
          ],
        ),
      ),
    );
  }
}
