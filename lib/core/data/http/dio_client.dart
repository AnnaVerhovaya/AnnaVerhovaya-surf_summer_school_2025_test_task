import 'package:dio/dio.dart';
import 'package:surf_summer_school_2025_test_task/core/domain/interfaces/i_http_client.dart';

///  Класс для реализации HTTP-клиента для управления запросами
final class AppHttpClient implements IHttpClient {
  final Dio _httpClient;
  final String _baseUrl;

  /// Создает HTTP клиент
  ///
  /// Принимает:
  /// - [debugService] - сервис для логирования запросов
  /// - [baseUrl] - базовый URL API
  AppHttpClient({
    // required IDebugService debugService,
    required String baseUrl,
  })  : _baseUrl = baseUrl,
        _httpClient = Dio() {
    _httpClient.options
      ..baseUrl = _baseUrl
      ..connectTimeout = const Duration(seconds: 5)
      ..sendTimeout = const Duration(seconds: 7)
      ..receiveTimeout = const Duration(seconds: 10)
      ..headers = {'Content-Type': 'application/json'};

    // debugService.log('HTTP client created');
    // _httpClient.interceptors.add(debugService.dioLogger);
  }

  @override
  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      _httpClient.options.baseUrl = _baseUrl;

      final response = await _httpClient.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
