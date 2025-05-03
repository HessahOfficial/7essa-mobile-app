import 'package:dio/dio.dart';
import 'package:hessa/core/utils/type_aliases.dart';

class DioHelper {
  final _baseUrl = "https://7essa-server.vercel.app/";
  late Dio _dio;

  static const success = "success";
  static const failed = "failed";

  DioHelper() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        // receiveDataWhenStatusError: true,
        // followRedirects: true,
      ),
    );
  }

  Future<Json> post({required String endpoint, required Json body}) async {
    print("==============before request==============");
    final response = await _dio.post(endpoint, data: body);
    print("==============After request==============");
    print("response: $response");
    return response.data;
  }
}
