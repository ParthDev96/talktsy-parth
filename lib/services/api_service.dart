import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_dialogs.dart';
import 'package:talktsy/config/app_shared_preference_keys.dart';
import 'package:talktsy/services/api_config.dart';
import 'package:talktsy/utils/app_shared_preferences.dart';
import 'package:talktsy/widgets/app_loader.dart';
import '../routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ApiManager {
  Future<dynamic> callDeleteApi(
      String endPoint, Object params, String token) async {
    Dio dio = Dio();
    try {
      var response = await dio.delete(ApiConfig.baseUrl + endPoint,
          data: params,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer $token"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      var data = response.data;
      log("\n\nURL=>$endPoint\n\n");
      log("\n\nREQUESTS=>${(params)}\n\n");
      log("\n\nRESPONSE=>$data\n\n");
      return data;
    } on DioException catch (error) {
      return manageAPIError(error);
    }
  }

  Future<dynamic> callPatchApi(
      String endPoint, Object params, String token) async {
    Dio dio = Dio();
    try {
      var response = await dio.patch((ApiConfig.baseUrl + endPoint),
          data: params,
          options: Options(
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token"
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      var data = response.data;
      print("\n\nURL=>${ApiConfig.baseUrl + endPoint}\n\n");
      print("\n\nREQUESTS=>${(params)}\n\n");
      return data;
    } on DioException catch (error) {
      return manageAPIError(error);
    }
  }

  Future<dynamic> callGetApi(
      {required String endPoint, Object? params, bool isLoading = true}) async {
    Dio dio = Dio();
    try {
      if (isLoading) {
        AppLoader.show(Get.overlayContext!);
      }
      var tLoginData = await SharedPrefsHelper.getObject(
          AppSharedPreferenceKeys.loginUserData);
      print('tLoginData => $tLoginData');
      var token = '';
      if (tLoginData != null) {
        token = tLoginData['access_token'];
      }
      var response = await dio.get((ApiConfig.baseUrl + endPoint),
          data: params,
          options: Options(
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      var data = response.data;
      print("\n\nURL=>${ApiConfig.baseUrl + endPoint}\n\n");
      print("\n\nGET REQUESTS=>${(params)}\n\n");
      log("Get response ==>" + response.toString());
      if (isLoading) {
        AppLoader.hide(Get.overlayContext!);
      }
      return data;
    } on DioException catch (error) {
      if (isLoading) {
        AppLoader.hide(Get.overlayContext!);
      }
      return manageAPIError(error);
    }
  }

  Future<dynamic> callPostApi({
    required String endPoint,
    required dynamic params,
    bool isLoading = true,
    Map<String, String>? customHeaders, // Custom headers parameter
    String? baseUrl,
  }) async {
    if (isLoading) {
      AppLoader.show(Get.overlayContext!);
    }
    Dio dio = Dio();
    log("endpoint===>" + endPoint.toString());
    var tLoginData = await SharedPrefsHelper.getObject(
        AppSharedPreferenceKeys.loginUserData);
    var token = '';
    if (tLoginData != null) {
      token = tLoginData['access_token'];
    }
    print('tLoginData => $tLoginData');
    print('token => $token');

    final String effectiveBaseUrl = baseUrl ?? ApiConfig.baseUrl;

    try {
      var response = await dio.post(
        (effectiveBaseUrl + endPoint),
        data: params,
        options: Options(
          sendTimeout: Duration(milliseconds: 6000),
          receiveTimeout: Duration(milliseconds: 6000),
          receiveDataWhenStatusError: true,
          headers: {
            // "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            ...?customHeaders,
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      var data = response.data;
      print("\n\nURL=>${ApiConfig.baseUrl + endPoint}\n\n");
      print("\n\nPOST REQUESTS=>${(params)}\n\n");
      print("\n\nPOST RESPONSE=>$data\n\n");
      if (isLoading) {
        AppLoader.hide(Get.overlayContext!);
      }
      return data;
    } on DioException catch (error) {
      log("Dio error error: $error");
      if (isLoading) {
        AppLoader.hide(Get.overlayContext!);
      }
      return manageAPIError(error);

      // if (error.type == DioExceptionType.connectionTimeout) {
      //   // Handle connection timeout error
      //   log("Connection timeout: ${error.message}");
      //   Navigator.of(Get.context!).pop();
      //   AppDialogs.showSnackBar(
      //     title: 'Error',
      //     message: 'Connection timeout. Please check your internet connection.',
      //   );
      // } else if (error.response != null) {
      //   // Handle other Dio errors with response (e.g., 404, 500)
      //   log("Dio error response: ${error.response!.statusCode}");
      //   if (error.response!.statusCode == 404) {
      //     AppDialogs.showSnackBar(
      //       title: 'Error',
      //       message: 'URL is not found or page is missing. Please check URL.',
      //     );
      //   } else if (error.response!.statusCode == ApiConfig.unauthorizedCode) {
      //     if (endPoint.toString() == "login") {
      //       AppDialogs.showSnackBar(
      //         title: 'Error',
      //         message:
      //             'Request or parameters are bad and not acceptable by server.',
      //       );
      //     } else {
      //       AppDialogs.showSnackBar(
      //         title: 'Error',
      //         message:
      //             'Request or parameters are bad and not acceptable by server.',
      //       );
      //
      //       Get.offAllNamed(Routes.loginScreen);
      //     }
      //   }
      // } else {
      //   log("Unknown Dio error: ${error.message}");
      //   if (error.error is SocketException) {
      //     log("Please check your internet connection and try again.");
      //     AppDialogs.showSnackBar(
      //       title: 'Error',
      //       message: 'Please check your internet connection and try again.',
      //     );
      //   }
      // }
      // return null;
    } catch (e) {
      log("Unexpected error: $e");
      AppDialogs.showSnackBar(
        title: 'Error',
        message: 'An unexpected error occurred. Please try again later.',
      );
      return null;
    }
  }

  Future<dynamic> callPutApi({
    required String endPoint,
    required dynamic params,
    bool isLoading = true,
    Map<String, String>? customHeaders, // Custom headers parameter
    String? baseUrl,
  }) async {
    if (isLoading) {
      AppLoader.show(Get.overlayContext!);
    }
    Dio dio = Dio();
    log("endpoint===>" + endPoint.toString());
    var tLoginData = await SharedPrefsHelper.getObject(
        AppSharedPreferenceKeys.loginUserData);
    var token = '';
    if (tLoginData != null) {
      token = tLoginData['access_token'];
    }
    print('tLoginData => $tLoginData');
    print('token => $token');

    final String effectiveBaseUrl = baseUrl ?? ApiConfig.baseUrl;

    try {
      var response = await dio.put(
        (effectiveBaseUrl + endPoint),
        data: params,
        options: Options(
          sendTimeout: Duration(milliseconds: 6000),
          receiveTimeout: Duration(milliseconds: 6000),
          receiveDataWhenStatusError: true,
          headers: {
            // "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            ...?customHeaders,
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      var data = response.data;
      print("\n\nURL=>${ApiConfig.baseUrl + endPoint}\n\n");
      print("\n\nPOST REQUESTS=>${(params)}\n\n");
      print("\n\nPOST RESPONSE=>$data\n\n");
      if (isLoading) {
        AppLoader.hide(Get.overlayContext!);
      }
      return data;
    } on DioException catch (error) {
      log("Dio error error: $error");
      if (isLoading) {
        AppLoader.hide(Get.overlayContext!);
      }
      return manageAPIError(error);
    } catch (e) {
      log("Unexpected error: $e");
      AppDialogs.showSnackBar(
        title: 'Error',
        message: 'An unexpected error occurred. Please try again later.',
      );
      return null;
    }
  }

  Future<dynamic> manageAPIError(DioException error) async {
    log(error.toString());
    if (DioExceptionType.receiveTimeout == error.type ||
        DioExceptionType.connectionTimeout == error.type) {
      AppDialogs.showSnackBar(
          title: L10n.of(Get.context!)?.error ?? "",
          message: L10n.of(Get.context!)?.serverIsNotReachable ?? "");
    } else if (DioExceptionType.badResponse == error.type) {
      if (error.response!.statusCode == ApiConfig.unauthorizedCode) {
        AppDialogs.showSnackBar(
            title: L10n.of(Get.context!)?.error ?? "",
            message: L10n.of(Get.context!)?.serverIsNotReachable ?? "");
      } else if (error.response!.statusCode == 404) {
        AppDialogs.showSnackBar(
            title: L10n.of(Get.context!)?.error ?? "",
            message: L10n.of(Get.context!)?.urlIsNotFound ?? "");
        log("Url is not found or Page is missing.Please check Url.");
      } else if (error.response!.statusCode == 500) {
        log("Internal Sever Error");
        await SharedPrefsHelper.clear();
        Get.offAllNamed(Routes.loginScreen);
      }
    } else if (DioExceptionType.unknown == error.type) {
      if (error.toString().contains('SocketException')) {
        log("Please check your internet connection and try again");
        AppDialogs.showSnackBar(
            title: L10n.of(Get.context!)?.error ?? "",
            message: L10n.of(Get.context!)?.internetConnectionError ?? "");
      }
    }
    return null;
  }

  Future<void> callMediaAPI(
      {required String endPoint,
      required dynamic params,
      bool isLoading = true}) async {
    Dio dio = Dio();

    try {
      var tLoginData = await SharedPrefsHelper.getObject(
          AppSharedPreferenceKeys.loginUserData);
      print('params => $params');
      print('tLoginData => $tLoginData');
      print('url => ${ApiConfig.mediaBaseUrl + endPoint}');
      var token = '';
      if (tLoginData != null) {
        token = tLoginData['access_token'];
      }

      var response = await dio.post(
        (ApiConfig.mediaBaseUrl + endPoint),
        data: params,
        options: Options(
          sendTimeout: Duration(milliseconds: 6000),
          receiveTimeout: Duration(milliseconds: 6000),
          receiveDataWhenStatusError: true,
          headers: {
            "Content-Type": "application/jpg",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Data sent successfully: ${response}');
      } else {
        // Handle failure
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
}
