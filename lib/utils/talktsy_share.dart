import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talktsy/utils/platform_infos.dart';
import '../widgets/matrix.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

abstract class TalktsyShare {
  static Future<void> share(
    String text,
    BuildContext context, {
    bool copyOnly = false,
  }) async {
    if (PlatformInfos.isMobile && !copyOnly) {
      final box = context.findRenderObject() as RenderBox;
      await Share.share(
        text,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
      return;
    }
    await Clipboard.setData(
      ClipboardData(text: text),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(L10n.of(Get.context!)?.copiedToClipboard ?? "")),
    );
    return;
  }

  static Future<void> shareInviteLink(BuildContext context) async {
    final client = Matrix.of(context).client;
    final ownProfile = await client.fetchOwnProfile();
    await TalktsyShare.share(
      'inviteText'.trParams({
        'username': ownProfile.displayName ?? client.userID!,
        'link': 'https://matrix.to/#/${client.userID}?client=im.fluffychat',
      }),
      context,
    );
  }
}
