import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});

  factory ServerFailure.fromDioException({required DioException exception}) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: "Connection timed out");

      case DioExceptionType.sendTimeout:
        return ServerFailure(message: "Send timed out");

      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: "Receive timed out");

      case DioExceptionType.badCertificate:
        return ServerFailure(message: "Invalid certificate");

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          statusCode: exception.response!.statusCode!,
          response: exception.response!.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure(message: "Request cancelled!");

      case DioExceptionType.connectionError:
        return ServerFailure(message: "Connection failed!");

      case DioExceptionType.unknown:
        if (exception.message!.contains("SocketException")) {
          return ServerFailure(message: "No internet connection!");
        }
        return ServerFailure(message: "Unexpected Error, Please try again!");
    }
  }

  factory ServerFailure.fromResponse({
    required int statusCode,
    required dynamic response,
  }) {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return ServerFailure(message: response['message']);

      case 404:
        return ServerFailure(
          message: "Your request not found, Please try again later!",
        );

      case 500:
        return ServerFailure(
          message: "Internal Server Error, Please try again later!",
        );

      default:
        return ServerFailure(message: response["error"] ?? response["message"]);
    }
  }
}
