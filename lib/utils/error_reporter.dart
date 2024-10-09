import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/shades-of-purple.dart';
import 'package:matrix/matrix.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ErrorReporter {
  final BuildContext context;
  final String? message;

  const ErrorReporter(this.context, [this.message]);

  void onErrorCallback(Object error, [StackTrace? stackTrace]) async {
    Logs().e(message ?? 'Error caught', error, stackTrace);
    final text = '$error\n${stackTrace ?? ''}';
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(L10n.of(Get.context!)?.reportErrorDescription ?? ""),
        content: SizedBox(
          height: 256,
          width: 256,
          child: SingleChildScrollView(
            child: HighlightView(
              text,
              language: 'sh',
              theme: shadesOfPurpleTheme,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(L10n.of(Get.context!)?.close ?? ""),
          ),
          TextButton(
            onPressed: () => Clipboard.setData(
              ClipboardData(text: text),
            ),
            child: Text(L10n.of(Get.context!)?.copy ?? ""),
          ),
        ],
      ),
    );
  }
}
