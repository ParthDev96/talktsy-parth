import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/config/app_types.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/meetings/add_edit_meeting/add_edit_meeting_controller.dart';
import 'package:talktsy/widgets/submit_button_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_input_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AddEditMeetingScreen extends StatefulWidget {
  const AddEditMeetingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddEditMeetingScreenState();
}

class _AddEditMeetingScreenState extends State<AddEditMeetingScreen> {
  final AddEditMeetingController addEditMeetingController =
      Get.put(AddEditMeetingController());
  final List<TypePerson> names = [
    TypePerson(id: 0, name: "You"),
    TypePerson(id: 1, name: "Prameshwar Kumar"),
    TypePerson(id: 2, name: "Surya"),
    TypePerson(id: 3, name: "Charlie"),
    TypePerson(id: 4, name: "David"),
    TypePerson(id: 5, name: "Eve"),
    TypePerson(id: 6, name: "Frank"),
  ];

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.addOrEditMeeting ?? "",
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check, color: AppColors.greenColor))
          ],
          onBackButtonPressed: () {
            Get.back();
          },
          mainContainerPadding: EdgeInsets.only(right: 10.w, left: 3.w)),
      body: Container(
        color: AppColors.whiteColor,
        padding: EdgeInsets.only(top: 10.h, bottom: safePadding.bottom),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _addTitleTextField(),
                    addDaysWidget(),
                    addPeopleWidget(),
                    addTimeWidget(),
                    addDiscriptionWidget()
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyTextColor.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, -2), // changes position of shadow
                  ),
                ],
              ),
              child: SubmitButtonWidget(
                onPressed: () {},
                text: L10n.of(context)?.save ?? "",
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _addTitleTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextInputWidget(
          controller: addEditMeetingController.addTitleTextController,
          onChanged: (value) {},
          hintText: L10n.of(context)?.addTitle ?? "",
          mainContainerSize: 45,
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.h),
          inputFontSize: 15),
    );
  }

  Widget _addDescriptionTextField() {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: L10n.of(context)?.addDescription ?? "",
        hintStyle: const TextStyle(color: AppColors.blackColor),
      ),
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 6,
      autofocus: false,
      controller: addEditMeetingController.addDescTextController,
      style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.blueTextColor,
          fontFamily: AppFonts.hkGrotesk),
    );
  }

  Widget addDaysWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: AppColors.greyColor4F4F4F.withOpacity(0.1),
                  width: 1.h))),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.watch_later_outlined,
                size: 17.w,
                color: AppColors.greenColor,
              ),
              SizedBox(width: 20.w),
              TextWidget(
                text: L10n.of(context)?.allDay ?? "",
                textStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor),
              ),
              Spacer(),
              Obx(
                () => Switch(
                  value: addEditMeetingController.allDaySwitchValue.value,
                  onChanged: addEditMeetingController.onAllDaySwitchChange,
                  activeColor: AppColors.whiteColor,
                  inactiveThumbColor: AppColors.whiteColor,
                  activeTrackColor: AppColors.greenColor,
                  inactiveTrackColor: AppColors.greyTextColor.withOpacity(0.2),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  thumbColor: WidgetStateProperty.resolveWith((states) {
                    return AppColors
                        .whiteColor; // Thumb color when switch is off
                  }),
                  trackOutlineColor:
                      WidgetStateProperty.all(AppColors.transparent),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.w),
          addDaysSelectedDatesWidget(),
          addDaysSelectedDatesWidget(),
        ],
      ),
    );
  }

  Widget addPeopleWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: AppColors.greyColor4F4F4F.withOpacity(0.1),
                  width: 1.h))),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.addPeopleScreen);
            },
            child: Row(
              children: [
                Image.asset(AppImages.icPersonAdd, height: 17.w, width: 17.w),
                SizedBox(width: 20.w),
                TextWidget(
                  text: L10n.of(context)?.addPeople ?? "",
                  textStyle: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.w),
          Container(
            margin: EdgeInsets.only(left: 37.w, top: 5.w),
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8.w, // Space between each name
              runSpacing: 6.h, // Space between rows
              alignment: WrapAlignment.start,
              children: names.map((pItem) {
                return pItem.id == 0
                    ? addPeopleCurrentUserItem(pItem)
                    : addPeopleSelectedUserItem(pItem);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget addTimeWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: AppColors.greyColor4F4F4F.withOpacity(0.1),
                  width: 1.h))),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(AppImages.icNotification, height: 17.w, width: 17.w),
              SizedBox(width: 20.w),
              TextWidget(
                text: '10 ${L10n.of(context)?.minutesBefore ?? ""}',
                textStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget addDiscriptionWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: AppColors.greyColor4F4F4F.withOpacity(0.1),
                  width: 1.h))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 11.h),
                  child:
                      Image.asset(AppImages.icMenu, height: 17.w, width: 17.w)),
              SizedBox(width: 20.w),
              Expanded(child: _addDescriptionTextField())
            ],
          ),
        ],
      ),
    );
  }

  Widget addPeopleCurrentUserItem(TypePerson pItem) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.greenColor,
          border: Border(
            bottom: BorderSide(color: AppColors.blueTextColor, width: 2.r),
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.r))),
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
      child: TextWidget(
          text: pItem.name,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              color: AppColors.whiteColor)),
    );
  }

  Widget addPeopleSelectedUserItem(TypePerson pItem) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.greyColorF2F2F2,
          border: Border(
            bottom: BorderSide(color: AppColors.greyTextColor, width: 2.r),
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.r))),
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
      child: TextWidget(
          text: pItem.name,
          textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
              color: AppColors.blackColor)),
    );
  }

  Widget addDaysSelectedDatesWidget() {
    return Container(
      margin: EdgeInsets.only(left: 37.w, top: 10.w),
      child: Row(
        children: [
          TextWidget(
            text: 'Thursday, 25 Aug',
            textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor),
          ),
          Spacer(),
          TextWidget(
            text: '10 PM',
            textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor),
          ),
        ],
      ),
    );
  }
}
