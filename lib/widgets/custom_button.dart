import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talktsy/config/app_colors.dart';
import 'package:talktsy/widgets/text_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final EdgeInsets? buttonPadding;
  final Color? backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double containerHeight;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor,
      this.textStyle,
      this.borderColor = AppColors.whiteColor,
      this.borderRadius = 8.0,
      this.borderWidth = 0,
      this.containerHeight = 35,
      this.buttonPadding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style.copyWith(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        );

    return SizedBox(
      height: containerHeight.h,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: buttonPadding,
            side: BorderSide(color: borderColor, width: borderWidth.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.h),
            ),
            splashFactory: NoSplash.splashFactory),
        child: TextWidget(
            text: text, textStyle: defaultTextStyle.merge(textStyle)),
      ),
    );
  }
}
