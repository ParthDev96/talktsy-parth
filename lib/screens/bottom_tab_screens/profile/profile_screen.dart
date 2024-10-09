import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/bottom_tab_screens/profile/profile_screen_controller.dart';
import 'package:get/get.dart';
import 'package:talktsy/widgets/avatar.dart';
import 'package:talktsy/widgets/matrix.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenController profileScreenController =
      Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.profile ?? "",
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.accountAndProfileScreen);
                },
                icon: Image.asset(AppImages.icEdit,
                    color: AppColors.greenColor, width: 23.w, height: 23.w))
          ],
          mainContainerPadding: EdgeInsets.only(left: 18.w, right: 5.w)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Obx(() => FutureBuilder<Profile>(
                        future: profileScreenController.profileFuture.value,
                        builder: (context, snapshot) {
                          final profile = snapshot.data;
                          final mxId = Matrix.of(context).client.userID ??
                              L10n.of(context)!.user;
                          final displayName =
                              profile?.displayName ?? mxId.localpart ?? mxId;
                          return Row(
                            children: [
                              Stack(
                                children: [
                                  Avatar(
                                    mxContent: profile?.avatarUrl,
                                    name: displayName,
                                    size: Avatar.defaultSize * 2,
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: displayName,
                                      overflow: TextOverflow.ellipsis,
                                      textStyle: TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 3.w),
                                    Row(
                                      children: [
                                        // Image.asset(AppImages.icTabCall,
                                        //     width: 14.w,
                                        //     height: 14.w,
                                        //     color: AppColors.inputHintColor),
                                        // SizedBox(width: 5.w),
                                        TextWidget(
                                          text: mxId,
                                          textStyle: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.greyTextColor),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      )),
                ),
                SizedBox(height: 15.h),
                Obx(() => Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Row(
                        children: [
                          Container(
                            width: 17.h,
                            height: 17.h,
                            margin: EdgeInsets.only(right: 20.w),
                            decoration: BoxDecoration(
                                color: getStatusColor(profileScreenController
                                    .selectedValue.value),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.w))),
                          ),
                          Expanded(
                            child: DropdownButton<TypeUserStatus>(
                              value:
                                  profileScreenController.selectedValue.value,
                              icon: Icon(Icons.keyboard_arrow_down,
                                  size: 15.w, color: AppColors.greyTextColor),
                              iconSize: 20.h,
                              style: TextStyle(
                                  color: AppColors.blueTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp),
                              underline: Container(
                                height: 0,
                              ),
                              isExpanded: true,
                              onChanged: (TypeUserStatus? newValue) {
                                profileScreenController
                                    .updateDropdownItem(newValue!);
                              },
                              items: profileScreenController.dropdownItems
                                  .map<DropdownMenuItem<TypeUserStatus>>(
                                      (TypeUserStatus option) {
                                return DropdownMenuItem<TypeUserStatus>(
                                  value: option,
                                  child: Row(
                                    children: <Widget>[
                                      TextWidget(
                                          text: option.statusName,
                                          textStyle: TextStyle(
                                              color: AppColors.blueTextColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.sp)),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    )),
                Divider(
                  height: 3.h,
                ),
                SizedBox(height: 5.h),
                IconTextButton(
                    text: L10n.of(context)?.inviteFriends ?? "",
                    iconImage: AppImages.icPersonGroup,
                    onPressed: () {
                      Get.toNamed(Routes.inviteFriendsScreen);
                    }),
                IconTextButton(
                    text: L10n.of(context)?.blockUnblock ?? "",
                    icon: Icons.block_flipped,
                    onPressed: () {
                      Get.toNamed(Routes.blockUnblockContactsScreen);
                    }),
                IconTextButton(
                    text: L10n.of(context)?.settings ?? "",
                    icon: Icons.settings_outlined,
                    onPressed: () {
                      Get.toNamed(Routes.settingsScreen);
                    }),
                IconTextButton(
                    text: L10n.of(context)?.about ?? "",
                    icon: Icons.info_outline,
                    onPressed: () {
                      Get.toNamed(
                        Routes.faqScreen,
                      );
                    }),
                IconTextButton(
                  text: L10n.of(context)?.logout ?? "",
                  iconImage: AppImages.icLogout,
                  onPressed: () {
                    profileScreenController.onLogoutPress(context);
                  },
                  iconColor: AppColors.redColorD86666,
                  textStyle: const TextStyle(color: AppColors.redColorD86666),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getStatusColor(TypeUserStatus? item) {
    if (item != null) {
      if (item.status == 'busy') {
        return AppColors.redColorD86666;
      }
      if (item.status == 'online') {
        return AppColors.greenColor;
      }
      if (item.status == 'in_meeting') {
        return AppColors.greyColor4F4F4F;
      }
    }
    return AppColors.redColorD86666;
  }
}

class IconTextButton extends StatelessWidget {
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final String? iconImage;

  const IconTextButton({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.iconColor = AppColors.greenColor,
    this.iconSize = 22,
    this.iconImage,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = DefaultTextStyle.of(context).style.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        );

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding:
            EdgeInsets.only(top: 20.w, bottom: 15.w, left: 20.w, right: 20.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          iconImage != null
              ? Image.asset(iconImage!,
                  width: iconSize.h, height: iconSize.h, color: iconColor)
              : Icon(
                  icon,
                  color: iconColor,
                  size: iconSize.h,
                ),
          SizedBox(width: 15.w),
          Expanded(
            child: TextWidget(
              text: text,
              textStyle: defaultStyle.merge(textStyle),
            ),
          ),
        ],
      ),
    );
  }
}
