import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';

class AppDialogs {
  static void showToast({String? message}) {
    Fluttertoast.showToast(
        msg: message!.tr ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.greyTextColor);
  }

  static void showSnackBar(
      {String? title,
      String? message,
      Color colorText = AppColors.whiteColor, // Default text color
      Color backgroundColor = AppColors.greenColor}) {
    Get.snackbar(
      title!.tr ?? 'No Title', // Use 'No Title' if title is null
      message ?? 'No Message', // Use 'No Message' if message is null
      backgroundColor: backgroundColor,
      colorText: colorText ?? AppColors.whiteColor,
      duration: Duration(seconds: 2),
    );
  }

  static Widget progressDialog() {
    return SpinKitCircle(
      color: AppColors.whiteColor,
      size: 30.h,
    );
  }

  static Widget progressDialogBlueColor() {
    return SpinKitFadingCircle(
      color: AppColors.greyColorF2F2F2,
      size: 60.h,
    );
  }
}
