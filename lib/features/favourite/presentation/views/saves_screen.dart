import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/favourite/data/models/get_all_favourites_request.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/favourite/presentation/views/widgets/custom_delete_popup.dart';
import 'package:hessa/features/favourite/presentation/views/widgets/custom_multi_select_list.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class SaveedPropertiesScreen extends StatefulWidget {
  const SaveedPropertiesScreen({super.key});

  @override
  State<SaveedPropertiesScreen> createState() => _SaveedPropertiesScreenState();
}

class _SaveedPropertiesScreenState extends State<SaveedPropertiesScreen> {
  final currentUser = getIt.get<HiveHelper>().currentUser;

  @override
  void initState() {
    context.read<PropertyBloc>().add(
      GetAllFavouritesEvent(
        request: GetAllFavouritesRequest(userId: currentUser!.id!),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return BlocConsumer<PropertyBloc, PropertyState>(
      listener: (bccontext, state) {
        if (state is GetAllFavouritesFailure) {
          showSnackBar(context: context, message: state.message, type: 1);
        } else if (state is GetAllFavouritesSuccess) {
          context.read<FavouriteCubit>().setFavourites(
            list: state.response.favourites,
          );
        } else if (state is DeleteFavouritesSuccess) {
          context.read<FavouriteCubit>().deleteSelectedIndices();
          showSnackBar(
            context: context,
            message: "Successfull Operation!",
            type: 0,
          );
        } else if (state is DeleteFavouritesFailure) {
          showSnackBar(context: context, message: state.message, type: 1);
          context.read<FavouriteCubit>().selectedIndices.clear();
          context.read<FavouriteCubit>().selectionMode = false;
        }
      },
      builder: (context, state) {
        final favourites = context.read<FavouriteCubit>().favourites;

        return Scaffold(
          floatingActionButton: BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (bccontext, state) {
              bool deleteMode =
                  context.read<FavouriteCubit>().selectedIndices.isNotEmpty;
              print(context.read<FavouriteCubit>().selectedIndices);
              print(deleteMode);
              if (deleteMode) {
                return FloatingActionButton(
                  backgroundColor: Colors.red,
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDeletePopup(),
                    );
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              S.of(context).savedProperties,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          body:
              state is GetAllFavouritesSuccess ||
                      state is DeleteFavouritesSuccess
                  ? CustomMultiSelectList()
                  : Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(
                      padding: EdgeInsets.all(10),
                      color:
                          isDark
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary,
                    ),
                  ),
        );
      },
    );
  }
}
