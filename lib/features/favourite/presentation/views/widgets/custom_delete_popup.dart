import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/favourite/data/models/delete_favourites_request.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/generated/l10n.dart';

class CustomDeletePopup extends StatelessWidget {
  const CustomDeletePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.info_rounded),
              Text(
                S.of(context).deleteDialogText,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      onPressed: () {
                        List<String> selectedIds =
                            context.read<FavouriteCubit>().getSelectedIds();
                        context.read<PropertyBloc>().add(
                          DeleteFavouritesEvent(
                            request: DeleteFavouritesRequest(
                              properties: selectedIds,
                            ),
                          ),
                        );
                        context.pop();
                      },
                      width: 60,
                      height: 30,
                      text: S.of(context).yes,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    ),
                    CustomButton(
                      onPressed: () => context.pop(),
                      width: 60,
                      height: 30,
                      text: S.of(context).no,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
