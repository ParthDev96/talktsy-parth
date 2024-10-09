import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:matrix/matrix.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:talktsy/widgets/matrix.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

extension UiaRequestManager on MatrixState {
  Future uiaRequestHandler(UiaRequest uiaRequest) async {
    try {
      if (uiaRequest.state != UiaRequestState.waitForUser ||
          uiaRequest.nextStages.isEmpty) {
        Logs().d('Uia Request Stage: ${uiaRequest.state}');
        return;
      }
      final stage = uiaRequest.nextStages.first;
      Logs().d('Uia Request Stage: $stage');
      switch (stage) {
        case AuthenticationTypes.password:
          final input = cachedPassword ??
              (await showTextInputDialog(
                context: context,
                title: L10n.of(Get.context!)?.pleaseEnterYourPassword ?? "",
                okLabel: L10n.of(Get.context!)?.ok ?? "",
                cancelLabel: L10n.of(Get.context!)?.cancel ?? "",
                textFields: [
                  const DialogTextField(
                    minLines: 1,
                    maxLines: 1,
                    obscureText: true,
                    hintText: '******',
                  ),
                ],
              ))
                  ?.single;
          if (input == null || input.isEmpty) {
            return uiaRequest.cancel();
          }
          return uiaRequest.completeStage(
            AuthenticationPassword(
              session: uiaRequest.session,
              password: input,
              identifier: AuthenticationUserIdentifier(user: client.userID!),
            ),
          );
        case AuthenticationTypes.emailIdentity:
          if (currentThreepidCreds == null) {
            return uiaRequest.cancel(
              UiaException(L10n.of(Get.context!)?.serverRequiresEmail ?? ""),
            );
          }
          final auth = AuthenticationThreePidCreds(
            session: uiaRequest.session,
            type: AuthenticationTypes.emailIdentity,
            threepidCreds: ThreepidCreds(
              sid: currentThreepidCreds!.sid,
              clientSecret: currentClientSecret,
            ),
          );
          if (OkCancelResult.ok ==
              await showOkCancelAlertDialog(
                useRootNavigator: false,
                context: context,
                title: L10n.of(Get.context!)?.weSentYouAnEmail ?? "",
                message: L10n.of(Get.context!)?.pleaseClickOnLink ?? "",
                okLabel: L10n.of(Get.context!)?.iHaveClickedOnLink ?? "",
                cancelLabel: L10n.of(Get.context!)?.cancel ?? "",
              )) {
            return uiaRequest.completeStage(auth);
          }
          return uiaRequest.cancel();
        case AuthenticationTypes.dummy:
          return uiaRequest.completeStage(
            AuthenticationData(
              type: AuthenticationTypes.dummy,
              session: uiaRequest.session,
            ),
          );
        default:
          final url = Uri.parse(
            '${client.homeserver}/_matrix/client/r0/auth/$stage/fallback/web?session=${uiaRequest.session}',
          );
          launchUrlString(url.toString());
          if (OkCancelResult.ok ==
              await showOkCancelAlertDialog(
                useRootNavigator: false,
                message:
                    L10n.of(Get.context!)?.pleaseFollowInstructionsOnWeb ?? "",
                context: context,
                okLabel: L10n.of(Get.context!)?.next ?? "",
                cancelLabel: L10n.of(Get.context!)?.cancel ?? "",
              )) {
            return uiaRequest.completeStage(
              AuthenticationData(session: uiaRequest.session),
            );
          } else {
            return uiaRequest.cancel();
          }
      }
    } catch (e, s) {
      Logs().e('Error while background UIA', e, s);
      return uiaRequest.cancel(e is Exception ? e : Exception(e));
    }
  }
}

class UiaException implements Exception {
  final String reason;

  UiaException(this.reason);

  @override
  String toString() => reason;
}
