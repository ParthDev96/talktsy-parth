import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';

class IconButtonShadow extends StatelessWidget {
  final IconData? icon;
  final String? iconImage;
  final VoidCallback onPressed;
  final Color iconColor;
  final double iconSize;
  final double containerHeight;
  final double containerWidth;
  final double shadowBlurRadius;
  final double borderWidth;
  final Offset shadowOffset;
  final Color shadowColor;
  final Color backgroundColor;
  final Color borderColor;

  const IconButtonShadow({
    super.key,
    this.icon,
    this.iconImage,
    required this.onPressed,
    this.iconColor = AppColors.whiteColor,
    this.backgroundColor = AppColors.greenColor,
    this.iconSize = 24.0,
    this.shadowBlurRadius = 4.0,
    this.borderWidth = 0,
    this.containerHeight = 35.0,
    this.containerWidth = 35.0,
    this.shadowOffset = const Offset(0, 2),
    this.shadowColor = AppColors.greenColor,
    this.borderColor = AppColors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight.h,
      width: containerWidth.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: shadowBlurRadius,
              offset: shadowOffset,
            ),
          ],
          border: Border.all(width: borderWidth, color: borderColor)),
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          icon: iconImage != null
              ? Image.asset(iconImage!,
                  width: iconSize?.h, height: iconSize?.h, color: iconColor)
              : Icon(icon),
          color: iconColor,
          iconSize: iconSize,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
