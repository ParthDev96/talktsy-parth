import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/verification/verification_controller.dart';
import 'package:get/get.dart';
import 'package:talktsy/widgets/icon_button_rounded.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  VerificationController verificationController =
      Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget();
  }

  Widget ScaffoldWidget() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: TextWidget(
            text: 'Verification', textStyle: VerificationStyles.headerTitle),
        titleSpacing: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.whiteColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              loadImage(),
              const VerificationMessageWidget(
                phoneNumber: '********55',
                email: 'sa****@gmail.com',
              ),
              renderPinView(),
              Center(
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: AppColors.blueTextColor,
                            fontFamily: AppFonts.hkGrotesk),
                        children: <TextSpan>[
                      TextSpan(
                          text:
                              '${L10n.of(context)?.didNotReceivedCode ?? ""} ',
                          style: VerificationStyles.alreadyMemberTextStyle),
                      TextSpan(
                          text: L10n.of(context)?.requestAgain ?? "",
                          style: VerificationStyles.loginTextStyle,
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ])),
              ),
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: IconButtonRounded(
                  onPressed: () {
                    Get.offNamed(
                      Routes.bottomNavigationScreen,
                    );
                  },
                ),
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

  Widget loadImage() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.w),
        child: Image.asset(AppImages.icVerification));
  }

  Widget renderPinView() {
    return Padding(
      padding:
          EdgeInsets.only(left: 28.w, right: 28.w, top: 25.w, bottom: 10.w),
      child: Form(
        key: verificationController.otpFormKey,
        child: PinCodeTextField(
          appContext: context,
          pastedTextStyle: const TextStyle(
            color: AppColors.whiteColor,
          ),
          length: 6,
          obscureText: false,
          blinkWhenObscuring: false,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              fieldHeight: 45.w,
              fieldWidth: 45.w,
              selectedColor: AppColors.blueTextColor,
              inactiveColor: AppColors.greyTextColor,
              activeBoxShadow: [],
              inActiveBoxShadow: []),
          hintCharacter: '0',
          cursorColor: AppColors.blueTextColor,
          enableActiveFill: false,
          onSaved: (value) {
            verificationController.otp = value!;
          },
          validator: (value) {
            return verificationController.validateOtp(value!);
          },
          textStyle: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blueTextColor,
              fontFamily: AppFonts.hkGrotesk),
          controller: verificationController.otpTextEditingController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            debugPrint(value);
          },
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            return true;
          },
        ),
      ),
    );
  }
}

class VerificationStyles {
  static TextStyle loginTextStyle = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.greenColor);
  static TextStyle alreadyMemberTextStyle = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor);
  static TextStyle headerTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );
  static TextStyle boldMessageText = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12.sp,
      fontFamily: AppFonts.hkGrotesk);
  static TextStyle normalMessageText = TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor,
      fontSize: 12.sp,
      fontFamily: AppFonts.hkGrotesk);
}

class VerificationMessageWidget extends StatelessWidget {
  final String phoneNumber;
  final String email;

  const VerificationMessageWidget({
    super.key,
    required this.phoneNumber,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 28.w, right: 28.w, top: 10.w),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: L10n.of(context)?.verificationMessage1 ?? "",
          style: VerificationStyles.normalMessageText,
          children: [
            TextSpan(
              text: phoneNumber,
              style: VerificationStyles.boldMessageText,
            ),
            TextSpan(
              text: L10n.of(context)?.verificationMessage2 ?? "",
            ),
            TextSpan(
              text: email,
              style: VerificationStyles.boldMessageText,
            ),
            TextSpan(
              text: L10n.of(context)?.verificationMessage3 ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
