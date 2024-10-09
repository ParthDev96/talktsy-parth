import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/settings/settings_controller.dart';
import 'package:talktsy/widgets/icon_button_rounded.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.settings ?? "",
          onBackButtonPressed: () {
            Get.back();
          },
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.notificationListScreen);
                },
                icon: Image.asset(
                  AppImages.icNotification,
                  color: AppColors.greenColor,
                  height: 18.w,
                  width: 18.w,
                ))
          ],
          mainContainerPadding: EdgeInsets.only(right: 10.w, left: 3.w)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IconTextButton(
              text: L10n.of(context)?.accountAndProfile ?? "",
              iconImage: AppImages.icUserIcon,
              onPressed: () {
                Get.toNamed(Routes.accountAndProfileScreen);
              },
              leading: Icon(
                Icons.arrow_forward_ios,
                size: 12.w,
                color: AppColors.inputHintColor,
              ),
            ),
            IconTextButton(
              text: L10n.of(context)?.language ?? "",
              icon: Icons.language,
              onPressed: () {},
              leading: TextWidget(
                text: 'English',
                textStyle: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor),
              ),
            ),
            IconTextButton(
              text: L10n.of(context)?.calling ?? "",
              icon: Icons.call_outlined,
              onPressed: () {},
              leading: Obx(() => Switch(
                    value: settingsController.callingSwitch.value,
                    onChanged: settingsController.onCallingSwitchChange,
                    activeColor: AppColors.whiteColor,
                    inactiveThumbColor: AppColors.whiteColor,
                    activeTrackColor: AppColors.greenColor,
                    inactiveTrackColor:
                        AppColors.greyTextColor.withOpacity(0.2),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    thumbColor: WidgetStateProperty.resolveWith((states) {
                      return AppColors
                          .whiteColor; // Thumb color when switch is off
                    }),
                    trackOutlineColor:
                        WidgetStateProperty.all(AppColors.transparent),
                  )),
            ),
            IconTextButton(
                text: L10n.of(context)?.messaging ?? "",
                iconImage: AppImages.icTabChat,
                onPressed: () {},
                leading: Obx(() => Switch(
                      value: settingsController.messagingSwitch.value,
                      onChanged: settingsController.onMessagingSwitchChange,
                      activeColor: AppColors.whiteColor,
                      inactiveThumbColor: AppColors.whiteColor,
                      activeTrackColor: AppColors.greenColor,
                      inactiveTrackColor:
                          AppColors.greyTextColor.withOpacity(0.2),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      thumbColor: WidgetStateProperty.resolveWith((states) {
                        return AppColors
                            .whiteColor; // Thumb color when switch is off
                      }),
                      trackOutlineColor:
                          WidgetStateProperty.all(AppColors.transparent),
                    ))),
            IconTextButton(
                text: L10n.of(context)?.notifications ?? "",
                iconImage: AppImages.icNotification,
                onPressed: () {},
                leading: Obx(() => Switch(
                      value: settingsController.notificationsSwitch.value,
                      onChanged: settingsController.onNotificationsSwitchChange,
                      activeColor: AppColors.whiteColor,
                      inactiveThumbColor: AppColors.whiteColor,
                      activeTrackColor: AppColors.greenColor,
                      inactiveTrackColor:
                          AppColors.greyTextColor.withOpacity(0.2),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      thumbColor: WidgetStateProperty.resolveWith((states) {
                        return AppColors
                            .whiteColor; // Thumb color when switch is off
                      }),
                      trackOutlineColor:
                          WidgetStateProperty.all(AppColors.transparent),
                    ))),
            IconTextButton(
              text: L10n.of(context)?.contacts ?? "",
              iconImage: AppImages.icBookContent,
              onPressed: () {
                Get.toNamed(Routes.contactsScreen);
              },
              leading: Icon(
                Icons.arrow_forward_ios,
                size: 12.w,
                color: AppColors.inputHintColor,
              ),
            ),
            IconTextButton(
              text: L10n.of(context)?.customerSupport ?? "",
              iconImage: AppImages.icSupport,
              onPressed: () {},
              leading: Row(
                children: [
                  chatButtonWidget(),
                  SizedBox(width: 5.w),
                  callButtonWidget()
                ],
              ),
            ),
            IconTextButton(
              text: L10n.of(context)?.privacyPolicy ?? "",
              icon: Icons.lock_outline,
              onPressed: () {
                Get.toNamed(Routes.webViewScreen, arguments: {
                  'title': L10n.of(context)?.privacyPolicy ?? "",
                  'url': 'https://www.example.com'
                });
              },
              leading: Icon(
                Icons.arrow_forward_ios,
                size: 12.w,
                color: AppColors.inputHintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chatButtonWidget() {
    return IconButtonRounded(
        onPressed: () {},
        iconImage: AppImages.icTabChat,
        backgroundColor: AppColors.greyColorF2F2F2,
        iconColor: AppColors.blueTextColor,
        containerHeight: 38,
        containerWidth: 38,
        borderRadius: 20,
        iconSize: 17);
  }

  Widget callButtonWidget() {
    return IconButtonRounded(
        onPressed: () {},
        iconImage: AppImages.icTabCall,
        backgroundColor: AppColors.greyColorF2F2F2,
        iconColor: AppColors.blueTextColor,
        containerHeight: 38,
        containerWidth: 38,
        borderRadius: 20,
        iconSize: 17);
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
  final Widget? leading;

  const IconTextButton({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.iconColor = AppColors.greenColor,
    this.iconSize = 18,
    this.iconImage,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = DefaultTextStyle.of(context).style.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        );

    return Container(
      height: 57.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.h, color: AppColors.greyColorF2F2F2),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          overlayColor: AppColors.transparent,
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            iconImage != null
                ? Image.asset(iconImage!,
                    width: iconSize?.h, height: iconSize?.h, color: iconColor)
                : Icon(
                    icon,
                    color: iconColor,
                    size: iconSize?.h,
                  ),
            SizedBox(width: 20.w),
            Expanded(
              child: TextWidget(
                text: text,
                textStyle: defaultStyle.merge(textStyle),
              ),
            ),
            SizedBox(width: 10.w),
            leading != null ? leading! : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
