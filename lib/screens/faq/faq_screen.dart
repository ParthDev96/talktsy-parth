import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/screens/faq/faq_controller.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  FaqController faqController = Get.put(FaqController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          onBackButtonPressed: () {
            Get.back();
          },
          titleText: 'FAQ’s'.tr,
          mainContainerPadding: EdgeInsets.only(right: 7.w)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: L10n.of(context)?.questions ?? "",
                    textStyle: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  TextWidget(
                    text: L10n.of(context)?.frequentlyAskedByUsers ?? "",
                    textStyle: TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              color: AppColors.greyTextColor.withOpacity(0.2),
              height: 1,
            ),
            Obx(() => ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.symmetric(vertical: 5.h),
                elevation: 0,
                materialGapSize: 0,
                dividerColor: AppColors.greyTextColor.withOpacity(0.2),
                animationDuration: const Duration(milliseconds: 400),
                expansionCallback: (int index, bool isExpanded) {
                  faqController.toggleExpand(index);
                },
                children: faqController.data.map<ExpansionPanel>((Item item) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: item.isExpanded
                        ? AppColors.greyColorF2F2F2
                        : AppColors.whiteColor,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 5.h),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: TextWidget(
                            text: item.headerValue,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                color: !item.isExpanded
                                    ? AppColors.blueTextColor
                                    : AppColors.greenColor),
                          ),
                        ),
                      );
                    },
                    body: Column(
                      children: [
                        ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.w),
                          title: TextWidget(
                            text: item.expandedValue,
                            textStyle: TextStyle(
                                color: AppColors.blueTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(
                          color: AppColors.greyTextColor.withOpacity(0.2),
                          height: 1,
                        ),
                      ],
                    ),
                    isExpanded: item.isExpanded,
                  );
                }).toList())),
          ],
        ),
      ),
    );
  }
}
