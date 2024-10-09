import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/screens/block_unblock_contacts/block_unblock_contacts_controller.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class BlockUnblockContactsScreen extends StatefulWidget {
  const BlockUnblockContactsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BlockUnblockContactsScreenState();
}

class _BlockUnblockContactsScreenState
    extends State<BlockUnblockContactsScreen> {
  BlockUnblockContactsController blockUnblockContactsController =
      Get.put(BlockUnblockContactsController());

  Map<int, Widget> buildTabs(int selectedSegment) {
    return <int, Widget>{
      0: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        child: TextWidget(
          text: L10n.of(context)?.allContact ?? "",
          textStyle: TextStyle(
            fontSize: 13.sp,
            color: selectedSegment == 0
                ? AppColors.whiteColor
                : AppColors.blackColor,
          ),
        ),
      ),
      1: Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          child: TextWidget(
            text: L10n.of(context)?.blocked ?? "",
            textStyle: TextStyle(
              fontSize: 13.sp,
              color: selectedSegment == 1
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            ),
          )),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          onBackButtonPressed: () {
            Get.back();
          },
          titleText: L10n.of(Get.context!)?.contacts ?? "",
          mainContainerPadding: EdgeInsets.only(right: 7.w)),
      body: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Obx(() => Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: CupertinoSlidingSegmentedControl<int>(
                  padding: EdgeInsets.all(2.h),
                  thumbColor: AppColors.greenColor,
                  backgroundColor: AppColors.lightGreyColor.withOpacity(0.3),
                  groupValue:
                      blockUnblockContactsController.selectedSegment.value,
                  children: buildTabs(
                      blockUnblockContactsController.selectedSegment.value),
                  onValueChanged: (int? i) {
                    if (i != null) {
                      blockUnblockContactsController.onSegmentChange(i);
                    }
                  },
                ),
              )),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: blockUnblockContactsController.users.length,
              itemBuilder: (context, index) {
                return UserItemWidget(
                  user: blockUnblockContactsController.users[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class UserItemWidget extends StatelessWidget {
  final TypeUser user;
  final Function(bool isSelected, TypeUser user)? onPressCheck;

  const UserItemWidget({super.key, required this.user, this.onPressCheck});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 10.w),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(AppImages.tempGirl),
            radius: 20.r,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: TextWidget(
              text: user.name,
              textStyle:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: AppColors.greyTextColor,
                size: 18.h,
              ))
        ],
      ),
    );
  }
}
