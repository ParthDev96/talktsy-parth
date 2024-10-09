import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:talktsy/config/app_dialogs.dart';
import 'package:talktsy/config/app_shared_preference_keys.dart';
import 'package:talktsy/services/api_config.dart';
import 'package:talktsy/services/api_service.dart';
import 'package:talktsy/utils/app_shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AccountAndProfileController extends GetxController {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController addTitleTextController = TextEditingController();
  RxBool editImage = false.obs;
  File? pickImageFiles;

  RxBool maleGenderSelected = true.obs;
  Locale locale = const Locale('in');
  final FocusNode focusNode = FocusNode();
  CountrySelectorNavigator selectorNavigator =
      const CountrySelectorNavigator.page();
  late PhoneController controllers;

  void onRemoveProfileImage() {
    editImage.value = false;
    pickImageFiles = null;
  }

  @override
  void onInit() {
    super.onInit();
    controllers = PhoneController();
  }

  void onChangeGender(bool value) {
    maleGenderSelected.value = value;
  }

  void onSaveInformationTap() async {
    if (editImage.value) {
      print(pickImageFiles);
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      var base64Path = await getBase64FromFile(File(pickImageFiles!.path));
      var data = await ApiManager().callPostApi(
          endPoint: '${ApiConfig.uploadImageEndpoint}$timestamp.jpg',
          params: base64Path,
          customHeaders: {
            "Content-Type": "application/jpg",
          },
          baseUrl: ApiConfig.mediaBaseUrl,
          isLoading: true);
      print('uploadImageEndpoint res,$data');

      if (data['error'] != '' && data['error'] != null) {
        AppDialogs.showSnackBar(
            title: L10n.of(Get.context!)?.error ?? "",
            message: data["error"].toString().tr);
      } else {
        var tLoginData = await SharedPrefsHelper.getObject(
            AppSharedPreferenceKeys.loginUserData);
        var updatedURL = ApiConfig.updateProfileImageEndpoint
            .replaceAll(':userId', tLoginData['user_id']);
        print('updatedURL => $updatedURL');
        var response = await ApiManager().callPutApi(
            endPoint: updatedURL,
            params: {'avatar_url': data['content_uri']},
            isLoading: true);
        print('response => $response');
        if (response['error'] != '' && response['error'] != null) {
          AppDialogs.showSnackBar(
              title: L10n.of(Get.context!)?.error ?? "",
              message: response["error"].toString().tr);
        } else {}
      }
      // isLoading.value = false;
    }
  }

  Future<String?> getBase64FromFile(File imageFile) async {
    try {
      // Read the file as bytes
      final bytes = await imageFile.readAsBytes();

      // Convert bytes to Base64 string
      final base64String = base64Encode(bytes);

      return base64String;
    } catch (e) {
      print('Error encoding file to Base64: $e');
      return null;
    }
  }
}
