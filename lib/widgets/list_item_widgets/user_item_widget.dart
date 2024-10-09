import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/widgets/text_widget.dart';

class UserItemWidget extends StatelessWidget {
  final TypeUser user;
  final Function(bool isSelected, TypeUser user)? onPressCheck;

  const UserItemWidget({super.key, required this.user, this.onPressCheck});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: GestureDetector(
        onTap: () {
          user.isSelected.value = !user.isSelected.value;
          if (onPressCheck != null) {
            onPressCheck!(user.isSelected.value, user);
          }
        },
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
                    text: user.name,
                    textStyle: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  TextWidget(
                    text: user.subTitle,
                    textStyle: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyTextColor),
                  ),
                ],
              ),
            ),
            Obx(() => Center(
                    child: InkWell(
                  onTap: () {
                    user.isSelected.value = !user.isSelected.value;
                    if (onPressCheck != null) {
                      onPressCheck!(user.isSelected.value, user);
                    }
                  },
                  child: Container(
                    height: 18.h,
                    width: 18.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: user.isSelected.value
                            ? AppColors.greenColor
                            : AppColors.greyColorF2F2F2),
                    child: user.isSelected.value
                        ? Icon(
                            Icons.check,
                            size: 13.r,
                            color: AppColors.whiteColor,
                          )
                        : null,
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}
