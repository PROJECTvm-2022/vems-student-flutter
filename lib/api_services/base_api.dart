import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as gt;
import 'package:vems/config/api_routes.dart';
import 'package:vems/config/enums.dart';
import 'package:vems/config/index.dart';
import 'package:vems/data_models/rest_error.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/authentication/welcome/welcome_page.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:http_parser/http_parser.dart' as p;

class ApiCall {
  static Future<Response> _generalApiCall(
    String path,
    RequestMethod requestMethod, {
    String id = '',
    String basePath = ApiRoutes.baseUrl,
    Map<String, dynamic> query = const {},
    dynamic body = const {},
    bool isAuthNeeded = true,
  }) async {
    final Dio dio = Dio();
    dio.options.contentType = 'application/json';
    if (isAuthNeeded && SharedPreferenceHelper.accessToken != null)
      dio.options.headers['Authorization'] = SharedPreferenceHelper.accessToken;
    try {
      log('URL $requestMethod $basePath/$path/$id $query ${jsonEncode(body)} ${SharedPreferenceHelper.accessToken}');
      Response response;
      switch (requestMethod) {
        case RequestMethod.get:
          response =
              await dio.get('$basePath/$path/$id', queryParameters: query);
          break;
        case RequestMethod.create:
          response = await dio.post('$basePath/$path/$id',
              data: body, queryParameters: query);
          break;
        case RequestMethod.patch:
          response = await dio.patch('$basePath/$path/$id',
              data: body, queryParameters: query);
          break;
        default:
          response =
              await dio.delete('$basePath/$path/$id', queryParameters: query);
          break;
      }
      return response;
    } on SocketException {
      throw NoInternetError();
    } catch (error, s) {
      log('ERROR URL $basePath/$path/$id ${dio.options.headers['Authorization']} ${jsonEncode(body)}',
          error: '$error', stackTrace: s);
      if (error.response == null) {
        throw NoInternetError();
      }
      if (error is DioError) {
        if (error.response.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          print("${error.response.data}");
          final restError = RestError.fromJson(error.response.data);
          if (restError.code == 401 && isAuthNeeded) {
            SharedPreferenceHelper.logOut();
            gt.Get.offAllNamed(LoginPage.routeName);
          }
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }

  static Future<Response> get(
    String path, {
    String id = '',
    String basePath = ApiRoutes.baseUrl,
    Map<String, dynamic> query = const {},
    bool isAuthNeeded = true,
  }) async {
    return _generalApiCall(path, RequestMethod.get,
        id: id, basePath: basePath, query: query, isAuthNeeded: isAuthNeeded);
  }

  static Future<Response> post(
    String path, {
    String id = '',
    String basePath = ApiRoutes.baseUrl,
    Map<String, dynamic> query = const {},
    dynamic body = const {},
    bool isAuthNeeded = true,
  }) async {
    return _generalApiCall(path, RequestMethod.create,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: isAuthNeeded,
        body: body);
  }

  static Future<Response> patch(
    String path, {
    String id = '',
    String basePath = ApiRoutes.baseUrl,
    Map<String, dynamic> query = const {},
    Map<String, dynamic> body = const {},
    bool isAuthNeeded = true,
  }) async {
    return _generalApiCall(path, RequestMethod.patch,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: isAuthNeeded,
        body: body);
  }

  static Future<Response> delete(String path,
      {String id = '',
      String basePath = ApiRoutes.baseUrl,
      Map<String, dynamic> query = const {}}) async {
    return _generalApiCall(path, RequestMethod.remove,
        id: id, basePath: basePath, query: query, isAuthNeeded: true);
  }

  static Future<String> singleFileUpload(File file,
      {String path = ApiRoutes.upload,
      RequestMethod requestMethod = RequestMethod.create}) async {
    try {
      if (SharedPreferenceHelper.accessToken == null ||
          SharedPreferenceHelper.accessToken.isEmpty) {
        return null;
      } else {
        final Dio dio = Dio();
        dio.options.headers['Authorization'] =
            SharedPreferenceHelper.accessToken;
        Response response = await dio.post('${ApiRoutes.baseUrl}/$path',
            data: FormData.fromMap({
              "photo": await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last,
                  contentType: p.MediaType('image', 'jpeg'))
            }));
        return response.data['cloudfrontPath'];
      }
    } on SocketException {
      throw NoInternetError();
    } catch (error) {
      if (error is DioError) {
        if (error.response.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(error.response.data);
          if (restError.code == 401) {}
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }

  /// Multiple file upload
  static Future<List<String>> multiFileUpload(List<File> files, String purpose,
      {String path = ApiRoutes.upload, bool isPdf = false}) async {
    try {
      if (SharedPreferenceHelper.user == null ||
          SharedPreferenceHelper.accessToken == null) {
        return null;
      } else {
        final Dio dio = Dio();
        dio.options.headers['Authorization'] =
            SharedPreferenceHelper.accessToken;

        Map<String, dynamic> body = {};

        for (int i = 0; i < files.length; i++) {
          body['photo$i'] = await MultipartFile.fromFile(files[i].path,
              contentType: isPdf
                  ? p.MediaType('application', 'pdf')
                  : p.MediaType('image', 'jpeg'));
        }
        body['purpose'] = purpose;

        Response response = await dio.post('${ApiRoutes.baseUrl}/$path',
            data: FormData.fromMap(body));

        return response.data is List
            ? List<String>.from(response.data
                .map((x) => x[isPdf ? 'docPath' : 'cloudfrontPath']))
            : [response.data[isPdf ? 'docPath' : 'cloudfrontPath']];
      }
    } on SocketException {
      throw NoInternetError();
    } catch (error) {
      if (error is DioError) {
        if (error.response.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(error.response.data);
          if (restError.code == 401) {}
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }
}

class NetworkUtils {
  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}

class NoInternetError {
  @override
  String toString() => 'No Internet Connection';
}
