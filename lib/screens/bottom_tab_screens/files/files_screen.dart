import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/popups/AddFolderPopupWidget.dart';
import 'package:talktsy/screens/bottom_tab_screens/files/files_screen_controller.dart';
import 'package:talktsy/widgets/search_input_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  FilesScreenController filesScreenController =
      Get.put(FilesScreenController());
  final List _elements = [
    {'name': 'AndAfile.pdf', 'group': 'A'},
    {'name': 'Adam_resume.doc', 'group': 'B'},
    {'name': 'AndAfile.pdf', 'group': 'A'},
    {'name': 'Adam_resume.doc', 'group': 'B'},
    {'name': 'AndAfile.pdf', 'group': 'C'},
    {'name': 'AndAfile.pdf', 'group': 'C'},
    {'name': 'AndAfile.pdf', 'group': 'D'},
    {'name': 'Adam_resume.doc', 'group': 'D'},
    {'name': 'AndAfile.pdf', 'group': 'D'},
    {'name': 'AndAfile.pdf', 'group': 'E'},
    {'name': 'Adam_resume.doc', 'group': 'E'},
    {'name': 'AndAfile.pdf', 'group': 'E'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(context)?.files ?? "",
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_outlined,
                    color: AppColors.blueTextColor))
          ],
          mainContainerPadding: EdgeInsets.only(left: 18.w, right: 5.w)),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.whiteColor,
          child: Column(
            children: [
              SearchInputWidget(
                  controller: filesScreenController.searchText,
                  verticalPadding: 5),
              rowButtonsWidget(),
              Expanded(child: sectionListWidget())
            ],
          )),
      floatingActionButton: SizedBox(
        height: 40.w,
        width: 40.w,
        child: FloatingActionButton(
          onPressed: () {
            _showModal(context);
          },
          backgroundColor: AppColors.greenColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Icon(Icons.add, color: AppColors.whiteColor, size: 17.w),
        ),
      ),
    );
  }

  Widget rowButtonsWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.cloud_upload_outlined,
                color: AppColors.blueTextColor, size: 15.w),
            label: TextWidget(
                text: L10n.of(context)?.upload ?? "",
                textStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                )),
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 1.w, color: AppColors.inputHintColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.w),
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {
              _showModal(context);
            },
            icon: Image.asset(
              AppImages.icCreateFolder,
              height: 15.w,
              width: 15.w,
            ),
            label: TextWidget(
                text: L10n.of(context)?.folder ?? "",
                textStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                )),
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 1.w, color: AppColors.inputHintColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.w),
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.qr_code_scanner,
                color: AppColors.blueTextColor, size: 15.w),
            label: TextWidget(
                text: L10n.of(context)?.scan ?? "",
                textStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                )),
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 1.w, color: AppColors.inputHintColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.w),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionListWidget() {
    return GroupedListView<dynamic, String>(
      elements: _elements,
      groupBy: (element) => element['group'],
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (String value) => Container(
        color: AppColors.whiteColor,
        padding: EdgeInsets.only(top: 10.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          child: TextWidget(
            text: value,
            textStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.greyTextColor),
          ),
        ),
      ),
      itemBuilder: (c, element) {
        return Container(
          color: AppColors.whiteColor,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
          child: SizedBox(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: leadingWidget(),
              title: TextWidget(
                text: element['name'],
                textStyle:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
              ),
              subtitle: TextWidget(
                text: element['name'],
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                    color: AppColors.greyTextColor),
              ),
              trailing:
                  const Icon(Icons.more_horiz, color: AppColors.greyTextColor),
            ),
          ),
        );
      },
      separator: Container(
        height: 1,
        color: AppColors.inputHintColor,
      ),
    );
  }

  Widget leadingWidget() {
    return SizedBox(
      width: 32.w,
      height: 32.w,
      child: Image.asset(AppImages.icPdf, width: 32.h, height: 32.h),
    );
  }

  void _showModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.greyTextColor.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return const AddFolderPopupWidget();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}

class FilesScreenStyle {
  static TextStyle rowButtonText = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
  );
}
