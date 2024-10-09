import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/widgets/icon_button_shadow.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class IncomingCallScreen extends StatefulWidget {
  const IncomingCallScreen({super.key});

  @override
  State<StatefulWidget> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              AppImages.icLadyTemp,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    color: AppColors.greyColor8A9D9A.withOpacity(
                        0.6), // Necessary to enable the blur effect
                  ),
                )),
            Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                          child: Center(
                              child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(160.h),
                              ),
                              height: 160.h,
                              width: 160.h,
                              child: Padding(
                                padding: EdgeInsets.all(13.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(190.h),
                                  child: Image.asset(
                                    AppImages.tempGirl,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TextWidget(
                              text: 'Maria Vetrovs',
                              textStyle: TextStyle(
                                  color: AppColors.whiteColor, fontSize: 22.sp),
                            ),
                            TextWidget(
                              text: L10n.of(Get.context!)?.incomingCall ?? "",
                              textStyle: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ))),
                      Container(
                        // height: 100,
                        margin: EdgeInsets.symmetric(
                            vertical: 28.h, horizontal: 35.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                _rejectButton(),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextWidget(
                                  text: L10n.of(Get.context!)?.reject ?? "",
                                  textStyle: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                              ],
                            ),
                            _chatButton(),
                            Column(
                              children: [
                                _confirmButton(),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextWidget(
                                  text: L10n.of(Get.context!)?.confirm ?? "",
                                  textStyle: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _rejectButton() {
    return IconButtonShadow(
        containerHeight: 50,
        containerWidth: 50,
        iconSize: 28,
        icon: Icons.call_end_rounded,
        onPressed: () {
          Get.back();
        },
        backgroundColor: AppColors.redColor,
        shadowColor: AppColors.transparent);
  }

  Widget _confirmButton() {
    return IconButtonShadow(
        containerHeight: 50,
        containerWidth: 50,
        iconSize: 28,
        icon: Icons.call,
        onPressed: () {
          Get.back();
        },
        backgroundColor: AppColors.greenColor,
        shadowColor: AppColors.transparent);
  }

  Widget _chatButton() {
    return IconButtonShadow(
        containerHeight: 45,
        containerWidth: 45,
        iconSize: 22,
        iconImage: AppImages.icMessageDots,
        borderColor: AppColors.whiteColor.withOpacity(0.5),
        borderWidth: 2.w,
        onPressed: () {},
        backgroundColor: AppColors.transparent,
        shadowColor: AppColors.transparent);
  }
}
