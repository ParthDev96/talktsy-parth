import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_dialogs.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/models/user_profile.dart';
import 'package:talktsy/popups/confirmation_popup.dart';
import 'package:talktsy/routes/app_routes.dart';
// import 'package:talktsy/utils/api_helpers.dart';
import 'package:talktsy/utils/app_shared_preferences.dart';
import 'package:talktsy/widgets/app_loader.dart';
import 'package:talktsy/widgets/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix/matrix.dart';

class ProfileScreenController extends GetxController {
  var selectedValue = Rxn<TypeUserStatus>();
  // var userProfile = Rxn<UserProfile>();
  var profileUrl = Rxn<String>('');

  Rxn<Future<Profile>?> profileFuture = Rxn<Future<Profile>?>();
  var profileUpdated = false.obs;

  List<TypeUserStatus> dropdownItems = [
    TypeUserStatus('Busy', 'busy'),
    TypeUserStatus('Online', 'online'),
    TypeUserStatus('In meeting', 'in_meeting'),
    TypeUserStatus('Driving', 'driving'),
    TypeUserStatus('In office', 'in_office'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    selectedValue.value = dropdownItems[0];
  }

  void updateDropdownItem(TypeUserStatus item) {
    selectedValue.value = item;
  }

  void loadUserProfile() async {
    // UserProfile? profile = await SharedPreferenceUserProfile.getUserProfile();
    // if (profile != null) {
    //   userProfile.value = profile;
    // } else {
    //   profile = await ApiServices.getProfileData();
    //   if (profile != null) {
    //     await SharedPreferenceUserProfile.saveUserProfile(profile);
    //     userProfile.value = profile;
    //   }
    // }
    // if (profile != null) {
    //   updateProfileUrl(profile);
    // }
  }

  // void updateProfileUrl(UserProfile profile) {
  //   print('profile : ${profile.avatarUrl}');
  //   // var newImage = profile.avatarUrl.replaceAll('mxc://', '');
  //   var newImage =
  //       'https://app.talktsy.com/_matrix/media/r0/thumbnail/${profile.avatarUrl.replaceAll('mxc://', '')}?width=128&height=128&method=crop';
  //   print('newImage: $newImage');
  //   profileUrl.value = newImage;
  // }

  void onLogoutPress(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.greyTextColor.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return ConfirmationPopup(
          title: L10n.of(Get.context!)?.logout ?? "",
          message: L10n.of(Get.context!)?.logoutConformationMessage ?? "",
          cancelButtonTitle: L10n.of(Get.context!)?.no ?? "",
          confirmButtonTitle: L10n.of(Get.context!)?.yes ?? "",
          onConfirm: () {
            onLogoutTap(context);
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  void onLogoutTap(BuildContext context) async {
    try {
      AppLoader.show(context);

      final matrix = Matrix.of(context);
      await matrix.client.logout();
      AppLoader.hide(context);

      SharedPrefsHelper.clear();
      Get.offNamed(
        Routes.loginScreen,
      );
      AppDialogs.showSnackBar(
          title: L10n.of(Get.context!)?.success ?? "",
          message: L10n.of(Get.context!)?.logoutSuccessMessage ?? "");
    } catch (error) {
      print('error logout => $error');
    }

    // var params = {};
    // var data = await ApiManager()
    //     .callPostApi(endPoint: ApiConfig.logoutEndpoint, params: params);
    // if (data['error'] != '' && data['error'] != null) {
    //   AppDialogs.showSnackBar(
    //       title: L10n.of(Get.context!)?.error ?? "", message: data["error"].toString().tr);
    // } else {
    //   SharedPrefsHelper.clear();
    //   Get.offNamed(
    //     Routes.loginScreen,
    //   );
    //   AppDialogs.showSnackBar(
    //       title: L10n.of(Get.context!)?.success ?? "", message: L10n.of(Get.context!)?.logoutSuccessMessage ?? "");
    // }
  }

  void updateProfile() {
    profileUpdated.value = true;
    profileFuture.value = null;
  }

  // Future<void> setDisplayNameAction(BuildContext context) async {
  //   final profile = await profileFuture.value;
  //   final input = await showTextInputDialog(
  //     useRootNavigator: false,
  //     context: context,
  //     title: L10n.of(context)!.editDisplayName,
  //     okLabel: L10n.of(context)!.ok,
  //     cancelLabel: L10n.of(context)!.cancel,
  //     textFields: [
  //       DialogTextField(
  //         initialText: profile?.displayName ??
  //             Matrix.of(context).client.userID!.localpart,
  //       ),
  //     ],
  //   );
  //   if (input == null) return;
  //
  //   final matrix = Matrix.of(context);
  //   final success = await showFutureLoadingDialog(
  //     context: context,
  //     future: () =>
  //         matrix.client.setDisplayName(matrix.client.userID!, input.single),
  //   );
  //   if (success.error == null) {
  //     updateProfile();
  //   }
  // }

}
