part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryChange extends CategoryState {}

class CategoryFetch extends CategoryState {}
