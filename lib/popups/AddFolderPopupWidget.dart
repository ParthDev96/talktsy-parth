import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/widgets/custom_button.dart';
import 'package:talktsy/widgets/text_input_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AddFolderModalController extends GetxController {
  TextEditingController nameController = TextEditingController();

  RxString selectedValue = 'Option 1'.obs;
  List<String> dropdownItems = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }
}

class AddFolderPopupWidget extends StatefulWidget {
  const AddFolderPopupWidget({super.key});

  @override
  State<AddFolderPopupWidget> createState() => _AddFolderModalState();
}

class _AddFolderModalState extends State<AddFolderPopupWidget> {
  final AddFolderModalController addFolderModalController =
      Get.put(AddFolderModalController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            color: AppColors.whiteColor
                .withOpacity(0), // Necessary to enable the blur effect
          ),
        ),
        // Dialog
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextWidget(
                      text: L10n.of(Get.context!)?.addFolder ?? "",
                      textStyle: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: 10.h),
                    _nameTextField(),
                    SizedBox(height: 18.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: L10n.of(Get.context!)?.cancel ??
                                  "".toUpperCase(),
                              textStyle: TextStyle(color: AppColors.whiteColor),
                              backgroundColor: AppColors.inputHintColor,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: L10n.of(Get.context!)?.create ??
                                  "".toUpperCase(),
                              textStyle: TextStyle(color: AppColors.whiteColor),
                              backgroundColor: AppColors.greenColor,
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _nameTextField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextWidget(
        text: L10n.of(Get.context!)?.name ?? "",
        textStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.greyTextColor),
      ),
      Container(
        margin: EdgeInsets.only(top: 3.h),
        child: TextInputWidget(
          controller: addFolderModalController.nameController,
          onChanged: (value) {},
          hintText: L10n.of(Get.context!)?.name ?? "",
          mainContainerSize: 45,
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.h),
          borderRadius: 10,
        ),
      ),
      SizedBox(height: 5.h),
      TextWidget(
        text: L10n.of(Get.context!)?.destination ?? "",
        textStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.greyTextColor),
      ),
      Obx(() => Container(
            height: 37.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyTextColor),
              borderRadius: BorderRadius.circular(10.h),
            ),
            padding: EdgeInsets.symmetric(horizontal: 13.h),
            margin: EdgeInsets.only(top: 3.h),
            child: DropdownButton<String>(
              value: addFolderModalController.selectedValue.value,
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 20.h,
              style: TextStyle(
                  color: AppColors.blueTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
              underline: Container(
                height: 0,
              ),
              isExpanded: true,
              onChanged: (String? newValue) {
                addFolderModalController.setSelectedValue(newValue!);
              },
              items: addFolderModalController.dropdownItems
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ))
    ]);
  }
}
