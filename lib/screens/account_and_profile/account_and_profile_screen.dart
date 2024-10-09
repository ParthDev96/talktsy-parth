import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/helpers/image_picker_helper.dart';
import 'package:talktsy/screens/account_and_profile/account_and_profile_controller.dart';
import 'package:talktsy/widgets/custom_button.dart';
import 'package:talktsy/widgets/phone_input_widget.dart';
import 'package:talktsy/widgets/submit_button_widget.dart';
import 'package:talktsy/widgets/tab_header_widget.dart';
import 'package:talktsy/widgets/text_input_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AccountAndProfileScreen extends StatefulWidget {
  const AccountAndProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AccountAndProfileScreenState();
}

class _AccountAndProfileScreenState extends State<AccountAndProfileScreen> {
  AccountAndProfileController accountAndProfileController =
      Get.put(AccountAndProfileController());
  final ImagePickerHelper imagePickerHelper = ImagePickerHelper();

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      appBar: TabHeaderWidget(
          titleText: L10n.of(Get.context!)?.accountAndProfile ?? "",
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check, color: AppColors.greenColor))
          ],
          onBackButtonPressed: () {
            Get.back();
          },
          mainContainerPadding: EdgeInsets.only(right: 10.w, left: 3.w)),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: L10n.of(Get.context!)?.profile ?? "",
                      textStyle: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    TextWidget(
                      text: L10n.of(Get.context!)
                              ?.thisInformationWeBeDisplayedPublicly ??
                          "",
                      textStyle: TextStyle(
                          color: AppColors.greyTextColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    _nameTextField(),
                    SizedBox(
                      height: 15.h,
                    ),
                    _usernameTextField(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(() => _profileViewWidget()),
                    SizedBox(
                      height: 20.h,
                    ),
                    _genderViewWidget(),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextWidget(
                      text: L10n.of(Get.context!)?.about ?? "",
                      textStyle: AccountProfileStyles.titleStyle,
                    ),
                    SizedBox(height: 7.w),
                    TextField(
                      decoration: InputDecoration(
                        hintText: L10n.of(Get.context!)?.addDescription ?? "",
                        hintStyle: const TextStyle(color: AppColors.blackColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.blueTextColor, width: 1.h),
                          borderRadius: BorderRadius.circular(10.h),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.inputHintColor, width: 1.h),
                          borderRadius: BorderRadius.circular(10.h),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: 3,
                      autofocus: false,
                      controller:
                          accountAndProfileController.addTitleTextController,
                      cursorColor: AppColors.blueTextColor,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blueTextColor,
                          fontFamily: AppFonts.hkGrotesk),
                    ),
                    SizedBox(height: 15.w),
                    Divider(color: AppColors.greyColorF2F2F2),
                    SizedBox(height: 10.w),
                    TextWidget(
                      text: L10n.of(Get.context!)?.personalInformation ?? "",
                      textStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor),
                    ),
                    SizedBox(height: 20.w),
                    TextWidget(
                      text: L10n.of(Get.context!)?.emailAddress ?? "",
                      textStyle: AccountProfileStyles.titleStyle,
                    ),
                    SizedBox(height: 8.w),
                    TextInputWidget(
                      controller:
                          accountAndProfileController.emailTextController,
                      onChanged: (value) {},
                      hintText: L10n.of(Get.context!)?.enterEmailAddress ?? "",
                      mainContainerSize: 40,
                      borderRadius: 10,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.h),
                      inActiveBorderColor: AppColors.inputHintColor,
                    ),
                    SizedBox(height: 20.w),
                    TextWidget(
                      text: L10n.of(Get.context!)?.phoneNumber ?? "",
                      textStyle: AccountProfileStyles.titleStyle,
                    ),
                    SizedBox(height: 8.w),
                    _phoneNumberTextField(),
                    SizedBox(height: 20.w),
                    TextWidget(
                      text: L10n.of(Get.context!)?.address ?? "",
                      textStyle: AccountProfileStyles.titleStyle,
                    ),
                    SizedBox(height: 8.w),
                    TextInputWidget(
                      controller:
                          accountAndProfileController.addressTextController,
                      onChanged: (value) {},
                      hintText: L10n.of(Get.context!)?.enterAddress ?? "",
                      mainContainerSize: 40,
                      borderRadius: 10,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.h),
                      inActiveBorderColor: AppColors.inputHintColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: safePadding.bottom),
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
              onPressed: () {
                accountAndProfileController.onSaveInformationTap();
              },
              text: L10n.of(Get.context!)?.saveInformation ?? "",
            ),
          )
        ],
      ),
    );
  }

  Widget _phoneNumberTextField() {
    return PhoneInputWidget(
        focusNode: accountAndProfileController.focusNode,
        controller: accountAndProfileController.controllers,
        selectorNavigator: accountAndProfileController.selectorNavigator,
        mobileOnly: false,
        showFlag: false,
        inActiveBorderColor: AppColors.inputHintColor,
        locale: accountAndProfileController.locale,
        borderRadius: 10,
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        countryButtonContentPadding:
            EdgeInsets.symmetric(vertical: 13.h, horizontal: 15.w),
        hintText: L10n.of(Get.context!)?.enterMobileNumber ?? "");
  }

  Widget _genderViewWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: L10n.of(Get.context!)?.gender ?? "",
          textStyle: AccountProfileStyles.titleStyle,
        ),
        SizedBox(height: 7.w),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: _renderGenderButton(
                    accountAndProfileController.maleGenderSelected.value,
                    L10n.of(Get.context!)?.male ?? "", () {
                  accountAndProfileController.onChangeGender(true);
                }),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: _renderGenderButton(
                    !accountAndProfileController.maleGenderSelected.value,
                    L10n.of(Get.context!)?.female ?? "", () {
                  accountAndProfileController.onChangeGender(false);
                }),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _renderGenderButton(bool isSelected, String text, Function onPress) {
    return TextButton(
        onPressed: () {
          onPress();
        },
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            side: BorderSide(color: AppColors.inputHintColor, width: 1.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.h),
            ),
            splashFactory: NoSplash.splashFactory),
        child: Container(
          height: 37.h,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 3.w,
                      color: AppColors.greyColorF2F2F2.withOpacity(0.5)),
                ),
                child: Container(
                  height: 16.h,
                  width: 16.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.greenColor
                          : AppColors.greyColorF2F2F2),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 13.r,
                          color: AppColors.whiteColor,
                        )
                      : null,
                ),
              ),
              SizedBox(width: 10.w),
              TextWidget(
                text: text,
                textStyle:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
              )
            ],
          ),
        ));
  }

  Widget _profileViewWidget() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage:
              accountAndProfileController.editImage.value == true &&
                      accountAndProfileController.pickImageFiles != null
                  ? FileImage(
                      File(accountAndProfileController.pickImageFiles!.path))
                  : null,
          radius: 40.r,
          backgroundColor: AppColors.greyColorF2F2F2,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.5,
            child: accountAndProfileController.editImage.value == true &&
                    accountAndProfileController.pickImageFiles != null
                ? null
                : Image.asset(AppImages.icUserIcon),
          ),
        ),
        SizedBox(
          width: 15.h,
        ),
        CustomButton(
          onPressed: () {
            imagePickerHelper.showImagePickerOptions(context, (File imageFile) {
              accountAndProfileController.editImage.value = true;
              accountAndProfileController.pickImageFiles = imageFile;
            });
          },
          text: L10n.of(Get.context!)?.change ?? "",
          textStyle: TextStyle(
              color: AppColors.greenColor,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp),
          // backgroundColor: AppColors.inputHintColor,
          borderColor: AppColors.greenColor,
          borderWidth: 1.h,
          containerHeight: 30,
          buttonPadding: EdgeInsets.symmetric(horizontal: 14.w),
        ),
        SizedBox(
          width: 15.h,
        ),
        CustomButton(
          onPressed: () {
            accountAndProfileController.onRemoveProfileImage();
          },
          text: L10n.of(Get.context!)?.remove ?? "",
          textStyle: TextStyle(
              color: AppColors.blueTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp),
          // backgroundColor: AppColors.inputHintColor,
          borderColor: AppColors.inputHintColor,
          borderWidth: 1.h,
          containerHeight: 30,
          buttonPadding: EdgeInsets.symmetric(horizontal: 14.w),
        )
      ],
    );
  }

  Widget _nameTextField() {
    return TextInputWidget(
      controller: accountAndProfileController.nameTextController,
      onChanged: (value) {},
      hintText: L10n.of(Get.context!)?.fullName ?? "",
      mainContainerSize: 40,
      contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
      inActiveBorderColor: AppColors.inputHintColor,
      borderRadius: 10,
    );
  }

  Widget _usernameTextField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputHintColor, width: 1.h),
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.greyColorF2F2F2,
              borderRadius: BorderRadius.circular(8.h),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
              child: TextWidget(
                text: L10n.of(Get.context!)?.username ?? "",
                textStyle: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.greyTextColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            child: TextInputWidget(
              controller: accountAndProfileController.usernameTextController,
              onChanged: (value) {},
              hintText: '',
              mainContainerSize: 38,
              activeBorderColor: AppColors.transparent,
              inActiveBorderColor: AppColors.transparent,
            ),
          )
        ],
      ),
    );
  }
}

class AccountProfileStyles {
  static TextStyle titleStyle = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.blackColor);
}
