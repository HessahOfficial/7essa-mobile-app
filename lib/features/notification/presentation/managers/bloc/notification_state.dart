part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class GetNotificationsLoading extends NotificationState {}

class GetNotificationsSuccess extends NotificationState {
  final GetNotificationsResponse response;

  GetNotificationsSuccess({required this.response});
}

class GetNotificationsFailure extends NotificationState {
  final String message;

  GetNotificationsFailure({required this.message});
}
