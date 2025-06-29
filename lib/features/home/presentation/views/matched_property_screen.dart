import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/routes/app_routes.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/home/data/models/property_query_model.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/features/home/presentation/managers/search_bloc.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_property_card.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/filter_bottom_sheet.dart';
import 'package:hessa/generated/l10n.dart';

class MatchedPropertyScreen extends StatefulWidget {
  const MatchedPropertyScreen({super.key});

  @override
  State<MatchedPropertyScreen> createState() => _MatchedPropertyScreenState();
}

class _MatchedPropertyScreenState extends State<MatchedPropertyScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );

    context.read<SearchBloc>().add(
      GetFilteredPropertiesEvent(request: GetAllPropertiesRequest()),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) => FilterBottomSheet(title: searchController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is RefreshTokenFailure) {
          context.go(AppRoutes.loginView);
        }
      },
      builder:
          (bccontext, state) => BlocConsumer<PropertyBloc, PropertyState>(
            listener: (bccontext, state) {
              if (state is AddToFavouritesFailure) {
                showSnackBar(context: context, message: state.message, type: 1);
              } else if (state is DeleteFavouritesFailure) {
                showSnackBar(context: context, message: state.message, type: 1);
              } else if (state is AddToFavouritesSuccess) {
                showSnackBar(
                  context: context,
                  message: S.of(context).addToFavouritesResponse,
                  type: 0,
                );
              }
            },
            builder: (context, state) {
              return BlocConsumer<SearchBloc, SearchState>(
                listener: (bccontext, state) {
                  if (state is GetFilteredPropertiesFailure) {
                    showSnackBar(
                      context: context,
                      message: state.message,
                      type: 1,
                    );
                  }
                },
                builder: (bccontext, state) {
                  bool isDark = getIt.get<HiveHelper>().isDark ?? false;
                  List<PropertyModel> filteredProperties =
                      context.read<SearchBloc>().filteredProperties;

                  return Scaffold(
                    body: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          floating: true,
                          leading: Container(),
                          titleSpacing: 0,
                          leadingWidth: 0,
                          title: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomSearchBar(
                                    onChanged: (value) {
                                      context.read<SearchBloc>().add(
                                        GetFilteredPropertiesEvent(
                                          request: GetAllPropertiesRequest(
                                            query: PropertyQueryModel(
                                              title: value,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    searchController: searchController,
                                    screenContext: context,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.tune,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    onPressed: showFilterSheet,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06,
                              vertical: 20,
                            ),
                            child: Text(
                              S.of(context).searchResults,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        state is GetFilteredPropertiesSuccess &&
                                filteredProperties.isNotEmpty
                            ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => CustomPropertyCard(
                                  property: filteredProperties[index],
                                ),
                                childCount: filteredProperties.length,
                              ),
                            )
                            : state is GetFilteredPropertiesSuccess &&
                                filteredProperties.isEmpty
                            ? SliverToBoxAdapter(
                              child: Text(
                                S.of(context).noResults,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                            : SliverToBoxAdapter(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: CircularProgressIndicator(
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
                    ),
                  );
                },
              );
            },
          ),
    );
  }
}
