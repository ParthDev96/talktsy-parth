import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:talktsy/config/app_dialogs.dart';
import 'package:talktsy/services/api_config.dart';
import 'package:talktsy/services/api_service.dart';
import 'package:talktsy/utils/app_regular_expressions.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SignupController extends GetxController {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController conPasswordTextController = TextEditingController();
  TextEditingController mobileNoTextController = TextEditingController();

  final FocusNode focusNode = FocusNode();
  CountrySelectorNavigator selectorNavigator =
      const CountrySelectorNavigator.page();
  late PhoneController controllers;

  Locale locale = const Locale('in');
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    conPasswordTextController = TextEditingController();
    mobileNoTextController = TextEditingController();

    controllers = PhoneController();

    if (kDebugMode) {
      emailTextController.text = 'parth@august.inc';
      nameTextController.text = 'parth_august';
      passwordTextController.text = 'Manu@3114';
    }
  }

  void onRegisterTap() async {
    if (emailTextController.text.trim().isEmpty) {
      AppDialogs.showSnackBar(
          title: L10n.of(Get.context!)?.error ?? "",
          message: L10n.of(Get.context!)?.errorEmail ?? "");
    } else if (!RegularExpressions.emailRegexExpression
        .hasMatch(emailTextController.text)) {
      AppDialogs.showSnackBar(
          title: L10n.of(Get.context!)?.error ?? "",
          message: L10n.of(Get.context!)?.errorValidEmail ?? "");
    } else if (passwordTextController.text.trim().isEmpty) {
      AppDialogs.showSnackBar(
          title: L10n.of(Get.context!)?.error ?? "",
          message: L10n.of(Get.context!)?.errorPassword ?? "");
    } else {
      isLoading.value = true;
      var isUserAvailable = await checkUsernameAvailable();
      print('isUserAvailable => $isUserAvailable');
      if (isUserAvailable) {
        var params = {
          // "auth": {"do_c5": {}},
          // "inhibit_login": "<boolean>",
          "initial_device_display_name":
              "app.talktsy.com: Mobile on ${Platform.isAndroid ? 'Android' : 'iOS'} App",
          "password": passwordTextController.text.trim(),
          "username": nameTextController.text.trim()
        };
        var data = await ApiManager().callPostApi(
            endPoint: ApiConfig.loginEndpoint,
            params: params,
            isLoading: false);
        isLoading.value = false;
        // if (data['error'] != '' && data['error'] != null) {
        //   AppDialogs.showSnackBar(
        //       title: L10n.of(Get.context!)?.error ?? "", message: data["error"].toString().tr);
        // } else {
        //   SharedPrefsHelper.saveObject(
        //       AppSharedPreferenceKeys.loginUserData, data);
        //   Get.offAllNamed(Routes.bottomNavigationScreen);
        //   AppDialogs.showSnackBar(
        //       title: L10n.of(Get.context!)?.success ?? "", message: L10n.of(Get.context!)?.loginSuccessMessage??"");
        // }

        // Get.toNamed(
        //   Routes.verificationScreen,
        // );
      }
    }
  }

  Future<bool> checkUsernameAvailable() async {
    var data = await ApiManager().callGetApi(
        endPoint:
            ApiConfig.userAvailableEndpoint + nameTextController.text.trim(),
        isLoading: false);
    print('USER name avail data => $data');
    if (data['error'] != '' && data['error'] != null) {
      AppDialogs.showSnackBar(
          title: L10n.of(Get.context!)?.error ?? "",
          message: data["error"].toString().tr);
      return false;
    } else {
      if (data['available'] == true) {
        return true;
      }
      return false;
    }
  }
}
