import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/navigator/bottom_navigator/bottom_tab_navigator_controller.dart';
import 'package:talktsy/screens/bottom_tab_screens/calls/calls_screen.dart';
import 'package:talktsy/screens/bottom_tab_screens/chat/chat_list_screen.dart';
import 'package:talktsy/screens/bottom_tab_screens/files/files_screen.dart';
import 'package:talktsy/screens/bottom_tab_screens/meetings/meetings_screen.dart';
import 'package:talktsy/screens/bottom_tab_screens/profile/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class BottomTabNavigator extends StatefulWidget {
  const BottomTabNavigator({super.key});

  @override
  State<BottomTabNavigator> createState() => _BottomTabNavigatorState();
}

class _BottomTabNavigatorState extends State<BottomTabNavigator> {
  BottomTabNavigatorController bottomNavigationController =
      Get.put(BottomTabNavigatorController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set your desired status bar color
      statusBarIconBrightness: Brightness.dark, // Set icon brightness
    ));

    return Scaffold(
      // extendBody: true,
      backgroundColor: AppColors.whiteColor,
      body: Obx(() => SafeArea(
            child: IndexedStack(
              index: bottomNavigationController.bottomNavIndex.value,
              children: const [
                ChatListScreen(),
                FilesScreen(),
                CallsScreen(),
                MeetingsScreen(),
                ProfileScreen(),
              ],
            ),
          )),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.greyTextColor,
                blurRadius: 5,
                offset: Offset(0.0, 4),
              )
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.whiteColor,
            type: BottomNavigationBarType.fixed,
            useLegacyColorScheme: false,
            unselectedLabelStyle: TextStyle(
                color: AppColors.inputHintColor,
                fontSize: 9.sp,
                fontWeight: FontWeight.w500),
            selectedLabelStyle: TextStyle(
                color: AppColors.greenColor,
                fontSize: 9.sp,
                fontWeight: FontWeight.w500),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: renderInActiveIcon(AppImages.icTabChat),
                activeIcon: renderActiveIcon(AppImages.icTabChat),
                label: L10n.of(Get.context!)?.chat ?? "",
              ),
              BottomNavigationBarItem(
                icon: renderInActiveIcon(AppImages.icTabFiles),
                activeIcon: renderActiveIcon(AppImages.icTabFiles),
                label: L10n.of(Get.context!)?.files ?? "",
              ),
              BottomNavigationBarItem(
                icon: renderInActiveIcon(AppImages.icTabCall),
                activeIcon: renderActiveIcon(AppImages.icTabCall),
                label: L10n.of(Get.context!)?.calls ?? "",
              ),
              BottomNavigationBarItem(
                icon: renderInActiveIcon(AppImages.icTabMeetings),
                activeIcon: renderActiveIcon(AppImages.icTabMeetings),
                label: L10n.of(Get.context!)?.meetings ?? "",
              ),
              BottomNavigationBarItem(
                icon: renderInActiveIcon(AppImages.icUserIcon),
                activeIcon: renderActiveIcon(AppImages.icUserIcon),
                label: L10n.of(Get.context!)?.profile ?? "",
              ),
            ],
            currentIndex: bottomNavigationController.bottomNavIndex.value,
            // selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  Widget renderInActiveIcon(String icon) {
    return Container(
        width: 22.w,
        height: 22.w,
        margin: EdgeInsets.symmetric(vertical: 4.h),
        child: Image.asset(icon, color: AppColors.inputHintColor));
  }

  Widget renderActiveIcon(String icon) {
    return Container(
        width: 22.w,
        height: 22.w,
        margin: EdgeInsets.symmetric(vertical: 4.h),
        child: Image.asset(
          icon,
          color: AppColors.greenColor,
        ));
  }

  void _onItemTapped(int index) {
    bottomNavigationController.tabChangeIndex(index);
  }
}
