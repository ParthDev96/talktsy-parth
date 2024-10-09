import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_fonts.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/routes/app_routes.dart';
import 'package:talktsy/screens/login/login_controller.dart';
import 'package:talktsy/widgets/custom_button.dart';
import 'package:talktsy/widgets/icon_button_rounded.dart';
import 'package:talktsy/widgets/text_input_widget.dart';
import 'package:talktsy/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set your desired status bar color
      statusBarIconBrightness: Brightness.dark, // Set icon brightness
    ));

    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: safePadding.top + 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset(AppImages.icLoginLogo,
                        width: 175.r, height: 175.r)),
                Container(
                    margin: EdgeInsets.only(top: 40.w, left: 25.w, right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            text:
                                '${L10n.of(context)?.helloThere ?? ""},'),
                        TextWidget(
                          text: L10n.of(context)?.loginIntoTalktsy ?? "",
                          textStyle: LoginStyles.loginIntoTextStyle,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        _emailTextField(),
                        SizedBox(
                          height: 10.h,
                        ),
                        _passwordTextField(),
                        Align(
                            alignment: Alignment.centerRight,
                            child: CustomButton(
                                onPressed: () {},
                                text:
                                    L10n.of(context)?.forgotPassword ?? "",
                                textStyle: LoginStyles.passwordTextStyle)),
                        SizedBox(
                          height: 16.h,
                        ),
                        Obx(() => Center(
                              child: IconButtonRounded(
                                isLoading: loginController.isLoading.value,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  loginController.onLoginTap(context);
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
                                        '${L10n.of(context)?.notAMember ?? ""} ',
                                    style: LoginStyles.notMemberTextStyle),
                                TextSpan(
                                    text:
                                        L10n.of(context)?.signUpNow ?? "",
                                    style: LoginStyles.signUpTextStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(
                                          Routes.signupScreen,
                                        );
                                      }),
                              ])),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextInputWidget(
      controller: loginController.emailController,
      onChanged: (value) {
        loginController.checkWellKnownWithCoolDown(value, context);
      },
      hintText: L10n.of(context)?.fullName ?? "",
      prefixIconImage: AppImages.icUserIcon,
    );
  }

  Widget _passwordTextField() {
    return TextInputWidget(
      controller: loginController.passwordController,
      onChanged: (value) {},
      hintText: L10n.of(context)?.password ?? "",
      prefixIcon: Icons.lock_outline,
      obscureText: true,
    );
  }
}

class LoginStyles {
  static TextStyle loginIntoTextStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyTextColor,
  );
  static TextStyle signUpTextStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.greenColor,
  );
  static TextStyle notMemberTextStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyTextColor,
  );
  static const TextStyle passwordTextStyle = TextStyle(
    color: AppColors.greenColor,
  );
}
