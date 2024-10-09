import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/signup/signup_controller.dart';
import 'package:talktsy/widgets/border_button.dart';
import 'package:talktsy/widgets/icon_button_rounded.dart';
import 'package:talktsy/widgets/phone_input_widget.dart';
import 'package:talktsy/widgets/text_input_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return scaffoldWidget();
  }

  Widget scaffoldWidget() {
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: safePadding.top + 8.h, left: 30.w, right: 30.w),
        color: AppColors.whiteColor,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: '${L10n.of(context)?.getStarted ?? ""},',
                textStyle: SignupStyles.titleTextStyle,
              ),
              TextWidget(
                text: L10n.of(context)?.signupSubTitleText ?? "",
                textStyle: SignupStyles.subTitleTextStyle,
              ),
              SizedBox(
                height: 25.h,
              ),
              _nameTextField(),
              SizedBox(
                height: 15.h,
              ),
              _emailTextField(),
              SizedBox(
                height: 15.h,
              ),
              _passwordTextField(),
              SizedBox(
                height: 15.h,
              ),
              _conPasswordTextField(),
              SizedBox(
                height: 15.h,
              ),
              _phoneNumberTextField(),
              SizedBox(
                height: 15.h,
              ),
              BorderButton(
                onPressed: () {
                  Get.toNamed(Routes.translationLanguageScreen);
                },
                text: L10n.of(context)?.selectLanguage ?? "",
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(() => Center(
                    child: IconButtonRounded(
                      isLoading: signupController.isLoading.value,
                      onPressed: () {
                        signupController.onRegisterTap();
                      },
                    ),
                  )),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: AppColors.blueTextColor,
                            fontFamily: AppFonts.hkGrotesk),
                        children: <TextSpan>[
                      TextSpan(
                          text:
                              '${L10n.of(context)?.alreadyAMember ?? ""} ',
                          style: SignupStyles.alreadyMemberTextStyle),
                      TextSpan(
                          text: L10n.of(context)?.login ?? "",
                          style: SignupStyles.loginTextStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            }),
                    ])),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextInputWidget(
      controller: signupController.nameTextController,
      onChanged: (value) {},
      hintText: L10n.of(context)?.fullName ?? "",
      prefixIconImage: AppImages.icUserIcon,
    );
  }

  Widget _emailTextField() {
    return TextInputWidget(
      controller: signupController.emailTextController,
      onChanged: (value) {},
      hintText: L10n.of(context)?.emailId ?? "",
      prefixIcon: Icons.drafts_outlined,
    );
  }

  Widget _passwordTextField() {
    return TextInputWidget(
      controller: signupController.passwordTextController,
      onChanged: (value) {},
      hintText: L10n.of(context)?.password ?? "",
      prefixIcon: Icons.lock_outline,
      obscureText: true,
    );
  }

  Widget _conPasswordTextField() {
    return TextInputWidget(
      controller: signupController.conPasswordTextController,
      onChanged: (value) {},
      hintText: L10n.of(context)?.confirmPassword ?? "",
      prefixIcon: Icons.lock_outline,
      obscureText: true,
    );
  }

  Widget _phoneNumberTextField() {
    return PhoneInputWidget(
        focusNode: signupController.focusNode,
        controller: signupController.controllers,
        selectorNavigator: signupController.selectorNavigator,
        mobileOnly: false,
        locale: signupController.locale,
        hintText: L10n.of(context)?.enterMobileNumber ?? "");
  }
}

class SignupStyles {
  static TextStyle loginTextStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.greenColor,
  );
  static TextStyle alreadyMemberTextStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyTextColor,
  );
  static TextStyle titleTextStyle = TextStyle(
      fontSize: 21.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor);
  static TextStyle subTitleTextStyle = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor);
}
