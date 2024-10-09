import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';
import 'package:talktsy/config/app_dialogs.dart';
import 'package:talktsy/utils/app_regular_expressions.dart';
import 'package:talktsy/utils/platform_infos.dart';
import 'package:talktsy/widgets/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  Timer? _coolDown;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    if (kDebugMode) {
      emailController.text = 'vanraparth2014@gmail.com';
      passwordController.text = 'Abcd@1234';
    }
  }

  void onLoginTap(BuildContext context) async {
    final matrix = Matrix.of(context);
    var emailText = emailController.text.trim();
    if (emailText.isEmpty) {
      AppDialogs.showSnackBar(
          title: L10n.of(context)?.error ?? "",
          message: L10n.of(context)?.errorEmail ?? "");
    } else if (!RegularExpressions.emailRegexExpression
        .hasMatch(emailController.text)) {
      AppDialogs.showSnackBar(
          title: L10n.of(context)?.error ?? "",
          message: L10n.of(context)?.errorValidEmail ?? "");
    } else if (passwordController.text.trim().isEmpty) {
      AppDialogs.showSnackBar(
          title: L10n.of(context)?.error ?? "",
          message: L10n.of(context)?.errorPassword ?? "");
    } else {
      try {
        isLoading.value = true;
        var newDomain = Uri.https('matrix-client.matrix.org', '');
        Matrix.of(context).getLoginClient().homeserver = newDomain;
        await Matrix.of(context).getLoginClient().checkHomeserver(newDomain);
        var homeServer = Matrix.of(context).getLoginClient().homeserver;
        print('HomeServer => $homeServer');
        AuthenticationIdentifier identifier =
            AuthenticationThirdPartyIdentifier(
          medium: 'email',
          address: emailText,
        );
        await matrix.getLoginClient().login(
              LoginType.mLoginPassword,
              identifier: identifier,
              // To stay compatible with older server versions
              // ignore: deprecated_member_use
              user: identifier.type == AuthenticationIdentifierTypes.userId
                  ? emailText
                  : null,
              password: passwordController.text,
              initialDeviceDisplayName: PlatformInfos.clientName,
            );
        isLoading.value = false;
      } on MatrixException catch (exception) {
        print('MatrixException: $exception');
        isLoading.value = false;
        AppDialogs.showSnackBar(
            title: L10n.of(Get.context!)?.error ?? "",
            message: exception.errorMessage);
        return;
      } catch (exception) {
        print('exception: $exception');
        isLoading.value = false;
        AppDialogs.showSnackBar(
            title: L10n.of(Get.context!)?.error ?? "",
            message: exception.toString());
        return;
      }

      // var params = {
      //   "type": "m.login.password",
      //   "address": emailText,
      //   "identifier": {"type": "m.id.thirdparty"},
      //   "initial_device_display_name":
      //       "app.talktsy.com: Mobile on ${Platform.isAndroid ? 'Android' : 'iOS'} App",
      //   "medium": "email",
      //   "password": passwordController.text.trim()
      // };
      // var data = await ApiManager()
      //     .callPostApi(endPoint: ApiConfig.loginEndpoint, params: params, isLoading: false);
      // isLoading.value = false;
      // if (data['error'] != '' && data['error'] != null) {
      //   AppDialogs.showSnackBar(
      //       title: L10n.of(Get.context!)?.error ?? "", message: data["error"].toString().tr);
      // } else {
      //   SharedPrefsHelper.saveObject(
      //       AppSharedPreferenceKeys.loginUserData, data);
      //   Get.offAllNamed(Routes.bottomNavigationScreen);
      //   AppDialogs.showSnackBar(
      //       title: L10n.of(Get.context!)?.success ?? "", message: L10n.of(context)?.loginSuccessMessage ?? "");
      // }
    }
  }

  void checkWellKnownWithCoolDown(String userId, BuildContext context) async {
    _coolDown?.cancel();
    _coolDown = Timer(
      const Duration(seconds: 1),
      () => _checkWellKnown(userId, context),
    );
  }

  void _checkWellKnown(String userId, BuildContext context) async {
    print('userId => $userId');
    // if (mounted) setState(() => usernameError = null);
    if (!userId.isValidMatrixId) return;
    final oldHomeserver = Matrix.of(context).getLoginClient().homeserver;
    print('oldHomeserver => $oldHomeserver');
    try {
      var newDomain = Uri.https(userId.domain!, '');
      print('newDomain => $newDomain');
      Matrix.of(context).getLoginClient().homeserver = newDomain;
      DiscoveryInformation? wellKnownInformation;
      try {
        wellKnownInformation =
            await Matrix.of(context).getLoginClient().getWellknown();
        if (wellKnownInformation.mHomeserver.baseUrl.toString().isNotEmpty) {
          newDomain = wellKnownInformation.mHomeserver.baseUrl;
        }
      } catch (_) {
        // do nothing, newDomain is already set to a reasonable fallback
      }
      print('newDomain => $newDomain,oldHomeserver => $oldHomeserver ');
      if (newDomain != oldHomeserver) {
        await Matrix.of(context).getLoginClient().checkHomeserver(newDomain);

        if (Matrix.of(context).getLoginClient().homeserver == null) {
          Matrix.of(context).getLoginClient().homeserver = oldHomeserver;
          // okay, the server we checked does not appear to be a matrix server
          Logs().v(
            '$newDomain is not running a homeserver, asking to use $oldHomeserver',
          );
          // final dialogResult = await showOkCancelAlertDialog(
          //   context: context,
          //   useRootNavigator: false,
          //   message:
          //   L10n.of(context)!.noMatrixServer(newDomain, oldHomeserver!),
          //   okLabel: L10n.of(context)!.ok,
          //   cancelLabel: L10n.of(context)!.cancel,
          // );
          // if (dialogResult == OkCancelResult.ok) {
          //   if (mounted) setState(() => usernameError = null);
          // } else {
          //   Navigator.of(context, rootNavigator: false).pop();
          //   return;
          // }
        }
        // usernameError = null;
        // if (mounted) setState(() {});
      } else {
        Matrix.of(context).getLoginClient().homeserver = oldHomeserver;
        // if (mounted) {
        //   setState(() {});
        // }
      }
    } catch (e) {
      Matrix.of(context).getLoginClient().homeserver = oldHomeserver;
      // usernameError = e.toLocalizedString(context);
      // if (mounted) setState(() {});
    }
  }
}
