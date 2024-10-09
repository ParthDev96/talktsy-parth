import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/widgets/custom_button.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ConfirmationPopupController extends GetxController {}

class ConfirmationPopup extends StatefulWidget {
  final String title;
  final String message;
  final String? cancelButtonTitle;
  final String? confirmButtonTitle;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const ConfirmationPopup(
      {super.key,
      required this.title,
      required this.message,
      this.onCancel,
      this.onConfirm,
      this.cancelButtonTitle,
      this.confirmButtonTitle});

  @override
  State<ConfirmationPopup> createState() => _ConfirmationPopupState();
}

class _ConfirmationPopupState extends State<ConfirmationPopup> {
  final ConfirmationPopupController confirmationPopupController =
      Get.put(ConfirmationPopupController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            color: AppColors.whiteColor.withOpacity(0),
          ),
        ),
        // Dialog
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16.w)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextWidget(
                      text: widget.title,
                      textStyle: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15.h),
                    TextWidget(
                      text: widget.message,
                      textStyle: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                if (widget.onCancel != null) {
                                  widget.onCancel!();
                                }
                                Navigator.of(context).pop();
                              },
                              text: widget.cancelButtonTitle ??
                                  L10n.of(Get.context!)?.cancel ??
                                  "",
                              textStyle: TextStyle(color: AppColors.whiteColor),
                              backgroundColor: AppColors.inputHintColor,
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Future.delayed(
                                    const Duration(milliseconds: 300), () {
                                  if (widget.onConfirm != null) {
                                    widget.onConfirm!();
                                  }
                                });
                              },
                              text: widget.confirmButtonTitle ??
                                  L10n.of(Get.context!)?.okay ??
                                  "",
                              textStyle: TextStyle(color: AppColors.whiteColor),
                              backgroundColor: AppColors.greenColor,
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
