import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/meetings/join_meeting/join_meeting_controller.dart';
import 'package:talktsy/widgets/icon_button_shadow.dart';
import 'package:talktsy/widgets/submit_button_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_input_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class JoinMeetingScreen extends StatefulWidget {
  const JoinMeetingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  JoinMeetingController joinMeetingController =
      Get.put(JoinMeetingController());

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.joinAMeeting ?? "",
          onBackButtonPressed: () {
            Get.back();
          },
          mainContainerPadding: EdgeInsets.only(right: 10.w, left: 3.w)),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.whiteColor,
        padding: EdgeInsets.only(bottom: safePadding.bottom),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => Container(
                          height: 50.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 15.h),
                          margin: EdgeInsets.only(
                              top: 30.h, left: 22.h, right: 22.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyTextColor),
                            borderRadius: BorderRadius.circular(12.h),
                          ),
                          child: DropdownButton<String>(
                            value: joinMeetingController.selectedValue.value,
                            icon: Icon(Icons.keyboard_arrow_down,
                                size: 15.w, color: AppColors.blueTextColor),
                            iconSize: 20.h,
                            style: TextStyle(
                                color: AppColors.blueTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp),
                            underline: Container(
                              height: 0,
                            ),
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              joinMeetingController.setSelectedValue(newValue!);
                            },
                            items: joinMeetingController.dropdownItems
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 50.w,
                          child: Divider(
                            color: AppColors.inputHintColor,
                            thickness: 1.w,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: TextWidget(
                              text: L10n.of(context)?.or ?? "",
                              textStyle: TextStyle(fontSize: 13.sp),
                            )),
                        SizedBox(
                          width: 50.w,
                          child: Divider(
                            color: AppColors.inputHintColor,
                            thickness: 1.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    _meetingIdTextField(),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _audioButton(),
                        SizedBox(
                          width: 30.h,
                        ),
                        _videoButton()
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(() => Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  joinMeetingController.onRememberTap(
                                      !joinMeetingController.isRemember.value);
                                },
                                child: Container(
                                  height: 16.h,
                                  width: 16.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.w),
                                      color:
                                          joinMeetingController.isRemember.value
                                              ? AppColors.greenColor
                                              : AppColors.greyColorF2F2F2),
                                  child: joinMeetingController.isRemember.value
                                      ? Icon(
                                          Icons.check,
                                          size: 11.r,
                                          color: AppColors.whiteColor,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              TextWidget(
                                text: L10n.of(context)
                                        ?.rememberMyNameForFutureMeetings ??
                                    "",
                                textStyle: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyTextColor.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, -2), // changes position of shadow
                  ),
                ],
              ),
              child: SubmitButtonWidget(
                onPressed: () {
                  Get.toNamed(Routes.videoCallScreen);
                },
                text: L10n.of(context)?.join ?? "",
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _meetingIdTextField() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(left: 22.h, right: 22.h),
      child: TextInputWidget(
        controller: joinMeetingController.meetingIdTextController,
        onChanged: (value) {},
        hintText: L10n.of(context)?.meetingID ?? "",
        mainContainerSize: 50.h,
        isDense: false,
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
        borderRadius: 12,
      ),
    );
  }

  Widget _audioButton() {
    return Obx(() => IconButtonShadow(
          icon: joinMeetingController.audioSelected.value
              ? Icons.mic_none
              : Icons.mic_off_outlined,
          onPressed: () {
            joinMeetingController
                .onAudioTap(!joinMeetingController.audioSelected.value);
          },
          backgroundColor: joinMeetingController.audioSelected.value
              ? AppColors.greenColor
              : AppColors.inputHintColor,
          shadowColor: joinMeetingController.audioSelected.value
              ? AppColors.greenColor.withOpacity(0.5)
              : AppColors.greyTextColor.withOpacity(0.5),
        ));
  }

  Widget _videoButton() {
    return Obx(() => IconButtonShadow(
          icon: joinMeetingController.videoSelected.value
              ? Icons.videocam_outlined
              : Icons.videocam_off_outlined,
          onPressed: () {
            joinMeetingController
                .onVideoTap(!joinMeetingController.videoSelected.value);
          },
          backgroundColor: joinMeetingController.videoSelected.value
              ? AppColors.greenColor
              : AppColors.inputHintColor,
          shadowColor: joinMeetingController.videoSelected.value
              ? AppColors.greenColor.withOpacity(0.5)
              : AppColors.greyTextColor.withOpacity(0.5),
        ));
  }
}
