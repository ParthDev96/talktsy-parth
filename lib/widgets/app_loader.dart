import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_dialogs.dart';

class AppLoader {
  static bool _isLoading = false;

  static void show(BuildContext context) {
    if (_isLoading) return; // Prevent showing multiple loaders
    _isLoading = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppDialogs.progressDialog(),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    if (!_isLoading) return;
    _isLoading = false;

    Navigator.of(context, rootNavigator: true).pop();
  }
}
