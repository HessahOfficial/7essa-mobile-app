import 'package:dartz/dartz.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/features/notification/data/models/get_notifications_request.dart';
import 'package:hessa/features/notification/data/models/get_notifications_response.dart';

abstract class NotificationRepository {
  Future<Either<Failure, GetNotificationsResponse>> getNotifications({
    required GetNotificationsRequest request,
  });
}
