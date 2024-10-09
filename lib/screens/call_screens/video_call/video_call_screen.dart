import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/screens/call_screens/video_call/video_call_controller.dart';
import 'package:talktsy/widgets/icon_button_shadow.dart';
import 'package:talktsy/widgets/text_widget.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  VideoCallController videoCallController = Get.put(VideoCallController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.blueTextColor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r)),
                child: Stack(
                  children: [
                    Image.asset(
                      AppImages.icLadyTemp,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 15.w,
                      bottom: 20.w,
                      right: 20.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r))),
                              // height: 22.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7.w, vertical: 4.w),
                              child: Row(
                                children: [
                                  Icon(Icons.graphic_eq_outlined, size: 13.w),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Expanded(
                                    child: TextWidget(
                                      text: 'Prameshwar Kumar',
                                      overflow: TextOverflow.ellipsis,
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.sp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.r))),
                            height: 150.w,
                            width: 100.h,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.r)),
                              child: Image.asset(
                                AppImages.icBoyTemp,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // child: Image.asset(name),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              // height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _audioButton(),
                  _volumeButton(),
                  _videoButton(),
                  _screenShareButton(),
                  _chatButton(),
                  _crossButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _audioButton() {
    return Obx(() => IconButtonShadow(
        containerHeight: videoCallController.iconButtonHeight,
        containerWidth: videoCallController.iconButtonWidth,
        iconSize: 25,
        icon: videoCallController.audioSelected.value
            ? Icons.mic_none
            : Icons.mic_off_outlined,
        onPressed: () {
          videoCallController
              .onAudioTap(!videoCallController.audioSelected.value);
        },
        backgroundColor: videoCallController.audioSelected.value
            ? AppColors.greenColor
            : AppColors.whiteColor.withOpacity(0.1),
        shadowColor: AppColors.transparent));
  }

  Widget _volumeButton() {
    return IconButtonShadow(
        containerHeight: videoCallController.iconButtonHeight,
        containerWidth: videoCallController.iconButtonWidth,
        iconSize: 25,
        icon: Icons.volume_down_outlined,
        onPressed: () {},
        backgroundColor: AppColors.whiteColor.withOpacity(0.1),
        shadowColor: AppColors.transparent);
  }

  Widget _videoButton() {
    return Obx(() => IconButtonShadow(
        containerHeight: videoCallController.iconButtonHeight,
        containerWidth: videoCallController.iconButtonWidth,
        iconSize: 25,
        icon: Icons.videocam_outlined,
        onPressed: () {
          videoCallController
              .onVideoTap(!videoCallController.videoSelected.value);
        },
        backgroundColor: videoCallController.videoSelected.value
            ? AppColors.greenColor
            : AppColors.whiteColor.withOpacity(0.1),
        shadowColor: AppColors.transparent));
  }

  Widget _screenShareButton() {
    return Obx(() => IconButtonShadow(
        containerHeight: videoCallController.iconButtonHeight,
        containerWidth: videoCallController.iconButtonWidth,
        iconSize: 22,
        icon: Icons.screen_share_outlined,
        onPressed: () {
          videoCallController
              .onScreenShareTap(!videoCallController.screenShareSelected.value);
        },
        backgroundColor: videoCallController.screenShareSelected.value
            ? AppColors.greenColor
            : AppColors.whiteColor.withOpacity(0.1),
        shadowColor: AppColors.transparent));
  }

  Widget _chatButton() {
    return Obx(() => IconButtonShadow(
        containerHeight: videoCallController.iconButtonHeight,
        containerWidth: videoCallController.iconButtonWidth,
        iconSize: 17,
        iconImage: AppImages.icTabChat,
        onPressed: () {},
        backgroundColor: videoCallController.chatSelected.value
            ? AppColors.greenColor
            : AppColors.whiteColor.withOpacity(0.1),
        shadowColor: AppColors.transparent));
  }

  Widget _crossButton() {
    return IconButtonShadow(
        containerHeight: videoCallController.iconButtonHeight,
        containerWidth: videoCallController.iconButtonWidth,
        iconSize: 20,
        icon: Icons.close,
        onPressed: () {
          Get.back();
        },
        backgroundColor: AppColors.redColor,
        shadowColor: AppColors.transparent);
  }
}
