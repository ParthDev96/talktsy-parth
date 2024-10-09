import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/meetings/schedule_meeting/schedule_meeting_controller.dart';
import 'package:talktsy/widgets/search_input_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  const ScheduleMeetingScreen({super.key});

  @override
  State<StatefulWidget> createState() => ScheduleMeetingState();
}

class ScheduleMeetingState extends State<ScheduleMeetingScreen> {
  ScheduleMeetingController scheduleMeetingController =
      Get.put(ScheduleMeetingController());

  final List<Map<String, String>> items = [
    {
      'title': 'Daily Standups Talktsy',
      'subtitle': 'Fri, 10:30 - 10:45 AM',
    },
    {
      'title': 'Daily Standups Talktsy',
      'subtitle': 'Fri, 10:30 - 10:45 AM',
    },
    {
      'title': 'Daily Standups Talktsy',
      'subtitle': 'Fri, 10:30 - 10:45 AM',
    },
    {
      'title': 'Daily Standups Talktsy',
      'subtitle': 'Fri, 10:30 - 10:45 AM',
    },
    {
      'title': 'Daily Standups Talktsy',
      'subtitle': 'Fri, 10:30 - 10:45 AM',
    },
    {
      'title': 'Daily Standups Talktsy',
      'subtitle': 'Fri, 10:30 - 10:45 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.scheduleMeeting ?? "",
          subTitleCountText: '3',
          subTitleText: L10n.of(context)?.meetingsSchedule ?? "",
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.addEditMeetingScreen);
                },
                icon: const Icon(Icons.add, color: AppColors.greenColor))
          ],
          onBackButtonPressed: () {
            Get.back();
          },
          mainContainerPadding: EdgeInsets.only(right: 10.w, left: 3.w)),
      body: Container(
        color: AppColors.whiteColor,
        child: Column(
          children: [
            SearchInputWidget(controller: scheduleMeetingController.searchText),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CustomListItem(
                    title: items[index]['title']!,
                    subtitle: items[index]['subtitle']!,
                    onEditPressed: () {
                      Get.toNamed(Routes.addEditMeetingScreen);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onEditPressed;

  const CustomListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          EdgeInsets.only(left: 20.w, right: 10.w, top: 5.w, bottom: 5.w),
      leading: Container(
        width: 45.w,
        height: 45.w,
        decoration: const BoxDecoration(
          color: AppColors.lightGreenColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.event,
          color: AppColors.greenColor,
          size: 15.h,
        ),
      ),
      title: TextWidget(
        text: title,
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: AppColors.blackColor),
      ),
      subtitle: TextWidget(
        text: subtitle,
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 10.sp,
            color: AppColors.greyTextColor),
      ),
      trailing: IconButton(
        alignment: Alignment.centerRight,
        icon: Image.asset(AppImages.icEdit, height: 18.w, width: 18.w),
        onPressed: onEditPressed,
      ),
    );
  }
}
