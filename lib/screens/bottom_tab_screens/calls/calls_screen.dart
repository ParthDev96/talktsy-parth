import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/bottom_tab_screens/calls/calls_screen_controller.dart';
import 'package:get/get.dart';
import 'package:talktsy/widgets/icon_button_shadow.dart';
import 'package:talktsy/widgets/search_input_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  CallsScreenController callsScreenController =
      Get.put(CallsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.calls ?? "",
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.notificationListScreen);
                },
                icon: Image.asset(
                  AppImages.icNotification,
                  color: AppColors.greenColor,
                  height: 17.w,
                  width: 17.w,
                ))
          ],
          mainContainerPadding: EdgeInsets.only(right: 7.w, left: 20.w)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            SearchInputWidget(
                controller: callsScreenController.searchText,
                verticalPadding: 5),
            Expanded(
              child: ListView.builder(
                itemCount: callsScreenController.users.length,
                itemBuilder: (context, index) {
                  return UserListItem(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  final int index;

  const UserListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(AppImages.tempGirl),
            radius: 20.r,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Tatiana Lipshutz',
                  overflow: TextOverflow.ellipsis,
                  textStyle: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    getCallImage(),
                    SizedBox(width: 4.w),
                    TextWidget(
                      text: getCallStatus(),
                      textStyle: TextStyle(
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyTextColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          _videoCallButton(),
          SizedBox(width: 5.w),
          _audioCallButton()
        ],
      ),
    );
  }

  String getCallStatus() {
    if (index == 0) {
      return 'missed call';
    }
    if (index == 2) {
      return 'outgoing call';
    }
    return 'incoming call';
  }

  Widget getCallImage() {
    if (index == 0) {
      return Image.asset(
        AppImages.icIncomingCall,
        height: 13.w,
        width: 13.w,
        color: AppColors.redColor,
      );
    }
    if (index == 2) {
      return Image.asset(
        AppImages.icOutgoingCall,
        height: 14.w,
        width: 14.w,
      );
    }
    return Image.asset(
      AppImages.icIncomingCall,
      height: 14.w,
      width: 14.w,
    );
  }

  Widget _videoCallButton() {
    return IconButtonShadow(
        containerHeight: 33,
        containerWidth: 33,
        iconSize: 22,
        icon: Icons.videocam_outlined,
        iconColor: AppColors.blueTextColor,
        onPressed: () {
          Get.toNamed(Routes.incomingCallScreen);
        },
        backgroundColor: AppColors.greyColorF2F2F2,
        shadowColor: AppColors.transparent);
  }

  Widget _audioCallButton() {
    return IconButtonShadow(
        containerHeight: 33,
        containerWidth: 33,
        iconSize: 15,
        iconImage: AppImages.icTabCall,
        iconColor: AppColors.blueTextColor,
        onPressed: () {},
        backgroundColor: AppColors.greyColorF2F2F2,
        shadowColor: AppColors.transparent);
  }
}
