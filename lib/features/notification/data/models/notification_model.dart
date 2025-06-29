import 'package:hessa/core/utils/type_aliases.dart';

class NotificationModel {
  String? userId;
  String? title;
  String? message;
  String? type;
  String? propertyId;
  bool? isRead;
  DateTime? createdAt;

  NotificationModel.fromJson(Json json) {
    userId = json["userId"];
    propertyId = json["propertyId"];
    message = json["message"];
    type = json["type"];
    isRead = json["isRead"];
    title = json["title"];
    createdAt = DateTime.parse(json["createdAt"]);
  }
}
