import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:omdb/util/logging_interceptor.dart';

class DioClient {
  static Dio _dio;
  static Dio get instance {
    if (_dio == null) {
      _dio = Dio();
      if (!kReleaseMode) {
        _dio.interceptors.add(LoggingInterceptor());
      }
      _dio.options.baseUrl =
          "http://www.omdbapi.com/?i=tt3896198&apikey=f6af27e9";
      _dio.options.headers = {
        Headers.acceptHeader: "application/json;charset=UTF-8"
      };
      _dio.options.contentType = "application/json";
    }
    return _dio;
  }
}

class ClientURL {
  static String baseURL = "http://www.omdbapi.com/?apikey=f6af27e9";
  static String searchMovie = "$baseURL&s=";
}
