import 'package:dio/dio.dart';

import '../models/user_model.dart';

class ApiService {
  final Dio _dio;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://reqres.in/api',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: const {'x-api-key': 'reqres-free-v1'},
        ),
      ) {
    _dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        responseHeader: false,
        requestBody: false,
        responseBody: false,
      ),
    );
  }

  Future<List<UserModel>> fetchUsers({
    String? token,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/users',
        queryParameters: {'page': page, 'per_page': limit},
      );
      final data = response.data?['data'];
      if (data is! List) {
        throw const FormatException('Format data pengguna tidak valid.');
      }
      return data
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Koneksi lambat. Silakan periksa jaringan Anda.';
      case DioExceptionType.connectionError:
        return 'Tidak ada koneksi internet.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        return statusCode == 401 || statusCode == 403
            ? 'Akses API ditolak. Silakan periksa API key.'
            : 'Gagal memuat data dari server (Status: $statusCode)';
      default:
        return 'Terjadi kesalahan tidak terduga.';
    }
  }
}
