import 'package:hessa/features/notification/data/models/notification_model.dart';

class GetNotificationsResponse {
  List<NotificationModel> notifications = [];

  GetNotificationsResponse.fromJson(List<dynamic> json) {
    for (var notification in json) {
      notifications.add(NotificationModel.fromJson(notification));
    }
  }
}
