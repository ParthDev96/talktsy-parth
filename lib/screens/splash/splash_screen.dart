import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_images.dart';
import 'package:talktsy/screens/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set your desired status bar color
      statusBarIconBrightness: Brightness.light, // Set icon brightness
    ));

    return Container(
      color: AppColors.primaryColor,
      child: Center(
        child:  Container(
            width: 200.w,
            height: 200.w,
            child: Image.asset(AppImages.icLogoWhite))
      ),
    );
  }
}
