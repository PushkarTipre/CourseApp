import 'dart:developer';

import 'package:course_app/common/utils/constants.dart';
import 'package:course_app/global.dart';
import 'package:dio/dio.dart';

class HttpUtil {
  late Dio dio;
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: "application/json: charset=utf-8",
      responseType: ResponseType.json,
    );
    dio = Dio(options);

    // dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    //   //  log("App Request Data ${options.uri}");
    //   return handler.next(options);
    // }, onResponse: (response, handler) {
    //   // log("App Response Data${response.statusCode}");
    //   return handler.next(response);
    // }, onError: (DioException e, handler) {
    //   // log("App Error Error${e.message}");
    //   ErrorEntity errorInfo = createErrorEntity(e);
    //   onError(errorInfo);
    //   // return handler.next(e);
    // }));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print("Full URL being accessed: ${options.uri}");
      print("Request URL: ${options.uri}");
      print("Request Method: ${options.method}");
      print("Request Headers: ${options.headers}");
      print("Request Data: ${options.data}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      print("Response Status Code: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Data: ${response.data}");
      return handler.next(response);
    }, onError: (DioException e, handler) {
      print("Error Type: ${e.type}");
      print("Error Message: ${e.message}");
      if (e.response != null) {
        print("Error Response Status: ${e.response?.statusCode}");
        print("Error Response Data: ${e.response?.data}");
      }
      ErrorEntity errorInfo = createErrorEntity(e);
      onError(errorInfo);
    }));
  }

  Map<String, dynamic>? getAuthorizationHeaders() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    if (accessToken.isNotEmpty) {
      headers["Authorization"] = "Bearer $accessToken";
    }
    return headers;
  }

  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    log("POST");
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    Map<String, dynamic>? authorization = getAuthorizationHeaders();
    if (authorization != null) {
      log("auth");
      log(authorization.toString());
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    log("response $response");
    log("Done");
    return response.data ?? response;
  }
}

class ErrorEntity implements Exception {
  int? code = 1;
  String? message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, message $message";
  }
}

ErrorEntity createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      print("Response status code: ${error.response?.statusCode}");
      print("Response data: ${error.response?.data}");
      return ErrorEntity(
          code: error.response?.statusCode ?? -1,
          message: "Bad Response: ${error.response?.statusMessage}");
    // ... (keep other cases)

    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "Connection timeout");

    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "Send timeout");

    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "Receive timeout");

    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "Bad SSL Certificate");

    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 400:
          return ErrorEntity(code: 400, message: "Request syntax error");
        case 401:
          return ErrorEntity(
              code: 401, message: "Permission denied -- Unauthorized");
      }
      return ErrorEntity(code: -1, message: "Bad Response");

    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "Server canceled it");

    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "Connection Error");

    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "Unknown Error");
  }
}

void onError(ErrorEntity eInfo) {
  print("Error Code: ${eInfo.code}");
  print("Error Message: ${eInfo.message}");
  switch (eInfo.code) {
    case 401:
      print("Permission denied cannot continue ahead!!");
      break;
    case 403:
      print("Forbidden");
      break;
    case 404:
      print("Not found");
      break;
    case 500:
      print("Internal server error");
      break;
    default:
      print("Unknown error");
      break;
  }
}
