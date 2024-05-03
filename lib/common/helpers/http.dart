import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:dio/io.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';

class HttpHelper {
  String baseUrl;

  HttpHelper({required this.baseUrl});

  d.Dio get dio {
    final dio = d.Dio(d.BaseOptions(
        connectTimeout: const Duration(milliseconds: 10000), baseUrl: baseUrl));
    dio.interceptors.add(
      d.QueuedInterceptorsWrapper(onResponse: (response, handler) async {
        debugPrint(response.statusMessage);
        handler.next(response);
      }, onRequest: (options, handler) async {
        handler.next(options);
      }, onError: (d.DioError error, handler) async {
        print(error);

        handler.resolve(d.Response(
          requestOptions: error.requestOptions,
          statusCode: error.response?.statusCode,
          statusMessage: error.response?.statusMessage,
          data: error.response?.data,
        ));
      }),
    );
    if (!kIsWeb) {
      dio.httpClientAdapter = IOHttpClientAdapter(onHttpClientCreate: (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      });
    }

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print, // specify log function (optional)
      retries: 3, // retry count (optional)
      retryDelays: const [
        // set delays between retries (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    ));
    return dio;
  }
}
