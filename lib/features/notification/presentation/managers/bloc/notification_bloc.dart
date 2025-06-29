import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hessa/features/notification/data/models/get_notifications_request.dart';
import 'package:hessa/features/notification/data/models/get_notifications_response.dart';
import 'package:hessa/features/notification/data/models/notification_model.dart';
import 'package:hessa/features/notification/data/repositories/notification_service.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  List<NotificationModel> notifications = [];

  final NotificationService service;

  NotificationBloc({required this.service}) : super(NotificationInitial()) {
    on<GetNotificationsEvent>((event, emit) async {
      final response = await service.getNotifications(request: event.request);
      response.fold(
        (failure) {
          emit(GetNotificationsFailure(message: failure.message));
        },
        (data) {
          notifications = data.notifications;
          emit(GetNotificationsSuccess(response: data));
        },
      );
    });
  }
}
