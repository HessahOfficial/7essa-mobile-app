import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/home/data/models/property_query_model.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/features/home/presentation/managers/search_bloc.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_property_card.dart';
import 'package:hessa/generated/l10n.dart';

class CustomPartnerPropertiesList extends StatefulWidget {
  final BuildContext screenContext;
  final UserModel partner;

  const CustomPartnerPropertiesList({
    super.key,
    required this.screenContext,
    required this.partner,
  });

  @override
  State<CustomPartnerPropertiesList> createState() =>
      _CustomPartnerPropertiesListState();
}

class _CustomPartnerPropertiesListState
    extends State<CustomPartnerPropertiesList> {
  @override
  void initState() {
    super.initState();

    context.read<SearchBloc>().add(
      GetFilteredPropertiesEvent(
        request: GetAllPropertiesRequest(
          query: PropertyQueryModel(ownerId: widget.partner.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return BlocConsumer<PropertyBloc, PropertyState>(
      listener: (bccontext, state) {
        if (state is AddToFavouritesFailure) {
          showSnackBar(
            context: widget.screenContext,
            message: state.message,
            type: 1,
          );
        } else if (state is DeleteFavouritesFailure) {
          showSnackBar(context: context, message: state.message, type: 1);
        }
      },
      builder:
          (bccontext, state) => BlocConsumer<SearchBloc, SearchState>(
            listener: (bccontext, state) {
              if (state is GetFilteredPropertiesFailure) {
                showSnackBar(
                  context: widget.screenContext,
                  message: state.message,
                  type: 1,
                );
              }
            },
            builder: (bccontext, state) {
              List<PropertyModel> filteredProperties =
                  context.read<SearchBloc>().filteredProperties;

              return state is GetFilteredPropertiesLoading
                  ? Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(
                      color:
                          isDark
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary,
                    ),
                  )
                  : (filteredProperties.isEmpty
                      ? Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          S.of(context).emptyPartnerProperties,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredProperties.length,
                        itemBuilder:
                            (context, index) => CustomPropertyCard(
                              property: filteredProperties[index],
                            ),
                      ));
            },
          ),
    );
  }
}
