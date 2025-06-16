import 'package:dio/dio.dart';
import 'package:hessa/core/utils/type_aliases.dart';

class DioHelper {
  final _baseUrl = "https://7essa-server-omega.vercel.app";
  // final _baseUrl = "http://92.168.1.9:8000";
  late Dio _dio;

  DioHelper() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
  }

  Options getDioOptions({required String token}) {
    return Options(headers: {"Authorization": "Bearer $token"});
  }

  Future<Json> post({
    required String endpoint,
    Json? body,
    Json? params,
    Options? options,
  }) async {
    print("Before");
    final response = await _dio.post(
      endpoint,
      data: body,
      queryParameters: params,
      options: options,
    );
    print("response: $response");
    return response.data;
  }

  Future<Json> postFormData({
    String endpoint = "https://api.cloudinary.com/v1_1/dw7f2lwio/image/upload",
    Object? body,
    Json? params,
    Options? options,
  }) async {
    print("Before");
    final response = await Dio().post(
      endpoint,
      data: body,
      queryParameters: params,
      options: options,
    );
    print("response: $response");
    return response.data;
  }

  Future<Json> get({
    required String endpoint,
    Json? body,
    Json? params,
    Options? options,
  }) async {
    final response = await _dio.get(
      endpoint,
      data: body,
      queryParameters: params,
      options: options,
    );
    print("response: $response");
    return response.data;
  }

  Future<Json> delete({
    required String endpoint,
    Json? body,
    Json? params,
    Options? options,
  }) async {
    final response = await _dio.delete(
      endpoint,
      data: body,
      queryParameters: params,
      options: options,
    );
    print("response: $response");
    return response.data;
  }

  Future<Json> patch({
    required String endpoint,
    Json? body,
    Json? params,
    Options? options,
  }) async {
    final response = await _dio.patch(
      endpoint,
      data: body,
      queryParameters: params,
      options: options,
    );
    print("response: $response");
    return response.data;
  }
}
