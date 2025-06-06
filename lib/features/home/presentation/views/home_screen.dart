import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';

import 'package:hessa/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_category_list.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/category_tabs_list.dart';

class HomeScreen extends StatefulWidget {
  final TextEditingController searchController = TextEditingController();
  final BuildContext screenContext;

  HomeScreen({super.key, required this.screenContext});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<PropertyBloc>().add(
      GetAllPropertiesEvent(request: GetAllPropertiesRequest()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PropertyBloc, PropertyState>(
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
              message: state.response.message!,
              type: 0,
            );
          } else if (state is AddToFavouritesFailure) {
            showSnackBar(
              context: widget.screenContext,
              message: state.message,
              type: 1,
            );
          }
        },
        builder: (bccontext, state) {
          bool isDark = getIt.get<HiveHelper>().isDark ?? false;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                CustomAppBar(screenContext: context),
                CustomSearchBar(
                  searchController: widget.searchController,
                  screenContext: widget.screenContext,
                ),
                CategoryTabsList(),
                state is AddToFavouritesSuccess ||
                        state is GetAllPropertiesSuccess
                    ? Expanded(child: CustomCategoryList())
                    : Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator(
                        color:
                            isDark
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
