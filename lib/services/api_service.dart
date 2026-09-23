import 'package:dio/dio.dart';

import '../models/post_model.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    // TODO 1: Inisialisasi Dio dengan BaseOptions
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // TODO 2: Tambahkan LogInterceptor untuk logging di console
    _dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        responseHeader: false,
        requestBody: false,
        responseBody: false,
      ),
    );
  }

  // TODO 3: Method untuk mengambil daftar berita dengan pagination
  Future<List<PostModel>> fetchPosts({
    required int page,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get(
        '/posts',
        queryParameters: {
          '_page': page,
          '_limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        return data
            .map((json) => PostModel.fromJson(json))
            .toList();
      }

      return [];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // TODO 4: Lengkapi mapping DioExceptionType menjadi pesan yang ramah pengguna
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Koneksi lambat. Silakan periksa jaringan Anda.';
      case DioExceptionType.connectionError:
        return 'Tidak ada koneksi internet.';
      case DioExceptionType.badResponse:
        return 'Gagal memuat data dari server (Status: ${e.response?.statusCode})';
      default:
        return 'Terjadi kesalahan tidak terduga.';
    }
  }
}
