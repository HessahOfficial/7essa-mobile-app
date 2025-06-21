part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class GetFilteredPropertiesEvent extends SearchEvent {
  final GetAllPropertiesRequest request;

  GetFilteredPropertiesEvent({required this.request});
}
