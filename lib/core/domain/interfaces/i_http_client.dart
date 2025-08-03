import 'package:dio/dio.dart';

/// Класс для описания интерфейса сервиса по управлению HTTP запросами
abstract interface class IHttpClient {
  const IHttpClient();

  /// Метод для реализации запроса GET
  ///
  /// Принимает:
  /// - [path] - путь к ресурсу
  /// - [data] - тело запроса
  /// - [queryParameters] - параметры запроса
  /// - [options] - конфигурация запроса
  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}
