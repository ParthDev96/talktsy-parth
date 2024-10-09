import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:talktsy/screens/contacts/contacts_controller.dart';
import 'package:talktsy/widgets/icon_button_shadow.dart';
import 'package:talktsy/widgets/search_input_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  ContactsController contactsController = Get.put(ContactsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.contacts ?? "",
          subTitleText: L10n.of(context)?.contactAvailable ?? "",
          subTitleCountText: '102',
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
          onBackButtonPressed: () {
            Get.back();
          },
          mainContainerPadding: EdgeInsets.only(right: 7.w, left: 4.w)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.whiteColor,
        margin: EdgeInsets.only(top: 8.h),
        child: Column(
          children: [
            SearchInputWidget(
                controller: contactsController.searchText, verticalPadding: 5),
            Expanded(
              child: ListView.builder(
                itemCount: contactsController.users.length,
                itemBuilder: (context, index) {
                  return const UserListItem();
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
  const UserListItem({super.key});

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
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor),
                ),
                Row(
                  children: [
                    Icon(Icons.call_outlined,
                        color: AppColors.inputHintColor, size: 12.w),
                    SizedBox(width: 2.w),
                    TextWidget(
                      text: '+91 433-426-0546',
                      textStyle: TextStyle(
                          fontSize: 10.sp,
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
