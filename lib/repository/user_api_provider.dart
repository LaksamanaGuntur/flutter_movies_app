import 'package:dio/dio.dart';
import 'package:flutter_movies_app/model/api_response.dart';
import 'package:flutter_movies_app/utils/logs.dart';

class UserApiProvider {
  final _apiKey = '08225e8f2017efb2bb80528de1674d0e';
  final _baseUrl = "https://api.themoviedb.org/3/movie";
  Dio _dio;

  UserApiProvider() {
    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);
    _setupLoggingInterceptor();
  }

  Future<ApiResponse> getData() async {
    try {
      Response response = await _dio.get("$_baseUrl/popular?api_key=$_apiKey");
      return ApiResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ApiResponse.withError(_handleError(error));
    }
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription = "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription = "Received invalid status code: ${error.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "SEND_TIMEOUT";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;

    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          // Do something before request is sent
          Logs.d("--> ${options.method} ${options.path}");
          Logs.d("Content type: ${options.contentType}");
          Logs.d("Headers: ${options.headers}");
          Logs.d("<-- END HTTP REQUEST");
          return options; //continue
          // If you want to resolve the request with some custom data，
          // you can return a `Response` object or return `dio.resolve(data)`.
          // If you want to reject the request with a error message,
          // you can return a `DioError` object or return `dio.reject(errMsg)`
        },
        onResponse:(Response response) {
          // Do something with response data
          Logs.d("--> ${response.statusCode} ${response.request.method} ${response.request.path}");
          String responseAsString = response.data.toString();
          if (responseAsString.length > maxCharactersPerLine) {
            int iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
            for (int i = 0; i <= iterations; i++) {
              int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
              if (endingIndex > responseAsString.length) {
                endingIndex = responseAsString.length;
              }
              Logs.d(responseAsString.substring(
                  i * maxCharactersPerLine, endingIndex));
            }
          } else {
            Logs.d(response.data);
          }
          Logs.d("<-- END HTTP RESPONSE");
          return response; // continue
        },
        onError: (DioError e) {
          // Do something with response error
//          _handleError(e);
          return  e;//continue
        }
    ));
  }
}
