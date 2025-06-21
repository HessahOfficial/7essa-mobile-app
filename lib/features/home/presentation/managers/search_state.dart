part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class ChangeStatus extends SearchState {}

class GetFilteredPropertiesLoading extends SearchState {}

class GetFilteredPropertiesSuccess extends SearchState {
  final GetAllPropertiesResponse response;

  GetFilteredPropertiesSuccess({required this.response});
}

class GetFilteredPropertiesFailure extends SearchState {
  final String message;

  GetFilteredPropertiesFailure({required this.message});
}
