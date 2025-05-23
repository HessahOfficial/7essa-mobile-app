part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteFetch extends FavouriteState {}

class FavouriteSelect extends FavouriteState {}
