import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

Future<bool> requestCameraPermission() async {
  var status = await Permission.camera.status;
  if (status.isGranted) {
    return true;
  } else {
    PermissionStatus tPermission = await Permission.camera.request();
    if (tPermission.isGranted) {
      return true;
    } else {
      showPermissionErrorPopup(L10n.of(Get.context!)?.permissionError ?? "",
          L10n.of(Get.context!)?.cameraPermissionErrorMessage ?? "");
      return false;
    }
  }
}

Future<bool> requestPhotoLibraryPermission() async {
  var status = await Permission.photos.status;
  if (status.isGranted) {
    return true;
  } else {
    PermissionStatus tPermission = await Permission.photos.request();
    if (tPermission.isGranted) {
      return true;
    } else {
      showPermissionErrorPopup(L10n.of(Get.context!)?.permissionError ?? "",
          L10n.of(Get.context!)?.photoPermissionErrorMessage ?? "");
      return false;
    }
  }
}

showPermissionErrorPopup(String title, String message) {
  showDialog(
    barrierDismissible: false,
    context: Get.context!,
    builder: (_) {
      return AlertDialog(
        title: TextWidget(
          text: title,
          textStyle: TextStyle(fontSize: 16.sp, color: AppColors.blackColor),
        ),
        content: TextWidget(
          text: message,
          textStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(Get.context!).pop();
            },
            child: TextWidget(
              text: L10n.of(Get.context!)?.cancel ?? "",
              textStyle:
                  TextStyle(fontSize: 14.sp, color: AppColors.blackColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(Get.context!).pop();
              openAppSettings();
            },
            child: TextWidget(
              text: L10n.of(Get.context!)?.settings ?? "",
              textStyle:
                  TextStyle(fontSize: 14.sp, color: AppColors.blackColor),
            ),
          ),
        ],
      );
    },
  );
}
