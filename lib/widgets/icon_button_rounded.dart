import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/config/app_dialogs.dart';

class IconButtonRounded extends StatelessWidget {
  final IconData? icon;
  final String? iconImage;
  final VoidCallback onPressed;
  final double? borderRadius;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? iconSize;
  final double? containerHeight;
  final double? containerWidth;
  final bool isLoading;

  const IconButtonRounded({
    super.key,
    this.icon = Icons.arrow_forward,
    this.iconImage,
    required this.onPressed,
    this.borderRadius = 32.0,
    this.iconColor = AppColors.whiteColor,
    this.backgroundColor = AppColors.greenColor,
    this.iconSize = 22,
    this.containerHeight = 50,
    this.containerWidth = 50,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight?.h,
      width: containerWidth?.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius!.h)),
          color: backgroundColor),
      child: TextButton(
        onPressed: onPressed,
        child: isLoading
            ? AppDialogs.progressDialog()
            : iconImage != null
                ? Image.asset(iconImage!,
                    width: iconSize?.h, height: iconSize?.h, color: iconColor)
                : Icon(
                    icon,
                    color: iconColor,
                    size: iconSize?.h,
                  ),
      ),
    );
  }
}
