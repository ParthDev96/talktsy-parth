import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_dialogs.dart';
import 'package:talktsy/config/app_fonts.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/popups/confirmation_popup.dart';
import 'package:talktsy/screens/notification_list/notification_list_controller.dart';
import 'package:talktsy/widgets/custom_button.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  NotificationListController notificationListController =
      Get.put(NotificationListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.notifications ?? "",
          onBackButtonPressed: () {
            Get.back();
          },
          mainContainerPadding: EdgeInsets.only(right: 10.w, left: 3.w)),
      body: ListView.separated(
        itemCount: notificationListController.notifications.length,
        separatorBuilder: (context, index) =>
            Divider(color: AppColors.greyColorF6F6F6, height: 2.h),
        itemBuilder: (context, index) {
          return NotificationItem(
            notificationsItem: notificationListController.notifications[index],
            index: index,
            onAcceptReject: (isAccept) {
              onAcceptRejectGroup(isAccept);
            },
          );
        },
      ),
    );
  }

  void onAcceptRejectGroup(bool isAccept) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.greyTextColor.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return ConfirmationPopup(
          title: isAccept
              ? L10n.of(context)?.acceptGroup ?? ""
              : L10n.of(context)?.rejectGroup ?? "",
          message: isAccept
              ? L10n.of(context)?.acceptGroupConfirmation ?? ""
              : L10n.of(context)?.rejectGroupConfirmation ?? "",
          cancelButtonTitle: L10n.of(context)?.no ?? "",
          confirmButtonTitle: L10n.of(context)?.yes ?? "",
          onConfirm: () {
            AppDialogs.showToast(
                message: isAccept
                    ? L10n.of(context)?.groupRequestAccepted ?? ""
                    : L10n.of(context)?.groupRequestRejected ?? "");
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}

class NotificationItem extends StatelessWidget {
  final TypeNotification notificationsItem;
  final int index;
  final void Function(bool)? onAcceptReject;

  const NotificationItem(
      {super.key,
      required this.notificationsItem,
      required this.index,
      this.onAcceptReject});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.w),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(AppImages.tempGirl),
                  radius: 20.r,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: RichText(
                      maxLines: 4,
                      text: TextSpan(
                          style: TextStyle(
                              color: AppColors.blueTextColor,
                              fontFamily: AppFonts.hkGrotesk),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Tatiana',
                                style: NotificationStyles.boldTextStyle),
                            TextSpan(
                              text: ' Created a group meet for ',
                              style: NotificationStyles.regularTextStyle,
                            ),
                            TextSpan(
                                text: 'UI/UX Design',
                                style: NotificationStyles.boldTextStyle),
                            TextSpan(
                                text: ' Discussion',
                                style: NotificationStyles.regularTextStyle),
                          ])),
                ),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    TextWidget(
                        text: '14.50',
                        textStyle: NotificationStyles.timeTextStyle),
                    SizedBox(height: 5.w),
                    rightIconWidget(),
                  ],
                )
              ],
            ),
            if (notificationsItem.isShowAcceptReject) SizedBox(height: 10.w),
            if (notificationsItem.isShowAcceptReject)
              Row(
                children: [
                  CustomButton(
                    containerHeight: 24,
                    borderRadius: 20,
                    buttonPadding: EdgeInsets.symmetric(horizontal: 17.h),
                    onPressed: () {
                      if (onAcceptReject != null) {
                        onAcceptReject!(true);
                      }
                    },
                    text: L10n.of(context)?.accept ?? "",
                    textStyle: TextStyle(color: AppColors.whiteColor),
                    backgroundColor: AppColors.greenColor,
                  ),
                  SizedBox(width: 10.w),
                  CustomButton(
                    containerHeight: 24,
                    borderRadius: 20,
                    buttonPadding: EdgeInsets.symmetric(horizontal: 17.h),
                    onPressed: () {
                      if (onAcceptReject != null) {
                        onAcceptReject!(false);
                      }
                    },
                    borderWidth: 1,
                    borderColor: AppColors.inputHintColor,
                    text: L10n.of(context)?.reject ?? "",
                    textStyle: TextStyle(color: AppColors.greyTextColor),
                    // backgroundColor: AppColors.greenColor,
                  )
                ],
              )
          ],
        ));
  }

  Widget rightIconWidget() {
    IconData icon = Icons.videocam;
    Color bgColor = AppColors.greenColor;

    if (index == 1) {
      icon = Icons.favorite;
      bgColor = AppColors.redColorD86666;
    } else if (index == 2) {
      icon = Icons.show_chart;
      bgColor = AppColors.yellowColor;
    } else if (index == 4) {
      icon = Icons.thumb_up_alt_outlined;
      bgColor = AppColors.blueColor;
    } else if (index == 5) {
      icon = Icons.person;
      bgColor = AppColors.blueTextColor;
    } else if (index == 6) {
      icon = Icons.public;
      bgColor = AppColors.greyTextColor;
    }

    return Container(
        height: 23.w,
        width: 23.w,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(40.w)),
        child:
            Center(child: Icon(color: AppColors.whiteColor, icon, size: 12.w)));
  }
}

class NotificationStyles {
  static TextStyle timeTextStyle = TextStyle(
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.greyTextColor,
  );
  static TextStyle boldTextStyle = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
      height: 1.5);
  static TextStyle regularTextStyle = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor,
      height: 1.5);
}
