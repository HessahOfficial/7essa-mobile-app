import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hessa/core/errors/failures.dart';
import 'package:hessa/core/helpers/dio_helper.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/endpoints.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/favourite/data/models/get_all_favourites_response.dart';
import 'package:hessa/features/notification/data/models/get_notifications_request.dart';
import 'package:hessa/features/notification/data/models/get_notifications_response.dart';
import 'package:hessa/features/notification/data/repositories/notification_repository.dart';

class NotificationService extends NotificationRepository {
  final DioHelper helper;

  NotificationService({required this.helper});

  @override
  Future<Either<Failure, GetNotificationsResponse>> getNotifications({
    required GetNotificationsRequest request,
  }) async {
    try {
      final tokens = getIt.get<HiveHelper>().token;
      final options = helper.getDioOptions(token: tokens!.accessToken!);
      final data = await helper.get(
        endpoint: Endpoints.getAllNotifications,
        options: options,
      );
      final response = GetNotificationsResponse.fromJson(
        data["data"]["notifications"],
      );
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(exception: e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
