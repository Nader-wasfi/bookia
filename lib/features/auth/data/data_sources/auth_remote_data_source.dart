import 'package:dio/dio.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

class AuthRemoteDataSource {
  // الـ Base URL الفعلي بعد مسح كلمة local وتحويلها للرابط المباشر
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.codingarabic.online/api/', 
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  ));

  Future<Response> register(RegisterRequestModel request) async {
    try {
      // بناءً على الـ Postman الـ Body يرسل كـ JSON raw وليس FormData
      final response = await _dio.post(
        'register', 
        data: request.toMap(),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post(
        'login', 
        data: request.toMap(),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      return e.response?.data['message'] ?? 'حدث خطأ ما من خادم البيانات!';
    }
    return 'مشكلة في الشبكة، تأكد من اتصالك بالإنترنت يا بطل.';
  }
}