import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_property_card.dart';
import 'package:hessa/generated/l10n.dart';

class NewAddedSection extends StatefulWidget {
  final BuildContext screenContext;

  const NewAddedSection({super.key, required this.screenContext});

  @override
  State<NewAddedSection> createState() => _NewAddedSectionState();
}

class _NewAddedSectionState extends State<NewAddedSection> {
  @override
  void initState() {
    super.initState();

    context.read<PropertyBloc>().add(
      GetNewAddedPropertiesEvent(request: GetAllPropertiesRequest()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return BlocConsumer<PropertyBloc, PropertyState>(
      listener: (bccontext, state) {
        if (state is GetNewAddedPropertiesFailure) {
          showSnackBar(
            context: widget.screenContext,
            message: state.message,
            type: 1,
          );
        } else if (state is GetNewAddedPropertiesSuccess) {
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
      builder: (bccontext, state) {
        return BlocBuilder<CategoryCubit, CategoryState>(
          builder: (bccontext, state) {
            List<PropertyModel> newAddedProperties =
                context.read<CategoryCubit>().newAddedProperties;

            return state is CategoryFetch
                ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: newAddedProperties.length,
                  itemBuilder:
                      (context, index) => CustomPropertyCard(
                        property: newAddedProperties[index],
                      ),
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
