part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetInfoEvent extends UserEvent {
  final GetInfoRequest request;

  GetInfoEvent({required this.request});
}
