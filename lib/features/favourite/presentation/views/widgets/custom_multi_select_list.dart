import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/features/favourite/presentation/managers/favourite_cubit.dart';
import 'package:hessa/features/favourite/presentation/views/widgets/custom_saved_card.dart';
import 'package:hessa/generated/l10n.dart';

class CustomMultiSelectList extends StatelessWidget {
  const CustomMultiSelectList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (bcccontext, state) {
        final favourites = context.read<FavouriteCubit>().favourites;

        return favourites.isNotEmpty
            ? ListView.builder(
              padding: EdgeInsets.only(top: 10),
              physics: BouncingScrollPhysics(),
              itemCount: favourites.length,
              itemBuilder:
                  (context, index) =>
                      CustomSavedCard(property: favourites[index]),
            )
            : SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      S.of(context).emptyFavourites,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }
}
