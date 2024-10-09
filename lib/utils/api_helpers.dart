import 'package:get/get.dart';
import 'package:talktsy/config/app_dialogs.dart';
import 'package:talktsy/config/app_shared_preference_keys.dart';
import 'package:talktsy/models/user_profile.dart';
import 'package:talktsy/services/api_config.dart';
import 'package:talktsy/services/api_service.dart';
import 'package:talktsy/utils/app_shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ApiServices {
  static Future<UserProfile?> getProfileData() async {
    var tLoginData = await SharedPrefsHelper.getObject(
        AppSharedPreferenceKeys.loginUserData);
    var updatedURL =
        ApiConfig.profileEndpoint.replaceAll(':userId', tLoginData['user_id']);
    print('getProfileData updatedURL => $updatedURL');
    var response =
        await ApiManager().callGetApi(endPoint: updatedURL, isLoading: false);
    print('getProfileData response => $response');
    if (response != null) {
      if (response['error'] != '' && response['error'] != null) {
        AppDialogs.showSnackBar(
            title: L10n.of(Get.context!)?.error ?? "",
            message: response["error"].toString().tr);
      } else {
        var profile = UserProfile.fromJson(response);
        SharedPreferenceUserProfile.saveUserProfile(profile);
        return profile;
      }
    }
    return null;
  }
}
